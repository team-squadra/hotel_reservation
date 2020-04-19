import 'package:flutter/material.dart';
import 'package:hotelreservation/Common/navigation/fade_route.dart';
import 'package:hotelreservation/Controllers/hotel_controllers/bookingService.dart';
import 'package:hotelreservation/Screens/Bookings/book_screen.dart';
import 'package:hotelreservation/Screens/Bookings/widgets/custom_date_time_picker.dart';
import 'package:hotelreservation/Screens/Bookings/widgets/custom_modal_action_button.dart';
import 'package:hotelreservation/Screens/Bookings/widgets/custom_textfield.dart';
import 'package:hotelreservation/Screens/LoginScreen/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBookingPage extends StatefulWidget {
  final String hotelName;
  final String hotelImg;

  AddBookingPage({this.hotelName, this.hotelImg});

  @override
  _AddBookingPageState createState() =>
      _AddBookingPageState(hotelName: hotelName, hotelImg: hotelImg);
}

class _AddBookingPageState extends State<AddBookingPage> with SingleTickerProviderStateMixin{
  String _selectedCheckInDate = 'Check In Date';
  String _selectedCheckOutDate = 'Check Out Date';
  String _selectedTime = 'Pick time';

  final _rooms = TextEditingController();
  final _adults = TextEditingController();
  final _children = TextEditingController();
  SharedPreferences logininit;
  ProgressDialog pr;

  final Duration animationDuration = Duration(milliseconds: 600);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  static double bookButtonBottomOffset = -60;
  double bookButtonBottom = bookButtonBottomOffset;
  AnimationController _bottomSheetController;

  final String hotelName;
  final String hotelImg;

  _AddBookingPageState({this.hotelName, this.hotelImg});

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
        .push(FadeRouteBuilder(page: BookScreen()))
        .then((_) => setState(() => rect = null));
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
        message: 'Verifying You...',
        borderRadius: 10.0,
        progressWidget: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sending.gif'),
                    fit: BoxFit.cover))),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(fontFamily: 'Montserrat'));

    return SingleChildScrollView(
      child: Container(
        margin:
            const EdgeInsets.only(top: 15.0, left: 12, right: 12, bottom: 12),
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
                CustomTextField(labelText: 'Rooms', controller: _rooms),
                SizedBox(
                  width: 20,
                ),
                CustomTextField(labelText: 'Adults', controller: _adults),
                SizedBox(
                  width: 20,
                ),
                CustomTextField(labelText: 'Children', controller: _children),
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
              onSave: () async {
                if(_rooms.text != '' && _adults.text !='' && _children.text != ''){
                pr.show();
                logininit = await SharedPreferences.getInstance();
                final body = {
                  "user_name": logininit.getString("username"),
                  "hotel_name": hotelName,
                  "check_in": _selectedCheckInDate,
                  "check_out": _selectedCheckOutDate,
                  "rooms": _rooms.text,
                  "adaults": _adults.text,
                  "childrens": _children.text,
                  "totprice": "3000",
                };

                BookingService.HotelBooking(body).then((result){
                   final _result = result;

                   if(_result != ""){
                     print('booking successfull !');
                    pr.hide();
                     Dialogs.bookingSuccessDialog(context, "Done", "booking successfull !");
                   }
                   else{
                     pr.hide();
                     Dialogs.errorDialog(context, 'ERROR', _result);
                   }
                });
                }
                else{
                  pr.hide();
                  Dialogs.errorDialog(context, 'ERROR', "Both Fields Required !");
                }
              
              },
            )
          ],
        ),
      ),
    );
  }
}
