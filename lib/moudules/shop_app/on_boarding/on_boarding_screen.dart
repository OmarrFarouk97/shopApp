import 'package:flutter/material.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/moudules/shop_app/login/shop_login_screen.dart';
import 'package:project_udemy/moudules/shop_app/search/search_screen.dart';
import 'package:project_udemy/network/local/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../styles/colors.dart';

class BordingModel {
  final String image;
  final String title;
  final String body;

  BordingModel({required this.image, required this.title, required this.body});
}

class OnBoradingScreen extends StatefulWidget
{
  @override
  State<OnBoradingScreen> createState() => _OnBoradingScreenState();
}

class _OnBoradingScreenState extends State<OnBoradingScreen> {
  //3shan at7km fel zorar eno yn2lne mn bordingmodel le boardingmodel tania
  var boardController= PageController();

  List<BordingModel> boarding = [
    BordingModel(
      image: 'assets/images/onboard.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BordingModel(
      image: 'assets/images/onboard.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BordingModel(
      image: 'assets/images/onboard.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];
  bool isLast = false;

  // h3ml method 3daia shyla l navigate bs ha7otha fe mot8er
  // 3shan h7ot feha kman enha t3ml save fel cache helper
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if (value)
      {
        navigateAndFinish(context, ShopLoginScreen(),);
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextBottom(
            function:
              submit,
            text: 'Skip',
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index==boarding.length -1)
                  {
                    setState(()
                    {
                      isLast=true;
                    });
                  }else
                    {

                      setState(()
                      {
                        isLast=false;
                      });
                    }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defualtColor,

                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    }else
                      {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BordingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage('${model.image}'),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 30.0),

        ],
      );
}
