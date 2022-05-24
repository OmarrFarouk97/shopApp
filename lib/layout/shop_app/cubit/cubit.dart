import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/layout/shop_app/cubit/states.dart';
import 'package:project_udemy/models/shop_app/home_model.dart';
import 'package:project_udemy/moudules/shop_app/categories/categories_screen.dart';
import 'package:project_udemy/moudules/shop_app/favorite/favorite_screen.dart';
import 'package:project_udemy/moudules/shop_app/products/products_Screen.dart';
import 'package:project_udemy/moudules/shop_app/search/search_screen.dart';
import 'package:project_udemy/moudules/shop_app/settings/settings_screen.dart';
import '../../../compomats/shared_componat/constan.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../network/end_point.dart';
import '../../../network/local/shared_preferences.dart';
import '../../../network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProuductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
    SearchScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel?.message);
      //print(homeModel.data.banners.toString());

      homeModel?.data?.products?.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavourites(int productId) {
    //dah eli hy5ale l favo tzhr we t5tfe fe nfs l wa2t
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId
        },
      token: token,
    ).then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel!.status!)
        {
          favorites[productId]=!favorites[productId]!;
        }else
          {
            getFavorites();
          }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }
    ).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
      favorites[productId]=!favorites[productId]!;

    });
  }


  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
      print(userModel!.data!.name);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
  required String name,
  required String email,
  required String phone,
}) {


    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
      print(userModel!.data!.name);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }


  bool isDark= false;
  void changeAppMode({ bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeAppMode());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeAppMode());
      });
    }
  }

}
