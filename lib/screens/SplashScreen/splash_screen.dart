import 'package:flutter/material.dart';
import 'package:hotelreservation/Animations/fadeAnimation.dart';
import 'package:hotelreservation/Screens/HomeScreen/home_screen.dart';
import 'dart:async';
import 'package:hotelreservation/Screens/LoginScreen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences logininit;

  @override
  void initState() {
    super.initState();
    
    checkLoginStatus();
    // navigateToLogin();
  }

  navigateToHome(){
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),
        ),
        );
      },
    );
  }

   navigateToLogin(){
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),
        ),
        );
      },
    );
  }

  checkLoginStatus() async {

    logininit = await SharedPreferences.getInstance();
    if (logininit.getString("token") == null) {
      navigateToLogin();
    } 
    else 
    {
      logininit = await SharedPreferences.getInstance();
      final _token = logininit.getString("token");
      print(_token);
      navigateToHome();
    }
  }



  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/splashBg.gif'),
                          fit: BoxFit.cover)),
                ),
                FadeAnimation(1.5,Text(" .Hotel පොත", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                )))
          ],
        ),
      ),
    );
  }
}
