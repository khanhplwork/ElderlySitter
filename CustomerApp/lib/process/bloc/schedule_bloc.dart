import 'dart:async';
import 'dart:convert';

import 'package:elscus/core/models/schedule_models/schedue_item_model.dart';
import 'package:elscus/core/models/schedule_models/schedule_item_data_model.dart';
import 'package:elscus/process/event/schedule_event.dart';
import 'package:elscus/process/state/schedule_state.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;

class ScheduleBloc {
  final eventController = StreamController<ScheduleEvent>();
  final stateController = StreamController<ScheduleState>();

  ScheduleBloc() {
    eventController.stream.listen((event) async{
      if (event is GetListItemScheduleEvent) {
           stateController.sink.add(LoadingState());
       List<ScheduleItemDataModel> listSchedule= await getListScheduleItem();
      
       if(listSchedule.isNotEmpty){
        stateController.sink.add(HaveDataState(listSchedule: listSchedule));
       }else{
          stateController.sink.add(NotHaveDataState());
      }}
      if (event is OtherScheduleEvent) {
        stateController.sink.add(OtherScheduleState());
      }
    });
  }

  Future<List<ScheduleItemDataModel>> getListScheduleItem() async {
    try {
      List<ScheduleItemDataModel> listRs=[];
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-schedule-customer/${globals.customerID}");
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
        listRs = mapData.map<ScheduleItemDataModel>((json) {
          return ScheduleItemDataModel.fromJson(json);
        }).toList();
        return listRs;
        // stateController.sink.add(GetListItemScheduleState(
        //     listItem: ScheduleItemModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch Schedule from the REST API');
      }
    } finally {}
  }
}
