import 'package:flutter/material.dart';
import 'package:shop_app/login_screen/login_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/chace_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  List<BoardingModel> boardingModel = [
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'Screen title 1',
      body: 'Screen body 1',
    ),
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'Screen title 2',
      body: 'Screen body 2',
    ),
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'Screen title 3',
      body: 'Screen body 3',
    ),
  ];
bool isLast = false;
void isSubmmited (){
  ChaceHelper.saveData(key: 'onBoarding', value: true,).then((value){
    if(value){navigateToAndRemove(context , LoginScreen());}
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTExtButton(
            onPressed: isSubmmited,
          text: 'skip',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == boardingModel.length-1){
                    setState(() {
                      isLast= true;
                    });
                  }else {
                      isLast= false;
                  }
                },
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardingModel[index]),
                itemCount: boardingModel.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4.0,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast==false){
                      boardingController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }else {
                      isSubmmited();
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

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),

          Text(
            model.title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 19.0,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          // PageView.builder(itemBuilder: (context , index)=>{}),
        ],
      );
}
