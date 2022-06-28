import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task1/register_screen.dart';

import 'cacheHelper.dart';
import 'login_screen.dart';
class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {


  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  String titleOfBottom='Get Started';

  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/6.png',
        title: 'Joins Us Today and Earn 3 Exclusive Rewards!',
        body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen'
    ),
    BoardingModel(
        image: 'assets/images/5.png',
        title: 'Joins Us Today and Earn 3 Exclusive Rewards!',
        body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen'
    ),
    BoardingModel(
      image: 'assets/images/2.png',
      title: 'Joins Us Today and Earn 3 Exclusive Rewards!',
      body: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()
            {
              if(isLast)
              {
                submit();
              }else{
                pageController.nextPage(
                  duration: const Duration(
                    milliseconds: 750,
                  ),
                  curve:Curves.fastLinearToSlowEaseIn,
                );
              }
            },
            child: buildTextSkipItem(),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  '7',
                style: TextStyle(
                  color: HexColor('#f6d3d4'),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'krave',
                style: TextStyle(
                  color: HexColor('#1AA5B2'),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int index)
              {
                if(index==boarding.length - 1)
                {
                  print('last');
                  setState(() {
                    isLast=true;
                  });
                }else{
                  print('not last');
                  setState(() {
                    isLast=false;
                  });
                }
              },
              controller: pageController,
              itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: HexColor('#f6d3d4'),
                      spacing: 5,
                      dotHeight: 7.0,
                      dotWidth: 15.0,
                      expansionFactor: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: ()
                        {
                          if(isLast)
                          {
                            submit();
                          }else{
                            pageController.nextPage(
                              duration: const Duration(
                                milliseconds: 750,
                              ),
                              curve:Curves.fastLinearToSlowEaseIn,
                            );
                          }
                        },
                        child: Text(
                          '$titleOfBottom',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: HexColor('#1AA5B2'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return const RegisterScreen();
                                  }));
                        },
                        child: Text(
                          'sign up'.toUpperCase(),
                          style: TextStyle(
                            color: HexColor('#1AA5B2'),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value)
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context)=>  const LoginScreen(),
            ),
                (route) => false);
      }
    });
  }

  Widget buildBoardingItem(BoardingModel model) => Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              '${model.image}',
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                '${model.title}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${model.body}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ],
    ),
  );
  Widget buildTextSkipItem()=>TextButton(
    onPressed:()
    {
      submit();
    } ,
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: HexColor('#f6d3d4'),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(3.0),
        child: Center(
          child: Text(
            'Skip',
            style: TextStyle(
                color: Colors.black45
            ),
          ),
        ),
      ),
    ),
  );
}

