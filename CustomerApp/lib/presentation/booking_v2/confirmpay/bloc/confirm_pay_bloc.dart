import 'dart:async';
import 'dart:developer';

import 'package:elscus/presentation/booking_v2/choose_infomation/api/booking_input_api.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_bloc.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/model/checkprice_model.dart';
import 'package:elscus/presentation/booking_v2/choose_package/model/promotion_model.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/api/confirm_pay_api.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_event.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_state.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/model/data_post_booking_model.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/globals.dart' as globals;

class ConfirmPayBloc {
  //numPaymen 0-Ví, 1-MOMO, 2-VNPAY(NEU CO)
  final eventController = StreamController<ConfirmPayEvent>();
  final stateController = StreamController<ConfirmPayState>();
  double amountWallet = 0;
  bool isWaiting = false;
  String idPromotion = "";
  CheckPriceModel? checkPriceModel;
  List<String> dates = [];
  List<Promotion> promotionList = [];
  bool isWaitingApplyPromotion = false;
  int numPayment = 0;
  ConfirmPayBloc() {
    eventController.stream.listen((event) async {
      if (event is OtherConfirmPayEvent) {
        stateController.sink.add(OtherConfirmPayState());
      } else if (event is FetchDataWalletEvent) {
        try {
          amountWallet = await ConfirmPayApi.fetchWallet();
          promotionList = await ConfirmPayApi.fetchPromotion();
        } catch (e) {
          log("ClickPaymentEvent${e}");
          isWaiting = false;
          stateController.sink
              .add(ErrorConfirmPayState(message: e.toString().split(':')[1]));
        }
        stateController.sink.add(OtherConfirmPayState());
      } else if (event is ClickPaymentEvent) {
        try {
          BookingInputInforBloc bl = event.bookingInputBloc;
          List<String> dates = [];
          bl.datesFinal.forEach((element) {
            dates.add(DateFormat("yyyy-MM-dd").format(element!));
          });
          if (numPayment == 0) {
            if (bl.checkPriceModel!.totalPrice <= amountWallet) {
              isWaiting = true;
              stateController.sink.add(OtherConfirmPayState());

              //compund.district
              log(bl.modelSearch!.compound.district);
              await ConfirmPayApi.createBookingV2(DataPostBooking(
                  district: bl.modelSearch!.compound.district,
                  promotion: idPromotion,
                  lat: bl.modelSearch?.lat,
                  lng: bl.modelSearch?.lng,
                  address:
                      bl.modelSearch != null ? bl.modelSearch!.description : "",
                  place:
                      bl.modelSearch != null ? bl.modelSearch!.description : "",
                  startDate: dates.first,
                  endDate: dates.last,
                  description:
                      (bl.description.isNotEmpty) ? bl.description : "",
                  elderId: bl.elder.id,
                  customerId: globals.customerID,
                  packageId: bl.package.id!,
                  dates: dates,
                  startTime: bl.slotPicked.slots.split(" ")[1].split("-")[0]));
              isWaiting = false;
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  event.context,
                  MaterialPageRoute(
                    builder: (context) => const SuccessScreen(
                        content:
                            "Đặt lịch thành công.\nHệ thống đang tìm kiếm chăm sóc viên phù hợp nhất với đặt lịch của bạn.",
                        buttonName: "Trang chủ",
                        navigatorPath: '/homeScreen'),
                  ),
                  (route) => false);
            } else {
              //báo fail;
              const snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                dismissDirection: DismissDirection.startToEnd,
                duration: Duration(milliseconds: 800),
                backgroundColor: Colors.red,
                content: Text('Số dư của ví không đủ'),
              );
              ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
            }
          } else {
            isWaiting = true;
            stateController.sink.add(OtherConfirmPayState());
            String urlMomo = await ConfirmPayApi.createBookingMomo(
                DataPostBooking(
                    district: bl.modelSearch!.compound.district,
                    promotion: idPromotion,
                    lat: bl.modelSearch?.lat,
                    lng: bl.modelSearch?.lng,
                    address: bl.modelSearch != null
                        ? bl.modelSearch!.description
                        : "",
                    place: bl.modelSearch != null
                        ? bl.modelSearch!.description
                        : "",
                    startDate: dates.first,
                    endDate: dates.last,
                    description:
                        (bl.description.isNotEmpty) ? bl.description : "null",
                    elderId: bl.elder.id,
                    customerId: globals.customerID,
                    packageId: bl.package.id!,
                    dates: dates,
                    startTime:
                        bl.slotPicked.slots.split(" ")[1].split("-")[0]));
            isWaiting = false;
            if (await canLaunchUrl(Uri.parse(urlMomo))) {
              await launchUrl(Uri.parse(urlMomo),
                  mode: LaunchMode.externalNonBrowserApplication);
            }
             stateController.sink.add(OtherConfirmPayState());
          }
        } catch (e) {
          log("ClickPaymentEvent${e}");
          isWaiting = false;
          stateController.sink
              .add(ErrorConfirmPayState(message: e.toString().split(':')[1]));
        }
      } else if (event is ClickPaymentIncreseEvent) {
        try {
          BookingInputInforBloc bl = event.bookingInputBloc;
          List<String> dates = [];
          bl.datesFinal.forEach((element) {
            dates.add(DateFormat("yyyy-MM-dd").format(element!));
          });

          if (bl.checkPriceModel!.totalPrice >= amountWallet) {
            isWaiting = true;
            stateController.sink.add(OtherConfirmPayState());
            await ConfirmPayApi.increaseBooking(event.bookingID, dates);
            isWaiting = false;
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                event.context,
                MaterialPageRoute(
                  builder: (context) => const SuccessScreen(
                      content: "Đặt lịch thành công",
                      buttonName: "Trang chủ",
                      navigatorPath: '/homeScreen'),
                ),
                (route) => false);
          } else {
            //báo fail;
          }
        } catch (e) {
          print(e);
          isWaiting = false;
          stateController.sink
              .add(ErrorConfirmPayState(message: e.toString().split(':')[1]));
        }
      } else if (event is ClickChoosePromotion) {
        isWaiting = true;
        stateController.sink.add(OtherConfirmPayState());
        try {
          String startTime = event.bookingInputBloc.slotPicked.slots
              .split(" ")[1]
              .split("-")[0];
          checkPriceModel = await BookingInputApi.checkPrice(
              event.bookingInputBloc.package.id!,
              startTime,
              dates,
              idPromotion);
        } catch (e) {
          print(e);
          isWaiting = false;
          isWaiting = false;
          stateController.sink
              .add(ErrorConfirmPayState(message: e.toString().split(':')[1]));
        }
        isWaiting = false;
        stateController.sink.add(OtherConfirmPayState());
      }
    });
  }
}
