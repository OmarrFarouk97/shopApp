
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/models/shop_app/login_model.dart';
import 'package:project_udemy/moudules/shop_app/login/cubit/states.dart';
import 'package:project_udemy/network/end_point.dart';
import 'package:project_udemy/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=> BlocProvider.of(context);

 ShopLoginModel? loginModel ;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      // deh l endpont bt3ty
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value)
    {
     // print(value.data['message']);
      // print(value.data['status']);
     loginModel= ShopLoginModel.fromJson(value.data);
     // print(loginModel.data.email);
     //   print(loginModel.message);
     //    print(loginModel.status);
     //   print(loginModel.data.phone);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

 IconData suffix= Icons.visibility ;
  bool isPassword=true;
  void changePasswordVisibility ()
  {
    suffix =isPassword ?Icons.visibility_off_outlined  :Icons.visibility   ;
    isPassword =!isPassword;
    emit(ShopChangePasswordVisibilityState());

  }
}
