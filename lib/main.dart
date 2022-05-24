import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/bloc_observer.dart';
import 'package:project_udemy/layout/shop_app/cubit/cubit.dart';
import 'package:project_udemy/layout/shop_app/cubit/states.dart';
import 'package:project_udemy/layout/shop_app/shop_layout.dart';
import 'package:project_udemy/moudules/shop_app/login/shop_login_screen.dart';
import 'package:project_udemy/styles/themes.dart';
import 'compomats/shared_componat/constan.dart';
import 'moudules/shop_app/on_boarding/on_boarding_screen.dart';
import 'network/local/shared_preferences.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // dah lazm 3sahan ana 3amlt await ll cachehelper we tlama 3mlt await lazm a3ml async lle main
  // fa lazm a3ml eli fo2 deh 3shan 3shan dah byt2ked en kul 7aga hena fel method 5last
  // we b3den y3ml run ll app

  DioHelper.init();
  await CacheHelper.init();
// Bloc.observer =MyBlocObserver();

  //deh 3shan lw 3yaz a5leh yb3t ll user eli da5l dah

  BlocOverrides.runZoned(
        () {
      // CounterCubit();

      bool? isDark = CacheHelper.getData(key: 'isDark');

      Widget? widget;

      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

       token = CacheHelper.getData(key: 'token');
      if (onBoarding != null )
      {
        if (token != null) widget = ShopLayout();

        else widget = ShopLoginScreen();
      }else{
        widget = OnBoradingScreen();
      }


      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  bool? isDark;
  Widget? startWidget;


  MyApp({ this.isDark,this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()..changeAppMode()
        ),

      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
              // ThemeMode.light,
              ShopCubit.get(context).isDark ?  ThemeMode.light : ThemeMode.dark,
              home: startWidget
          );
        },
      ),
    );
  }
}
