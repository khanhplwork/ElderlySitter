import 'dart:async';
import 'dart:convert';

import 'package:elscus/core/models/transaction_models/transaction_model.dart';
import 'package:elscus/process/event/transaction_event.dart';
import 'package:elscus/process/state/transaction_state.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;

class TransactionBloc{
  final eventController = StreamController<TransactionEvent>();
  final stateController = StreamController<TransactionState>();
  TransactionBloc(){
    eventController.stream.listen((event) {
      if(event is GetAllTransactionEvent){
        getAllTransaction();
      }
      if(event is OtherTransactionEvent){
        stateController.sink.add(OtherTransactionState());
      }
    });
  }
  Future<void> getAllTransaction() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/payment/mobile/get-all-transaction/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllTransactionState(
            listTransaction: TransactionModel.fromJson(json.decode(response.body)).data));
      } else {
        throw Exception('Unable to fetch transaction from the REST API');
      }
    } finally {}
  }
}