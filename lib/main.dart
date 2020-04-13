import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelreservation/Common/theme.dart';
import 'package:hotelreservation/Screens/SplashScreen/splash_screen.dart';

void main() => runApp(HotelConceptApp());

class HotelConceptApp extends StatefulWidget {
  @override
  _HotelConceptAppState createState() => _HotelConceptAppState();
}

class _HotelConceptAppState extends State<HotelConceptApp> {
 
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black.withAlpha(50),
        statusBarIconBrightness: Brightness.light));
    final themeData = HotelConceptThemeProvider.get();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeData,
      home: SplashScreen()
    );
  }
}
