import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 32),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.slow_motion_video, color: Colors.white, size: 32),
                Text("32°",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                Text("Sat, 3 Aug",
                    style: TextStyle(color: Colors.white, fontSize: 12))
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget profile(){

  //   return Row(
  //     children: <Widget>[
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: <Widget>[
  //           Text("Alessa Quizon", style: TextStyle(
  //             color: Color(0xFFF2c4e5e),
  //             fontWeight: FontWeight.bold
  //           )),
  //           Text("Hawaii", style: TextStyle(
  //             color: Color(0xFFF1f94aa)
  //           )),
            
  //         ],
  //       ),

  //         SizedBox(width: 5),
  //         Container(
  //           height: 50,
  //           width: 50,
  //           decoration: BoxDecoration(
  //             color: Colors.red,
  //             shape: BoxShape.circle,
  //             image: DecorationImage(
  //               image: AssetImage("assets/images/user_5.jpg"),
  //               fit: BoxFit.cover
  //             )
  //           ),
  //         )

  //     ],
  //   );

  // }

}