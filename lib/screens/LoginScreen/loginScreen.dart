import 'package:flutter/material.dart';
import 'package:hotelreservation/Controllers/auth_services/loginController.dart';
import 'package:hotelreservation/Screens/LoginScreen/components/customTextfield.dart';
import 'package:hotelreservation/Screens/HomeScreen/home_screen.dart';
import 'package:hotelreservation/Screens/LoginScreen/utils/dialogs.dart';
import 'package:hotelreservation/Screens/LoginScreen/widgets/headerWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:hotelreservation/Screens/LoginScreen/utils/login_validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _email = TextEditingController();
  final _password = TextEditingController();

  String _errorTxt = '';
  ProgressDialog pr;
  SharedPreferences login;

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
                      type: PageTransitionType.fade, child: HomeScreen()));
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
                    HeaderWidget(),
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
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      height: MediaQuery.of(context).size.height * 0.70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Welcome",
              style: TextStyle(
                  color: Color(0xFFF032f42),
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          Text("Sign to continue",
              style: TextStyle(color: Colors.grey, fontSize: 25)),
          SizedBox(height: 40),
          CustomTextField(
            label: "Email",
            controller: _email,
          ),
          SizedBox(height: 10),
          CustomTextField(
            label: "Password",
            controller: _password,
            isPassword: true,
            icon: Icon(
              Icons.https,
              size: 27,
              color: Color(0xFFF032f41),
            ),
          ),
          SizedBox(height: 40),
          buildLoginBtn()
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return InkWell(
      onTap: () {
        initializeLogin();
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
                  Text("Login",
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

  void initializeLogin() {
    final email = _email.text;
    final password = _password.text;

    bool cheknull = LoginValidations.checkNull(email, password);
    String emailValidate = LoginValidations.validateEmail(email);
    String passValidate = LoginValidations.validatePassword(password);

    try{
        if (cheknull) {
      if (emailValidate == 'valid') {
        if (passValidate == 'valid') {

          postUserData();
        } 
        else {
          Dialogs.errorDialog(context, 'Validation Error', passValidate);
        }
      } else {
        Dialogs.errorDialog(context, 'Validation Error', emailValidate);
      }
    } else {
      Dialogs.errorDialog(
          context, 'Validation Error', 'Both fields required !');
    }
      
    } catch (e){
      throw Exception(e.toString());
    }

  
  }

  setToken() async {
       SharedPreferences login = await SharedPreferences.getInstance();
        final _token = login.getString("gettoken");
        final _username = login.getString("username");
        print("token set");

        SharedPreferences logininit = await SharedPreferences.getInstance();
        logininit.setString("token", _token);
        logininit.setString("username", _username);
  }

  postUserData() {
    final email = _email.text;
    final password = _password.text;
    pr.show();

    final body = {"email": email, "password": password};

    LoginService.Login(body).then((result) {
      final _result = result;
      if (_result == 'user') {
        pr.hide();
        print("login successfull");
        setToken();
        setState(() {
          _isLogin = true;
        });
        _positionController.forward();
      }
      else if(_result == 'admin' || _result == 'hotel'){
        pr.hide();
        Dialogs.errorDialog(context, 'ERROR', "This is not a user acccount !");
      }
      
       else {
        pr.hide();
        Dialogs.errorDialog(context, 'ERROR', _result);
      }
    });
  }
}
