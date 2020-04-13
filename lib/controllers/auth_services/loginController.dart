import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:hotelreservation/controllers/baseUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<String> Login(body) async {

     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json'
     };


    final response =
        await http.post('${URLS.BASE_URL}/user/login', body: jsonEncode(body) , headers: requestHeaders);

    var data = response.body;
    print(body);
    print(json.decode(data));

    Map<String, dynamic> res_data = jsonDecode(data);

    
    try{
          if (response.statusCode == 200) {
      print(res_data['status']);
      final _token = res_data['token'];
      print(_token);
      SharedPreferences login = await SharedPreferences.getInstance();
      login.setString("gettoken", _token);

      final status = res_data['status'];

      return status;

    } 
    else 
    {
      print(res_data);
      final error = res_data['error'];
      return error;
    }
    } catch (e) {
      throw Exception(e.toString());
    }
 
    // return false;
  }
}