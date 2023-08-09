import 'dart:convert';
import 'dart:developer';

import 'package:elscus/core/models/working_time_model/slot_data_model.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/model/checkprice_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/globals.dart' as globals;

class BookingInputApi {
  static Future<List<SlotDataModel>> fetchListSlotData() async {
    try {
      List<SlotDataModel> listRs = [];
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/get-all-slot");
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
        Iterable listData = dataRespone["data"];

        final mapData = listData.cast<Map<String, dynamic>>();
        listRs = mapData.map<SlotDataModel>((json) {
          return SlotDataModel.fromJson(json);
        }).toList();
        return listRs;
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception('Unable to fetch slot from the REST API');
      }
    } finally {}
  }

  static Future<CheckPriceModel?> checkPrice(String idPackage, String startTime,
      List<String> dates, String? idPromotion) async {
    try {
      CheckPriceModel rs;
      Map data2;
      if (idPromotion != null) {
        data2 = {
          "date": dates,
          "packageId": idPackage,
          "startTime": startTime,
          "promotion": idPromotion
        };
      } else {
        data2 = {"date": dates, "packageId": idPackage, "startTime": startTime};
      }

      var body = json.encode(data2);
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/check-price");
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': globals.bearerToken,
            'Accept': 'application/json; charset=UTF-8',
          },
          body: body);
      if (response.statusCode.toString() == '200') {
        print(response.body);
        log(body);
        var dataRespone = jsonDecode(response.body);
        rs = CheckPriceModel.fromJson(dataRespone["data"]);
        return rs;
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception('Unable to fetch slot from the REST API');
      }
    } finally {}
  }
  //https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/check-price
}
