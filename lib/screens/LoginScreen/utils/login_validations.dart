class LoginValidations {
  
  static bool checkNull(email, password) {
    if (email == '' &&  password == '') {
      print('both empty');
      return false;
    } else if (email == '' || password == '') {
      print('one empty');
      return false;
    } else {
      print('both not empty');
      return true;
    }
  }

  static String validateEmail(String email) {
    String msg='';
    String _email = email;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);


    if (emailValid) {
      msg= 'valid';
      print("Valid email !");

      return msg;
    } 
    else {
      msg = 'invalid email';
      print("invalid email");
      return msg;
    }
  }

  static String validatePassword(String password) {
    String msg='';
    if (password.length >= 6) {
      print("valid passowrd");
      msg = 'valid';
      return msg;
    } else {
      msg= 'Passowrd should long 6 charactors';
      print("invalid passowrd");
      return msg;
    }
  }
}
