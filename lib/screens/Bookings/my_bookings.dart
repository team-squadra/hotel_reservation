import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  MyBookings({Key key}) : super(key: key);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
         child: Center(
           child:Text("My bookings")
         ),
      ),
    );
  }
}