import 'dart:convert';

import 'package:elscus/core/models/date_check_models/date_check_editting.dart';
import 'package:elscus/core/models/date_check_models/date_check_increase.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/globals.dart' as globals;

class UpdateBookingApi {
  static Future<DateCheckEditing> checkReduceDay(String idBooking) async {
    try {
      DateCheckEditing rs;
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/check-reduce-day/${idBooking}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      var dataRespone = jsonDecode(response.body);
      if (response.statusCode.toString() == '200') {
        rs = DateCheckEditing.fromJson(dataRespone["data"]);
        return rs;
      }
      if (response.statusCode.toString() == '400') {
        throw Exception(dataRespone["message"]);
      } else {
        throw Exception('Unable to fetch slot from the REST API');
      }
    } finally {}
  }

  //
  static Future<bool> updateBooking(
      String idBooking, List<String> dates) async {
    try {
      Map data2 = {"bookingId": idBooking, "dates": dates};
      var body = json.encode(data2);
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/reduce-booking-date");
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': globals.bearerToken,
            'Accept': 'application/json; charset=UTF-8',
          },
          body: body);
      var dataRespone = jsonDecode(response.body);
      print(response.statusCode);

      print(response.body);
      if (response.statusCode.toString() == '200') {
       return true;
      }
      if (response.statusCode.toString() == '400') {
        throw Exception(dataRespone["message"]);
      } else {
        throw Exception('Unable to fetch slot from the REST API');
      }
    } finally {}
  }

   static Future<CheckIncreaseEditting> checkIncreaseDay(String idBooking) async {
    try {
      CheckIncreaseEditting rs;
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/check-add-day/${idBooking}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      var dataRespone = jsonDecode(response.body);
      if (response.statusCode.toString() == '200') {
        rs = CheckIncreaseEditting.fromJson(dataRespone["data"]);
        return rs;
      }
      if (response.statusCode.toString() == '400') {
        throw Exception(dataRespone["message"]);
      } else {
        throw Exception('Unable to fetch slot from the REST API');
      }
    } finally {}
  }
}
