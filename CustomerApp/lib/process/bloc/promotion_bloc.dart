import 'dart:async';
import 'dart:convert';

import 'package:elscus/core/models/promotion_models/promotion_model.dart';
import 'package:elscus/process/state/promotion_state.dart';

import '../event/promotion_event.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;

class PromotionBloc {
  final eventController = StreamController<PromotionEvent>();
  final stateController = StreamController<PromotionState>();

  PromotionBloc() {
    eventController.stream.listen((event) {
      if (event is OtherPromotionEvent) {
        stateController.sink.add(OtherPromotionState());
      }
      if(event is GetAllPromotionEvent){
        getAllPromotion();
      }
    });
  }

  Future<void> getAllPromotion() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/promotion/mobile/promotions");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllPromotionState(
            listPromo:
                PromotionModel.fromJson(json.decode(response.body)).data));
      } else {
        throw Exception('Unable to fetch  from the REST API');
      }
    } finally {}
  }
}
