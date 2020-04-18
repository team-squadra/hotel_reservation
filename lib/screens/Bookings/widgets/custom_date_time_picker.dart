import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String value;

  CustomDateTimePicker(
      {@required this.onPressed, @required this.icon, @required this.value});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                                  color: Color(0xFFEEEEEE),
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          children: <Widget>[
            Icon(icon, color: Theme.of(context).accentColor, size: 30),
            SizedBox(
              width: 12,
            ),
            Text(
              value,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
