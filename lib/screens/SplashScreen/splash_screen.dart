import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hotelreservation/animations/fadeAnimation.dart';
import 'package:hotelreservation/screens/HomeScreen/home_screen.dart';
import 'dart:async';
import 'package:hotelreservation/screens/LoginScreen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // SharedPreferences initializeToken;

  @override
  void initState() {
    super.initState();
    
    // checkLoginStatus();
    navigateToLogin();
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

  // checkLoginStatus() async {

  //   initializeToken = await SharedPreferences.getInstance();
  //   if (initializeToken.getString("authtoken") == null) {
  //     navigateToLogin();
  //   } 
  //   else 
  //   {
  //     initializeToken = await SharedPreferences.getInstance();
  //     final _token = initializeToken.getString("authtoken");
  //     print(_token);
  //     navigateToHome();
  //   }
  // }



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
                FadeAnimation(1.5,Text(" .වළව්ව", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                )))
          ],
        ),
      ),
    );
  }
}
