import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/constan.dart';
import 'package:project_udemy/models/shop_app/search_model.dart';
import 'package:project_udemy/moudules/shop_app/search/cubit/states.dart';
import 'package:project_udemy/network/end_point.dart';
import 'package:project_udemy/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get (context)=>BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text,
        }
    ).then((value) {

      model=SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      emit(SearchErrorState());

    });
  }



}