import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelreservation/Common/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotelreservation/Screens/HomeScreen/home_content.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  TabController _controller;
  final List<Widget> tabBarScreens = [
    HomeContent(),
    Container(color: Colors.lightBlueAccent),
    Container(color: Colors.lightBlue),
    Container(color: Colors.blue),
    Container(color: Colors.blueAccent),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        initialIndex: 0, length: tabBarScreens.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

 Future<bool> onBackPressed() {
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            // customHeader: Image.asset("assets/images/macha.gif"),
            animType: AnimType.TOPSLIDE,
            btnOkText: "yes",
            btnCancelText: " No..",
            tittle: 'Are you sure ?',
            desc: 'Do you want to exit an App',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              exit(0);
            }).show() ??
        false;
  }
  

  @override
  Widget build(BuildContext context) {

    final themeData = HotelConceptThemeProvider.get();
    return WillPopScope(
         onWillPop: onBackPressed,
          child: Scaffold(
          backgroundColor: themeData.scaffoldBackgroundColor,
          body: TabBarView(
            controller: _controller,
            children: tabBarScreens,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: TabBar(
            controller: _controller,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.transparent,
            isScrollable: false,
            tabs: [
              _buildTabIcon("assets/images/tab_bar_home.svg", 0, themeData),
              _buildTabIcon("assets/images/tab_bar_messages.svg", 1, themeData),
              _buildTabIcon("assets/images/tab_bar_search.svg", 2, themeData),
              _buildTabIcon("assets/images/tab_bar_notifications.svg", 3, themeData),
              _buildTabIcon("assets/images/tab_bar_profile.svg", 4, themeData),
            ],
            onTap: (index) {
              setState(() {});
            },
          ),
        ),
    );
  }

    Widget _buildTabIcon(String assetName, int index, ThemeData themeData) {
    return Tab(
        icon: Container(
          child: SvgPicture.asset(
    assetName,
    color: index == _controller.index
          ? themeData.accentColor
          : themeData.primaryColorLight,
          ),
        ),
      );
  }
}