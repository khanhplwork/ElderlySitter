import 'dart:convert';
import 'dart:developer';

import 'package:elscus/presentation/booking_v2/choose_package/model/promotion_model.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/model/data_post_booking_model.dart';
import 'package:elscus/presentation/widget/dialog/fail_dialog.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/globals.dart' as globals;

class ConfirmPayApi {
  //https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/payment/common/get-wallet
  static Future<double> fetchWallet() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/payment/common/get-wallet/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        return dataRespone["data"]["amount"] ?? 0.toDouble();
      } else {
        print(response.statusCode);
        throw Exception('Unable to fetch Schedule from the REST API');
      }
    } finally {}
  }

  static Future<void> createBookingV2(DataPostBooking data) async {
    try {
      Map data2;
      if (data.promotion != "") {
        data2 = {
          "address": data.address,
          "place": data.place,
          "startDate": data.startDate,
          "endDate": data.endDate,
          "description": data.description,
          "elderId": data.elderId,
          "customerId": data.customerId,
          "packageId": data.packageId,
          "dates": data.dates,
          "startTime": data.startTime,
          "latitude": data.lat,
          "longitude": data.lng,
          "promotion": data.promotion,
           "district":data.district
        };
      } else {
        data2 = <String, dynamic>{
          "address": data.address,
          "place": data.place,
          "startDate": data.startDate,
          "endDate": data.endDate,
          "description": data.description,
          "elderId": data.elderId,
          "customerId": data.customerId,
          "packageId": data.packageId,
          "dates": data.dates,
          "startTime": data.startTime,
          "latitude": data.lat,
          "longitude": data.lng,
          "district":data.district
        };
      }
      var body = json.encode(data2);
     
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/createV2");
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': globals.bearerToken,
            'Accept': 'application/json; charset=UTF-8',
          },
          body: body);

      if (response.statusCode.toString() == '200') {
        log('test 200 createBooking status code: ${response.body}');
        String idBooking = jsonDecode(response.body)["data"]["id"];
        await assignApi(idBooking);
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } finally {}
  }
  static Future<String> createBookingMomo(DataPostBooking data) async {
    try {
      Map data2;
      if (data.promotion != "") {
        data2 = {
          "address": data.address,
          "place": data.place,
          "startDate": data.startDate,
          "endDate": data.endDate,
          "description": data.description,
          "elderId": data.elderId,
          "customerId": data.customerId,
          "packageId": data.packageId,
          "dates": data.dates,
          "startTime": data.startTime,
          "latitude": data.lat,
          "longitude": data.lng,
          "promotion": data.promotion,
           "district":data.district
        };
      } else {
        data2 = <String, dynamic>{
          "address": data.address,
          "place": data.place,
          "startDate": data.startDate,
          "endDate": data.endDate,
          "description": data.description,
          "elderId": data.elderId,
          "customerId": data.customerId,
          "packageId": data.packageId,
          "dates": data.dates,
          "startTime": data.startTime,
          "latitude": data.lat,
          "longitude": data.lng,
          "district":data.district
        };
      }
      var body = json.encode(data2);
     
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/payment/mobile/pay-booking");
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': globals.bearerToken,
            'Accept': 'application/json; charset=UTF-8',
          },
          body: body);

      if (response.statusCode.toString() == '200') {
        
        log('test 200 createBookingMomo status code: ${response.body}');
            String url = response.body.toString();
            return url;
        // String idBooking = jsonDecode(response.body)["data"]["id"];
        // await assignApi(idBooking);
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } finally {}
  }

  static Future<void> increaseBooking(
      String idBooking, List<String> dates) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/addDate");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "date": dates,
          "startDate": dates.first,
          "endDate": dates.last,
          "bookingId": idBooking
        }),
      );
      print('test increaseBooking status code: ${response.statusCode}');
      print('test increaseBooking status code: ${response.body}');
      if (response.statusCode.toString() == '200') {
        log('test 200 increaseBooking status code: ${response.body}');
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } finally {}
  }

  static Future<void> assignApi(String idBooking) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/assignSitter/${idBooking}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } finally {}
  }

  static Future<List<Promotion>> fetchPromotion() async {
    List<Promotion> list = [];
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/promotion/mobile/gets-promotion-id/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      log(response.body);
      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        Iterable listData = dataRespone["data"];
        final mapData = listData.cast<Map<String, dynamic>>();
        list = mapData.map<Promotion>((json) {
          return Promotion.fromJson(json);
        }).toList();
        return list;
      } else {
        print(response.statusCode);
        throw Exception('Unable to fetch Schedule from the REST API');
      }
    } finally {}
  }
}
