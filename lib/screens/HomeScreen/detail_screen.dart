import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hotelreservation/Common/components/home_components/parallax_page_view.dart';
import 'package:hotelreservation/Common/components/home_components/sliding_bottom_sheet.dart';
import 'package:hotelreservation/Common/icons.dart';
import 'package:hotelreservation/Common/navigation/fade_route.dart';
import 'package:hotelreservation/Common/theme.dart';
import 'package:hotelreservation/Common/widget/blur_icon.dart';
import 'package:hotelreservation/Screens/Bookings/add_booking.dart';
import 'package:hotelreservation/Screens/LoginScreen/loginScreen.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:rect_getter/rect_getter.dart';

class DetailScreen extends StatefulWidget {
  final String hotelName;
  final String imageAsset;
  final String location;
  final String description;
  final String email;
  final String phoneNum;
  final String pool;
  final String parking;
  final String spa;
  final String bar;
  final String wifi;

  DetailScreen({
    this.hotelName,
    this.imageAsset,
    this.location,
    this.description,
    this.email,
    this.phoneNum,
    this.pool,
    this.parking,
    this.spa,
    this.bar,
    this.wifi
  });

  @override
  _DetailScreenState createState() => _DetailScreenState(
    hotelName:hotelName, 
    imageAsset:imageAsset,
    location:location,
    description: description,
    email: email,
    phoneNum: phoneNum,
    pool: pool,
    parking: parking,
    spa: spa,
    bar: bar,
    wifi: wifi
    );
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {

  final String hotelName;
  final String imageAsset;
  final String location;
  final String description;
  final String email;
  final String phoneNum;
  final String pool;
  final String parking;
  final String spa;
  final String bar;
  final String wifi;    

  final double bottomSheetCornerRadius = 50;

  final Duration animationDuration = Duration(milliseconds: 600);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  _DetailScreenState({
    this.hotelName,
    this.imageAsset,
    this.location,
    this.description,
    this.email,
    this.phoneNum,
    this.pool,
    this.parking,
    this.spa,
    this.bar,
    this.wifi
  });


  static double bookButtonBottomOffset = -60;
  double bookButtonBottom = bookButtonBottomOffset;
  AnimationController _bottomSheetController;

  void _onTap() {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: LoginScreen()))
        .then((_) => setState(() => rect = null));
  }

  @override
  void initState() {
    super.initState();
    _bottomSheetController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    Future.delayed(Duration(milliseconds: 700)).then((v) {
      setState(() {
        bookButtonBottom = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = HotelConceptThemeProvider.get();
    final coverImageHeightCalc =
        MediaQuery.of(context).size.height / 2 + bottomSheetCornerRadius;
    return WillPopScope(
      onWillPop: () async {
        if (_bottomSheetController.value <= 0.5) {
          setState(() {
            bookButtonBottom = bookButtonBottomOffset;
          });
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: true, // this avoids the overflow error
      resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Container(),
            Hero(
              createRectTween: ParallaxPageView.createRectTween,
              tag: hotelName,
              child: Container(
                height: coverImageHeightCalc,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: PageIndicatorContainer(
                      align: IndicatorAlign.bottom,
                      length: 3,
                      indicatorSpace: 12.0,
                      padding: EdgeInsets.only(bottom: 60),
                      indicatorColor: themeData.indicatorColor,
                      indicatorSelectorColor: Colors.white,
                      shape: IndicatorShape.circle(size: 8),
                      child: PageView(
                        children: <Widget>[
                         Image.memory(
                        base64Decode(imageAsset),
                        fit: BoxFit.cover),
                          Image.asset(
                            "assets/images/hotel_2.jpg", // <- stubbed data
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "assets/images/hotel_3.jpg", // <- stubbed data
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Positioned(
              top: 46,
              right: 24,
              child: Hero(
                tag: "${hotelName}heart",
                child: BlurIcon(
                  icon: Icon(
                    HotelBookingConcept.ic_heart_empty,
                    color: Colors.white,
                    size: 15.2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 46,
              left: 24,
              child: Hero(
                tag: "${hotelName}chevron",
                child: GestureDetector(
                  onTap: () async {
                    await _bottomSheetController.animateTo(0,
                        duration: Duration(milliseconds: 150));
                    setState(() {
                      bookButtonBottom = bookButtonBottomOffset;
                    });
                    Navigator.pop(context);
                  },
                  child: BlurIcon(
                    icon: Icon(
                      HotelBookingConcept.ic_chevron_left,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            SlidingBottomSheet(
              controller: _bottomSheetController,
              cornerRadius: bottomSheetCornerRadius,
              hotelName: hotelName,
              location: location,
              description: description,
              email: email,
              phoneNum: phoneNum,
              pool: pool,
              parking: parking,
              spa: spa,
              bar: bar,
              wifi: wifi
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              curve: Interval(
                0,
                0.5,
                curve: Curves.easeInOut,
              ),
              bottom: bookButtonBottom,
              right: 0,
              child: RectGetter(
                key: rectGetterKey,
                child: GestureDetector(
                  // onTap: _onTap,
                  onTap: (){
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                           child: AddBookingPage(hotelName: hotelName,hotelImg: imageAsset,),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(Radius.circular(12))
                           ),
                        );
                      }
                    );
                  },
                  child: Container(
                    height: 60,
                    width: 172,
                    decoration: BoxDecoration(
                        color: themeData.accentColor,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50))),
                    child: Center(
                      child: Text(
                        "Book Now",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _ripple(themeData),
          ],
        ),
      ),
    );
  }

  Widget _ripple(ThemeData themeData) {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeData.accentColor,
        ),
      ),
    );
  }
}
