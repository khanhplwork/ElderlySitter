import 'dart:developer';

import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/presentation/widget/dialog/fail_dialog.dart';
import 'package:elscus/process/bloc/payment_bloc.dart';
import 'package:elscus/process/event/payment_event.dart';
import 'package:elscus/process/state/payment_state.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momo_vn/momo_vn.dart';
import '../../core/utils/globals.dart' as globals;
import '../success_screen/success_screen.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatefulWidget {
  PaymentScreen(
      {super.key,
      required this.title,
      required this.orderID,
      required this.description});

  String title;
  String orderID;
  String description;

  @override
  // ignore: no_logic_in_create_state
  State<PaymentScreen> createState() => _PaymentScreenState(
      title: title, orderID: orderID, description: description);
}

class _PaymentScreenState extends State<PaymentScreen> {
  _PaymentScreenState({
    required this.title,
    required this.orderID,
    required this.description,
  });

  String title;
  int? amount;
  String orderID;
  String description;
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  // ignore: non_constant_identifier_names
  late String _paymentStatus;
  final _paymentBloc = PaymentBloc();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    initPlatformState();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.path;
      log("abc ${queryParams}");
      if (queryParams.isNotEmpty) {
        if (queryParams == "/success") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SuccessScreen(
                    content:
                        "Nạp tiền thành công. Cảm ơn bạn đã sử dụng dịch vụ",
                    buttonName: "Trang chủ",
                    navigatorPath: '/homeScreen'),
              ),
              (route) => false);
        } else {
          showFailDialog(
              context, "Thanh toán không thành công. Vui lòng thử lại sau");
        }
      } else {}
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _paymentBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is FillAmountPaymentState) {
              amount = (snapshot.data as FillAmountPaymentState).amount;
              _paymentBloc.eventController.sink.add(OtherPaymentEvent());
            }
          }
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                bottomOpacity: 0,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: size.height * 0.03,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.06),
                  child: const Text(
                    "Xác Nhận Thanh Toán",
                  ),
                ),
                titleTextStyle: GoogleFonts.roboto(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: size.width * 0.84,
                height: size.height * 0.055,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _paymentBloc.isEnable
                        ? ColorConstant.primaryColor
                        : Colors.grey,
                  ),
                  child: Text(
                    'Xác Nhận',
                    style: GoogleFonts.roboto(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  onPressed: () async {
                    // MomoPaymentInfo options = MomoPaymentInfo(
                    //     merchantName: "DNMTV",
                    //     appScheme: "MOxx",
                    //     merchantCode: 'MOMOM1IH20220922',
                    //     partnerCode: 'MOMOM1IH20220922  ',
                    //     amount: amount!,
                    //     orderId: orderID,
                    //     orderLabel: 'ELS Thanh Toán',
                    //     merchantNameLabel: "HLGD",
                    //     fee: 10,
                    //     description: description,
                    //     username: globals.cusDetailModel!.email,
                    //     partner: 'merchant',
                    //     extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                    //     isTestMode: true);
                    // try {
                    //   _momoPay.open(options);
                    // } catch (e) {
                    //   debugPrint(e.toString());
                    // }
                    if (_paymentBloc.isEnable) {
                      _paymentBloc.eventController.sink.add(
                          AddTransactionInfoPaymentEvent(context: context));
                    }
                  },
                ),
              ),
              body: Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        child: TextField(
                          onChanged: (value) {
                            _paymentBloc.eventController.sink.add(
                                FillAmountPaymentEvent(
                                    amount: int.parse(value.toString())));
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: size.width * 0.04, color: Colors.black),
                          cursorColor: ColorConstant.primaryColor,
                          controller: null,
                          decoration: InputDecoration(
                            errorText: _paymentBloc.error.isNotEmpty
                                ? _paymentBloc.error
                                : null,
                            contentPadding: EdgeInsets.only(
                              left: size.width * 0.03,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: GoogleFonts.roboto(
                              color: Colors.black,
                            ),
                            labelText: 'Số tiền cần nạp: ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nTình trạng: Thành công.";
      _paymentStatus +=
          "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    // Fluttertoast.showToast(
    //     msg: "THÀNH CÔNG: " + response.phoneNumber.toString(),
    //     toastLength: Toast.LENGTH_SHORT);
    _paymentBloc.eventController.sink
        .add(AddTransactionInfoPaymentEvent(context: context));
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "THẤT BẠI: " + response.message.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }
}
