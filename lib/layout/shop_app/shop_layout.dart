import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/layout/shop_app/cubit/cubit.dart';
import 'package:project_udemy/layout/shop_app/cubit/states.dart';
import 'package:project_udemy/moudules/shop_app/login/shop_login_screen.dart';
import 'package:project_udemy/network/local/shared_preferences.dart';

import '../../compomats/shared_componat/constan.dart';
import '../../moudules/shop_app/search/search_screen.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Mini Shop'
            ),
            actions: [
              IconButton(onPressed: ()
              {
                navigateTo(context, SearchScreen());
              },
                  icon: Icon(Icons.search)),

              IconButton(onPressed:(){
                signOut(context);
              },
                  icon: Icon(Icons.logout)),

              IconButton(onPressed: ()
              {
              ShopCubit.get(context).changeAppMode();
              }, icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
              currentIndex:cubit.currentIndex ,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'favorite'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'settings'
                ),
              ]
          ),
        );
      },

    );
  }
}
