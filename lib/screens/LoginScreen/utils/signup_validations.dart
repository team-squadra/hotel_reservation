class SingUpValidations {
  
  static bool checkNull(username,email, phone,phonenum) {
    if (username == '' && email == '' &&  phone == '' && phonenum == '') {
      print('all empty');
      return false;
    } else if (username == '' || email == '' || phone == '' || phonenum == '') {
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

  static String validatephone(String phone) {
    String msg='';
    if (phone.length >= 10) {
      print("valid phone number");
      msg = 'valid';
      return msg;
    } else {
      msg= 'phone number should long 10 digits';
      print("invalid phone number");
      return msg;
    }
  }
}
