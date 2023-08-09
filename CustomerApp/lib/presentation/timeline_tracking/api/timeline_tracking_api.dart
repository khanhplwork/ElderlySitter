import 'dart:convert';

import 'package:elscus/presentation/timeline_tracking/model/timeline_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/globals.dart' as globals;

class TimelineTrackingApi {
  static Future<Map<String,TimelineModel>> fetchDataTimeLine(String idBooking) async {
// https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/tracking/mobile/get-all-tracking/
    try {
      List<TimelineModel> listRs = [];
      Map<String,TimelineModel> rs={};
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/tracking/mobile/get-all-tracking/${idBooking}");
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
        Iterable listData = dataRespone["data"];

        final mapData = listData.cast<Map<String, dynamic>>();
        // return mapData;
        listRs = mapData.map<TimelineModel>((json) {
          rs.putIfAbsent(TimelineModel.fromJson(json).date, () => TimelineModel.fromJson(json));
          return TimelineModel.fromJson(json);
        }).toList();
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
