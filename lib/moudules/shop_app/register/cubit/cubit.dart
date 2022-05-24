import 'package:flutter/material.dart';
import 'package:project_udemy/moudules/shop_app/register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/models/shop_app/login_model.dart';
import 'package:project_udemy/network/end_point.dart';
import 'package:project_udemy/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=> BlocProvider.of(context);

 ShopLoginModel? RegisterModel ;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      // deh l endpont bt3ty
        url: REGISTER,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,

        },
    ).then((value)
    {
     // print(value.data['message']);
      // print(value.data['status']);
     RegisterModel= ShopLoginModel.fromJson(value.data);
     // print(RegisterModel.data.email);
     //   print(RegisterModel.message);
     //    print(RegisterModel.status);
     //   print(RegisterModel.data.phone);

      emit(ShopRegisterSuccessState(RegisterModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

 IconData suffix= Icons.visibility ;
  bool isPassword=true;
  void changePasswordVisibility ()
  {
    suffix =isPassword ?Icons.visibility_off_outlined  :Icons.visibility   ;
    isPassword =!isPassword;
    emit(ShopRegisterChangePasswordVisibilityState());

  }
}
