import 'package:flutter/material.dart';
import 'package:flutter_chat_bot_task/MyColors.dart';
import 'package:flutter_chat_bot_task/views/splash.dart';
import 'Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: color1,
          accentColor: color1,
          textTheme: const TextTheme(
            bodyText1: TextStyle(
                color: color1,
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700),
          )),
      title: 'ChatBot',
      debugShowCheckedModeBanner: false,
      //initialRoute:Star.route,
      home:  const SplashScreen(),
      routes: routes,
    );
  }

}
