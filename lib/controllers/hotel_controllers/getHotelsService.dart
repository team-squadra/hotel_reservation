import 'dart:convert';
import 'package:hotelreservation/Controllers/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:hotelreservation/Models/hotelModel.dart';
 
class GetHotelsService {
  static const String url = '${URLS.BASE_URL}/hotels/hoteldata';
 
  static Future<List<Hotel>> getHotels() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Hotel> list = parseHotels(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 
  static List<Hotel> parseHotels(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Hotel>((json) => Hotel.fromJson(json)).toList();
  }
}