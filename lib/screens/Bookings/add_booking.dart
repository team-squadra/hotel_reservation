import 'package:flutter/material.dart';
import 'package:hotelreservation/Screens/Bookings/widgets/custom_date_time_picker.dart';
import 'package:hotelreservation/Screens/Bookings/widgets/custom_modal_action_button.dart';
import 'package:hotelreservation/Screens/Bookings/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class AddBookingPage extends StatefulWidget {
  final String hotelName;
  final String hotelImg;

  AddBookingPage({this.hotelName,this.hotelImg});

  @override
  _AddBookingPageState createState() =>
      _AddBookingPageState(hotelName: hotelName,hotelImg:hotelImg);
}

class _AddBookingPageState extends State<AddBookingPage> {
  String _selectedCheckInDate = 'Check In';
  String _selectedCheckOutDate = 'Check Out';
  String _selectedTime = 'Pick time';

  final String hotelName;
  final String hotelImg;

  _AddBookingPageState({this.hotelName,this.hotelImg});

  Future _pickCheckInDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));

    var formatter = new DateFormat('yyyy-MM-dd');
    var onlydate = formatter.format(datepick);
    if (datepick != null)
      setState(() {
        _selectedCheckInDate = onlydate.toString();
      });
  }

  Future _pickCheckOutDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));

    var formatter = new DateFormat('yyyy-MM-dd');
    var onlydate = formatter.format(datepick);
    if (datepick != null)
      setState(() {
        _selectedCheckOutDate = onlydate.toString();
      });
  }

  Future _pickTime() async {
    TimeOfDay timepick = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());
    if (timepick != null) {
      setState(() {
        _selectedTime = timepick.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(top: 15.0, left: 12, right: 12, bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
                child: Text(
              "Make Your Reservation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.location_city,
                    color: Color(0xFFFFA726),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Text(
                      "Hotel " + hotelName,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomDateTimePicker(
                  icon: Icons.date_range,
                  onPressed: _pickCheckInDate,
                  value: _selectedCheckInDate,
                ),
                CustomDateTimePicker(
                  icon: Icons.date_range,
                  onPressed: _pickCheckOutDate,
                  value: _selectedCheckOutDate,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                CustomTextField(labelText: 'Rooms'),
                SizedBox(
                  width: 20,
                ),
                CustomTextField(labelText: 'Adults'),
                SizedBox(
                  width: 20,
                ),
                CustomTextField(labelText: 'Children'),
              ],
            ),
            SizedBox(height: 12),
            // CustomDateTimePicker(
            //   icon: Icons.access_time,
            //   onPressed: _pickTime,
            //   value: _selectedTime,
            // ),
            SizedBox(
              height: 24,
            ),
            CustomModalActionButton(
              onClose: () {
                Navigator.of(context).pop();
              },
              onSave: () {
                print(_selectedCheckInDate);
              },
            )
          ],
        ),
      ),
    );
  }
}
