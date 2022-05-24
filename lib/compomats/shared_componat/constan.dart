//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=07927204d7c44b0bb87eff653e18e862

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=us&category=business&apiKey=07927204d7c44b0bb87eff653e18e862


//https://newsapi.org/v2/everything?q=apple&apiKey=07927204d7c44b0bb87eff653e18e862


import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/moudules/shop_app/login/shop_login_screen.dart';
import 'package:project_udemy/network/local/shared_preferences.dart';


void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    if (value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String? token ='';





