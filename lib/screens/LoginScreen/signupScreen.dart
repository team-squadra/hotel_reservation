import 'package:flutter/material.dart';
import 'package:hotelreservation/Screens/LoginScreen/components/customTextfield.dart';
import 'package:hotelreservation/Screens/LoginScreen/loginScreen.dart';
import 'package:hotelreservation/Screens/LoginScreen/utils/dialogs.dart';
import 'package:hotelreservation/Screens/LoginScreen/utils/signup_validations.dart';
import 'package:hotelreservation/Controllers/auth_services/signupController.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phonenum = TextEditingController();

  String _errorTxt = '';
  ProgressDialog pr;

  AnimationController _positionController;
  Animation<double> _positionAnimation;

  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  bool _isLogin = false;
  bool _isIconHide = false;

  @override
  void initState() {
    super.initState();

    _positionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _positionAnimation =
        Tween<double>(begin: 10.0, end: 255.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                _isIconHide = true;
              });
              _scaleController.forward();
            }
          });

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 32).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: LoginScreen()));
            }
          });
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

    return Scaffold(
      resizeToAvoidBottomPadding: false, // this avoids the overflow error
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login.jpeg"),
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter)),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 20),
                    buildHeader(context),
                    buildBody(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Welcome",
              style: TextStyle(
                  color: Color(0xFFF032f42),
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          Text("SignUp Here",
              style: TextStyle(color: Colors.grey, fontSize: 25)),
          SizedBox(height: 40),
          CustomTextField(
            label: "UserName",
            controller: _username,
          ),
          SizedBox(height: 10),
          CustomTextField(
            label: "Email",
            controller: _email,
          ),
          SizedBox(height: 10),
          CustomTextField(
            label: "Password",
            isPassword: true,
            controller: _password,
            icon: Icon(
              Icons.https,
              size: 27,
              color: Color(0xFFF032f41),
            ),
          ),
          SizedBox(height: 10),
          CustomTextField(
            label: "PhoneNumber",
            controller: _phonenum,
          ),
          SizedBox(height: 30),
          buildSignUpBtn()
        ],
      ),
    );
  }

  Widget buildSignUpBtn() {
    return InkWell(
      onTap: () {
        innitializeRegistration();
      },
      child: Container(
        height: 63,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF1f94aa),
          borderRadius: BorderRadius.circular(14),
        ),
        child: !_isLogin
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("SignUp",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 32)
                ],
              )
            : Stack(
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _positionController,
                    builder: (context, child) => Positioned(
                      left: _positionAnimation.value,
                      top: 5,
                      child: AnimatedBuilder(
                        animation: _scaleController,
                        builder: (context, build) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1a7a8c),
                                shape: BoxShape.circle,
                              ),
                              child: !_isIconHide
                                  ? Icon(Icons.arrow_forward,
                                      color: Colors.white, size: 32)
                                  : Container(),
                            )),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void innitializeRegistration() {
    final username = _username.text;
    final email = _email.text;
    final password = _password.text;
    final phonenum = _phonenum.text;

    bool cheknull =
        SingUpValidations.checkNull(username, email, password, phonenum);
    //  String emailValidate = LoginValidations.validateEmail(email);
    String phoneValidate = SingUpValidations.validatephone(phonenum);

    if (cheknull) {
      
       postUserData();

    } else {
      Dialogs.errorDialog(
          context, 'Validation Error', 'Both fields required !');
    }
  }

  postUserData() {
    final username = _username.text;
    final email = _email.text;
    final password = _password.text;
    final phonenum = _phonenum.text;
    pr.show();

    final body = {
      "name": username,
      "email": email,
      "password": password,
      "phone_number": phonenum
    };

    SignUpService.SignUp(body).then((result) {
      final _result = result;
      if (_result == 'success') {
        pr.hide();
        print("registration successfull !");
        setState(() {
          _isLogin = true;
        });
        _positionController.forward();
      } else {
        pr.hide();
        Dialogs.errorDialog(context, 'ERROR', _result);
      }
    });
  }

  Widget buildHeader(BuildContext context) {
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
}
