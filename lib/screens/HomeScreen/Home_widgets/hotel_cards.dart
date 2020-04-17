import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotelreservation/Controllers/hotel_controllers/getHotelsService.dart';
import 'package:hotelreservation/Models/hotelModel.dart';

class HotelCards extends StatefulWidget {
  HotelCards({Key key}) : super(key: key);

  @override
  _HotelCardsState createState() => _HotelCardsState();
}

class _HotelCardsState extends State<HotelCards> {
    List<Hotel> hotelsList = List();

  @override
  void initState() {
    super.initState();
    GetHotelsService.getHotels().then((hotelsFromServer) {
      setState(() {
        hotelsList = hotelsFromServer;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(hotelsList[index].hotelName);
              },
              child: Container(
                margin: const EdgeInsets.only(
                    top: 20.0, bottom: 20, left: 20, right: 20),
                child: Stack(children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.memory(
                        base64Decode(hotelsList[index].hotelImg),
                        width: 250,
                        height: 300,
                        fit: BoxFit.fill),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      height: 60,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/rated.png'),
                              fit: BoxFit.cover))),
                  Container(
                    margin: const EdgeInsets.only(left: 15, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_city,
                              color: Color(0xFFFFA726),
                            ),
                            Text(
                              hotelsList[index].hotelName,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Color(0xFFFFA726),
                            ),
                            Text(
                              hotelsList[index].location,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 13.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          },
          itemCount: hotelsList.length,
        ),
      ),
    );
  }
}