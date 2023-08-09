import 'dart:convert';

import 'package:elscus/presentation/booking_v2/choose_elder/bloc/booking_elder_bloc.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/globals.dart' as globals;

class BookingElderApi{
 static Future<List<ElderModelV2>> fetchListElder()async{
    List<ElderModelV2> list=[];
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/elder/mobile/elders/${globals.customerID}");
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
        list = mapData.map<ElderModelV2>((json) {
          return ElderModelV2.fromJson(json);
        }).toList();
        return list;
        // stateController.sink.add(GetListItemScheduleState(
        //     listItem: ScheduleItemModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch Schedule from the REST API');
      }
    } finally {
    }
  }
}