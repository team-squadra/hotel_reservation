import 'package:flutter/material.dart';
import 'package:hotelreservation/common/theme.dart';

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((v) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = HotelConceptThemeProvider.get();
    return Scaffold(
      body: Container(
        color: themeData.accentColor,
        child: Center(
          child: Text(
            "Booking successful",
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
      ),
    );
  }
}
