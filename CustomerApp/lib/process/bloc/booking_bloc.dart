// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:elscus/core/models/booking_models/add_booking_detail_dto.dart';
import 'package:elscus/core/models/booking_models/booking_form_data_model.dart';
import 'package:elscus/core/models/booking_models/booking_full_detail_model.dart';
import 'package:elscus/core/models/booking_models/booking_history_data_model.dart';
import 'package:elscus/core/models/booking_models/booking_history_model.dart';
import 'package:elscus/core/models/booking_models/pending_booking_model.dart';
import 'package:elscus/core/models/date_check_models/date_check_editting.dart';
import 'package:elscus/core/models/working_time_model/slot_data_model.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/presentation/update_booking/screen/update_booking_screen.dart';
import 'package:elscus/process/event/booking_event.dart';
import 'package:elscus/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../core/utils/globals.dart' as globals;
import '../../presentation/confirm_payment_screen/confirm_payment_screen.dart';
import '../../presentation/widget/dialog/fail_dialog.dart';

class BookingBloc {
  final eventController = StreamController<BookingEvent>();

  final stateController = StreamController<BookingState>();

  List<SlotDataModel> listSlot = [];
  int? workTime;
  String? startTime;
  DateTime? pickedDate;
  int? estimateTime;
  List<DateTime>? listWorkingDate = [];
  String description = "";
  Map<DateTime, AddBookingDetailDto> mapSlot = {};
  bool enableFixDay = true;
  SlotDataModel pickedSlot = SlotDataModel(slots: "");
  bool enableFixTimeAllDay = false;
  List<BookingHistoryDataModel> listData=[];

  bool isLoading = false;

  bool isWaiting = false;

  BookingBloc() {
    eventController.stream.listen((event) async {
      print(event);
      if (event is OtherBookingEvent) {
        stateController.sink.add(OtherBookingState()); //Test schedule event
      }

      if (event is ChooseStartTimeBookingEvent) {
        startTime = event.time;
        stateController.sink.add(ChooseStartTimeBookingState(
            hour: startTime!.split("-")[0], minute: startTime!.split("-")[1]));
      }
      if (event is AddTimeBookingEvent) {
        List<AddBookingDetailDto> listBookingDetail = [];
        if (pickedSlot.slots != "") {
          BookingDataModel bookModelAddTime = event.booking;
          var sortedKeys = mapSlot.keys.toList()..sort();
          for (var element in sortedKeys) {
            listBookingDetail.add(AddBookingDetailDto(
                estimateTime: mapSlot[element]!.estimateTime,
                image: mapSlot[element]!.image,
                startDateTime: mapSlot[element]!.startDateTime,
                endDateTime: mapSlot[element]!.endDateTime));
          }
          bookModelAddTime.addBookingDetailDtos = listBookingDetail;
          print(listBookingDetail.length);
          // AddBookingDetailDto dto = AddBookingDetailDto(
          //     estimateTime: estimateTime!,
          //     image: "image",
          //     startDateTime: MyUtils().getStartAndEndDateTime(
          //         pickedDate!, startTime!, estimateTime!)[0],
          //     endDateTime: MyUtils().getStartAndEndDateTime(
          //         pickedDate!, startTime!, estimateTime!)[1]);
          // List<AddBookingDetailDto> listDto = [];
          // listDto.add(dto);
          // bookModelAddTime.addBookingDetailDtos = listDto;
          // bookModelAddTime.startDate = MyUtils()
          //     .getStartAndEndDateTime(pickedDate!, startTime!, estimateTime!)[0]
          //     .split("T")[0];

          // bookModelAddTime.endDate = MyUtils()
          //     .getStartAndEndDateTime(pickedDate!, startTime!, estimateTime!)[1]
          //     .split("T")[0];

          Navigator.push(
              event.context,
              MaterialPageRoute(
                builder: (context) => ConfirmPaymentScreen(
                  booking: bookModelAddTime,
                  packageName: event.packageName,
                  elderName: event.elderName,
                  totalPrice: event.totalPrice,
                ),
              ));
        } else {
          showFailDialog(event.context, "Vui lòng chọn thời gian");
        }
      }
      if (event is AddTimeWeekBookingEvent) {
        List<AddBookingDetailDto> listBookingDetail = [];
        BookingDataModel bookModelAddTime = event.booking;
        var sortedKeys = mapSlot.keys.toList()..sort();
        print(sortedKeys.length);
        for (var element in sortedKeys) {
          listBookingDetail.add(AddBookingDetailDto(
              estimateTime: mapSlot[element]!.estimateTime,
              image: mapSlot[element]!.image,
              startDateTime: mapSlot[element]!.startDateTime,
              endDateTime: mapSlot[element]!.endDateTime));
        }
        bookModelAddTime.addBookingDetailDtos = listBookingDetail;
        if (sortedKeys.length < 2) {
          showFailDialog(event.context, "Số ngày tối thiểu : 2 ngày");
        } else if (event.booking.addBookingDetailDtos[0].startDateTime != "") {
          // if (startTime != null &&
          //     listWorkingDate != null &&
          //     listWorkingDate!.isNotEmpty) {
          //   BookingDataModel bookModelAddTime = event.booking;
          //   List<AddBookingDetailDto> listDto = [];
          //   for (DateTime curDate in listWorkingDate!) {
          //     AddBookingDetailDto dto = AddBookingDetailDto(
          //         estimateTime: estimateTime!,
          //         image: "",
          //         startDateTime: MyUtils().getStartAndEndDateTime(
          //             curDate, startTime!, estimateTime!)[0],
          //         endDateTime: MyUtils().getStartAndEndDateTime(
          //             curDate, startTime!, estimateTime!)[1]);

          //     listDto.add(dto);
          //   }
          //   listDto.sort(
          //     (a, b) {
          //       String dateA = a.startDateTime.split("T")[0];
          //       String dateB = b.startDateTime.split("T")[0];
          //       if (int.parse(dateA.split("-")[0]) >
          //           int.parse(dateB.split("-")[0])) {
          //         return 1;
          //       } else if (int.parse(dateA.split("-")[0]) <
          //           int.parse(dateB.split("-")[0])) {
          //         return -1;
          //       } else {
          //         if (int.parse(dateA.split("-")[1]) >
          //             int.parse(dateB.split("-")[1])) {
          //           return 1;
          //         } else if (int.parse(dateA.split("-")[1]) <
          //             int.parse(dateB.split("-")[1])) {
          //           return -1;
          //         } else {
          //           if (int.parse(dateA.split("-")[2]) >
          //               int.parse(dateB.split("-")[2])) {
          //             return 1;
          //           } else if (int.parse(dateA.split("-")[2]) <
          //               int.parse(dateB.split("-")[2])) {
          //             return -1;
          //           } else {
          //             return 0;
          //           }
          //         }
          //       }
          //     },
          //   );
          //   bookModelAddTime.addBookingDetailDtos = listDto;
          //   bookModelAddTime.startDate = listDto[0].startDateTime.split("T")[0];
          //   bookModelAddTime.endDate =
          //       listDto[listDto.length - 1].endDateTime.split("T")[0];

          //   print('test start date: ${bookModelAddTime.startDate}');
          //   print('test end date: ${bookModelAddTime.endDate}');

          Navigator.push(
              event.context,
              MaterialPageRoute(
                builder: (context) => ConfirmPaymentScreen(
                  booking: bookModelAddTime,
                  packageName: event.packageName,
                  elderName: event.elderName,
                  totalPrice: event.totalPrice,
                ),
              ));
        } else {
          showFailDialog(event.context, "Vui lòng chọn thời gian");
        }
      }
      if (event is ChooseDateOnlyBookingEvent) {
        pickedDate = event.pickedDate;
        addTimeOnlyDate();
      }
      if (event is ChooseMultiDateBookingEvent) {
        // bool isChoosedDate = false;
        pickedDate = event.pickedDate;
        String keyStr = DateFormat("yyyy-MM-dd").format(pickedDate!);

        if (mapSlot.containsKey(DateFormat("yyyy-MM-dd").parse(keyStr))) {
          mapSlot.remove(DateFormat("yyyy-MM-dd").parse(keyStr));
        } else {
          print("hehe");
          addMultiDate();
          listWorkingDate!.add(event.pickedDate);
        }

        // if (listWorkingDate != null) {
        //   for (DateTime curDate in listWorkingDate!) {
        //     if (event.pickedDate.year == curDate.year &&
        //         event.pickedDate.month == curDate.month &&
        //         event.pickedDate.day == curDate.day) {
        //       isChoosedDate = true;
        //     }
        //   }
        //   if (isChoosedDate) {
        //     listWorkingDate!.removeWhere((element) =>
        //         (event.pickedDate.year == element.year &&
        //             event.pickedDate.month == element.month &&
        //             event.pickedDate.day == element.day));
        //   } else {
        //     listWorkingDate!.add(event.pickedDate);
        //   }
        // } else {
        //   listWorkingDate = [];
        //   listWorkingDate!.add(event.pickedDate);
        // }
        stateController.sink
            .add(ChooseMultiDateBookingState(listWorkingDate: mapSlot));
      }
      if (event is AddEstimateTime) {
        estimateTime = event.estimate;
      }
      if (event is CreateBookingEvent) {
        // print('Test booking in bookingBloc: ${event.booking.toString()}');
        // print('Test endDateTime in bookingBloc: ${event.booking.addBookingDetailDtos[0].endDateTime}');
        createBookingV2(event.context, event.booking);
      }
      if (event is GetListBookingByStatusBookingEvent) {
        getListBookingByStatus(event.status);
      }

      if (event is GetFullDetailBookingEvent) {
        getBookingFullDetail(event.bookingID);
      }
      if (event is CusPaidForBookingEvent) {
        cusPaidForBooking(
            event.context, event.bookingID, event.paymentMethod, event.type);
      }
      if (event is GetAllHistoryBookingEvent) {
        getAllHistory();
      }
      if (event is FillDescriptionBookingEvent) {
        description = event.description;
      }
      if (event is GetAllSlotWorking) {
        listSlot = await getAllSlot();
        stateController.sink.add(HaveSlotWorkingState(listSlot: listSlot));
      }
      if (event is FixTimeAllDay) {
        int numDay = (event as FixTimeAllDay).numDay;
        enableFixDay = !enableFixDay;
        stateController.sink.add(ChangeStateRatioFixDayState());
      }
      if (event is ChooseTimeOnlyBooking) {
        pickedSlot = event.slotSelected;
        addTimeOnlyDate();
      }
      if (event is CusChangeSitterEvent) {
        try{
          isWaiting = false;
          await cusChangeSitterBooking(event.context, event.bookingID);
          isWaiting = true;
        } catch (e){
          isWaiting = false;
        }
      }
      if (event is ChooseTimeMultiBooking) {
        pickedSlot = event.slotSelected;
        for (var element in mapSlot.keys) {
          mapSlot[element] = AddBookingDetailDto(
              estimateTime: estimateTime!,
              image: "image",
              startDateTime: pickedSlot.slots == ""
                  ? ""
                  : DateFormat("yyyy-MM-dd").format(element) +
                      " " +
                      pickedSlot.slots.split("-")[0].split(" ")[1],
              endDateTime: pickedSlot.slots == ""
                  ? ""
                  : DateFormat("yyyy-MM-dd").format(element) +
                      " " +
                      pickedSlot.slots.split("-")[1]);
          print("${element} ${mapSlot[element]}");
        }

        stateController.sink
            .add(ChooseMultiDateBookingState(listWorkingDate: mapSlot));

        // String keyStr = DateFormat("yyyy-MM-dd").format(pickedDate!);

        // if (mapSlot.containsKey(DateFormat("yyyy-MM-dd").parse(keyStr))) {
        //   mapSlot[DateFormat("yyyy-MM-dd").parse(keyStr)] = AddBookingDetailDto(
        //       estimateTime: estimateTime!,
        //       image: "image",
        //       startDateTime: pickedSlot.slots == ""
        //           ? ""
        //           : keyStr + " " + pickedSlot.slots.split("-")[0],
        //       endDateTime: pickedSlot.slots == ""
        //           ? ""
        //           : keyStr + " " + pickedSlot.slots.split("-")[1]);
        // } else {}
      }

      if (event is GetAllHistoryByStatusBookingEvent) {
        getAllHistoryByStatus(event.status);
      }
      if (event is ClickReduceDayOptionEvent) {
        
      }
      if(event is FetchDataHistory){
      BookingHistoryModel? dataModel=  await fetchDataByStatusHealth(event.status);
      if(dataModel!=null){
        listData=dataModel.data;
        print("null");
      }else{
        listData=[];
      }
      stateController.sink.add(OtherBookingState());
      }
      
    });
  }

  Future<void> getBookingFullDetail(String bookingID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/common/get-full-detail-booking/$bookingID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('test getBookingFullDetail status code: ${response.statusCode}');
      log("data 2 ${response.body}");
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetFullDetailBookingState(
            booking:
                BookingFullDetailModel.fromJson(json.decode(response.body))));
      } else {
        // throw Exception('Unable to fetch Booking from the REST API');
        if (kDebugMode) {
          print(json.decode(response.body).toString());
        }
      }
    } finally {}
  }

  Future<void> getListBookingByStatus(String status) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-all-booking-by-status-and-customer_id/$status/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('test getListBookingByStatus status code: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        if (status == "PENDING") {
          stateController.sink.add(GetListPendingBookingBookingState(
              listBooking:
                  PendingBookingModel.fromJson(json.decode(response.body))));
        }
      } else {
        throw Exception('Unable to fetch Booking from the REST API');
      }
    } finally {}
  }

  Future<void> getAllHistoryByStatus(String status) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-all-booking-by-status-and-customer_id/$status/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('test getAllHistoryByStatus status code: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllHistoryByStatusBookingState(
            bookingHistoryList:
                BookingHistoryModel.fromJson(json.decode(response.body))));
      } else {
        if (kDebugMode) {
          print(json.decode(response.body)["message"].toString());
        }
      }
    } finally {}
  }

  Future<void> createBooking(
      BuildContext context, BookingDataModel booking) async {
    try {
      print('Test address: ${booking.address}');

      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/createV2");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "address": booking.address,
            "startDate": "2023-04-18",
            "endDate": "2023-04-18",
            "description": booking.description,
            "elderId": booking.elderId,
            "customerId": globals.customerID,
            "packageId": booking.packageId,
            "dates": ["2023-04-18"],
            "startTime": "22:00"
          },
        ),
      );
      print('test createBooking status code: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Đặt lịch thành công",
                  buttonName: "Trang chủ",
                  navigatorPath: '/homeScreen'),
            ),
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> cusChangeSitterBooking(
      BuildContext context, String bookingID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/changeSitter/$bookingID");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('test cus change sitter status code: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Thay đổi csv thành công",
                  buttonName: "Trang chủ",
                  navigatorPath: '/homeScreen'),
            ),
                (route) => false);
      } else {
        BuildContext context2=context;
        Navigator.pop(context);
        showFailDialog(
            context2, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
  Future<void> createBookingV2(
      BuildContext context, BookingDataModel booking) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/createV2");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "address": booking.address,
            "place": booking.place,
            "startDate": booking.startDate,
            "endDate": booking.endDate,
            "description": booking.description,
            "elderId": booking.elderId,
            "customerId": booking.customerId,
            "packageId": booking.packageId,
            "addBookingDetailDTOS": List<dynamic>.from(
                booking.addBookingDetailDtos.map((x) => x.toJson())),
          },
        ),
      );
      print('test createBooking status code: ${response.statusCode}');
      print('test createBooking status code: ${response.body}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Đặt lịch thành công",
                  buttonName: "Trang chủ",
                  navigatorPath: '/homeScreen'),
            ),
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> cusPaidForBooking(BuildContext context, String bookingID,
      String paymentMethod, String type) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/payment/mobile/pay");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "type": type,
            "paymentMethod": paymentMethod,
            "bookingId": bookingID
          },
        ),
      );
      print('test cusPaidForBooking status code: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Thanh toán thành công",
                  buttonName: "Trở về trang chủ",
                  navigatorPath: "/homeScreen"),
            ),
            (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getAllHistory() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-all-booking-history-by-customer/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllHistoryBookingState(
            bookingHistoryList:
                BookingHistoryModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch test from the REST API');
      }
    } finally {}
  }

  Future<List<SlotDataModel>> getAllSlot() async {
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
        throw Exception('Unable to fetch slot from the REST API');
      }
    } finally {}
  }

  addTimeOnlyDate() {
    mapSlot = {};
    if (pickedDate != null && pickedSlot.slots != "") {
      String key = DateFormat("yyyy-MM-dd").format(pickedDate!);

      mapSlot.putIfAbsent(
          DateFormat("yyyy-MM-dd").parse(key),
          () => AddBookingDetailDto(
              estimateTime: estimateTime!,
              image: "image",
              startDateTime:
                  key + " " + pickedSlot.slots.split("-")[0].split(' ')[1],
              endDateTime: key + " " + pickedSlot.slots.split("-")[1]));
    }
    print("hi" + mapSlot.toString());
  }

  addTimeMultiDate() {
    if (pickedDate != null && pickedSlot.slots != "") {
      String key = DateFormat("yyyy-MM-dd").format(pickedDate!);

      mapSlot.putIfAbsent(
          DateFormat("yyyy-MM-dd").parse(key),
          () => AddBookingDetailDto(
              estimateTime: estimateTime!,
              image: "image",
              startDateTime:
                  key + " " + pickedSlot.slots.split("-")[0].split(' ')[1],
              endDateTime: key + " " + pickedSlot.slots.split("-")[1]));
    }
    print("hi" + mapSlot.toString());
  }

  addMultiDate() {
    String key = DateFormat("yyyy-MM-dd").format(pickedDate!);
    mapSlot.putIfAbsent(
        DateFormat("yyyy-MM-dd").parse(key),
        () => AddBookingDetailDto(
            estimateTime: estimateTime!,
            image: "image",
            startDateTime: pickedSlot.slots == ""
                ? ""
                : key + " " + pickedSlot.slots.split("-")[0].split(' ')[1],
            endDateTime: pickedSlot.slots == ""
                ? ""
                : key + " " + pickedSlot.slots.split("-")[1]));
    listWorkingDate!.add(DateFormat("yyyy-MM-dd").parse(key));
    pickedSlot.slots = "";
    print(mapSlot.keys.length.toString());
  }
  Future<BookingHistoryModel?> fetchDataByStatusHealth(String status) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-all-booking-by-status-and-customer_id/$status/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      log('data: ${response.body}');
      print('test fetchDataByStatusHealth status code: ${response.body}');
      if (response.statusCode.toString() == '200') {
       return
                BookingHistoryModel.fromJson(json.decode(response.body));
      } else {
        if (kDebugMode) {
          print(json.decode(response.body)["message"].toString());
        }
      }
    } finally {}
  }
  
}
