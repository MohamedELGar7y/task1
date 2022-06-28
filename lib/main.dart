import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task1/onBoarding.dart';

import 'cacheHelper.dart';
import 'login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  if(onBoarding == null) {
    widget = const OnBoardingScreen();
  }else
  {
      widget=const LoginScreen();
    }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'cairo',
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            )
        ),
      ),
      home: startWidget,
    );
  }
}
