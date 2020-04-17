import 'package:flutter/material.dart';
import 'package:hotelreservation/Screens/HomeScreen/Home_widgets/bottom_nav_bar.dart';
import 'package:hotelreservation/Screens/HomeScreen/Home_widgets/hotel_cards.dart';
import 'package:hotelreservation/utils/loading_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences logininit;
  String _searchText;

  Widget _buildHeader() {
    return Positioned(
      top: 30,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Hello User !',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
            ),
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  border: Border.all(width: 2.0, color: Colors.blue)),
              child: IconButton(
                icon:Icon(Icons.exit_to_app,
                size: 25,
                color: Color(0xFFFB8C00)), 
                onPressed: () {
                  logOut();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  logOut() async {
    SharedPreferences logininit = await SharedPreferences.getInstance();
    logininit.remove("token");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext ctx) =>  LoggingOut()));
  }

  Widget _buildBody() {
    return Builder(
      builder: (BuildContext context) {
        return Positioned(
          top: 90,
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Discover',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                  Text(
                    'Suitable Hotel',
                    style: TextStyle(
                      fontSize: 35.0,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFe2d7f5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xff7645c7),
                                ),
                                hintText: 'Find a good hotel',
                                hintStyle: TextStyle(
                                  color: Color(0xff7645c7),
                                  fontWeight: FontWeight.bold,
                                )),
                            onChanged: (String value) {
                              _searchText = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // if(_searchText != null){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResult(realEstatesResult)));
                          // }
                        },
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        splashColor: Color(0xff7645c7),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            color: Color(0xFFe2d7f5),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Color(0xff7645c7),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // renderHotelCards(),
                  HotelCards(),
                  BottomNavBar(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xFFFFA726),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
          ],
        ));
  }
}
