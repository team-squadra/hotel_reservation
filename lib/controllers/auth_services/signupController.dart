import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:hotelreservation/controllers/baseUrl.dart';

class SignUpService {
  static Future<String> SignUp(body) async {

     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json'
     };


    final response =
        await http.post('${URLS.BASE_URL}/user/register', body: jsonEncode(body) , headers: requestHeaders);

    var data = response.body;
    print(body);
    print(json.decode(data));

    Map<String, dynamic> res_data = jsonDecode(data);

    

    // if (res_data['status'] == 'success') {
    if (response.statusCode == 200) {
      final result = res_data['status'];

      return result;

    } 
    else 
    {
      print(res_data);
      final error = res_data['error'];
      return error;
    }
    // return false;
  }
}