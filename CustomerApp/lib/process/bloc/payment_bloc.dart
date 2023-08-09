import 'dart:async';
import 'dart:convert';

import 'package:elscus/presentation/payment_screen/payment_screen.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/presentation/widget/dialog/fail_dialog.dart';
import 'package:elscus/presentation/widget/dialog/success_dialog.dart';
import 'package:elscus/process/event/payment_event.dart';
import 'package:elscus/process/state/payment_state.dart';
import 'package:flutter/Material.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/globals.dart' as globals;

class PaymentBloc {
  final eventController = StreamController<PaymentEvent>();
  final stateController = StreamController<PaymentState>();
  String? paymentMethod;
  int amount=0;
  late MomoVn _momoPay;
  String error="";
  bool isEnable=false;

  PaymentBloc() {
    eventController.stream.listen((event) {
      if (event is ChoosePaymentMethodPaymentEvent) {
        paymentMethod = event.paymentMethod;
      }

      if (event is ConfirmDepositMoneyIntoWalletPaymentEvent) {
        // onPaymentClick();
        Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(
                  title: "ELS Payment",
                  orderID: globals.customerID,
                  description: "Nạp tiền từ ví momo"),
            ));
      }

      if (event is AddTransactionInfoPaymentEvent) {
      
        if (amount != null) {
          if (amount! <= 0) {
            showFailDialog(event.context, "Vui lòng nhập số tiền cần nạp");
          } else {
            // depositCashIntoWallet(event.context);
            depositCashIntoWallet2(event.context);
           
          }
        } else {
          showFailDialog(event.context, "Vui lòng nhập số tiền cần nạp");
        }
      }
      if (event is FillAmountPaymentEvent) {
        amount = event.amount;
        if(amount>=5000){
          isEnable=true;
          error="";
        }else{
            error="Số tiền nạp tối thiểu là 5000 VNĐ";
          isEnable=false;
        }
        stateController.sink.add(FillAmountPaymentState(amount: amount));

      }
    });
  }
  Future<void> depositCashIntoWallet(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/payment/mobile/top-up");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "customerId": globals.customerID,
            "amount": amount,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SuccessScreen(content: "Nạp tiền vào ví thành công", buttonName: "Trở về ví của bạn", navigatorPath: "/walletScreen"),));
      } else {
        throw Exception('Unable to fetch depositCashIntoWallet from the REST API');
      }
    } finally {}
  }
  Future<void> depositCashIntoWallet2(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/payment/mobile/top-up-v2");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "customerId": globals.customerID,
            "amount": amount,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SuccessScreen(content: "Nạp tiền vào ví thành công", buttonName: "Trở về ví của bạn", navigatorPath: "/walletScreen"),));

        String url = response.body.toString();
        final uri = Uri.parse(url);
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url),
              mode: LaunchMode.externalNonBrowserApplication);
        }
      } else {
        throw Exception('Unable to fetch depositCashIntoWallet2 from the REST API');
      }
    } finally {}
  }
}
