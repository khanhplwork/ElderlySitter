// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elscus/core/models/elder_models/elder_detail_model.dart';
import 'package:elscus/core/utils/math_lib.dart';
import 'package:elscus/core/validators/validations.dart';
import 'package:elscus/presentation/elder_screen/widget/check_elder_dialog.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/process/event/elder_event.dart';
import 'package:elscus/process/state/elder_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/models/elder_models/elder_check_model.dart';
import '../../core/models/elder_models/elder_model.dart';
import '../../core/utils/globals.dart' as globals;
import '../../presentation/widget/dialog/fail_dialog.dart';

class ElderBloc {
  final eventController = StreamController<ElderEvent>();

  final stateController = StreamController<ElderState>();
  String? fullName;
  String? dob;
  String? gender;
  String? healthStatus;
  String? idNumber;
  final Map<String, String> errors = HashMap();

  ElderBloc() {
    eventController.stream.listen((ElderEvent event) {
      if(event is OtherElderEvent){
        stateController.sink.add(OtherElderState());
      }
      if (event is ChooseElderGenderEvent) {
        gender = event.gender;
        errors.remove("gender");
      } else if (event is FillElderFullNameEvent) {
        fullName = event.fullName;
        errors.remove("fullName");
      } else if (event is ChooseElderDOBEvent) {
        dob = event.dob;
        errors.remove("dob");
      } else if (event is ChooseElderHeathStatusEvent) {
        healthStatus = event.healthStatus;
        errors.remove("healthStatus");
      } else if (event is UpdateElderEvent) {
        if (elderValidate()) {
          updateElder(event.context, event.elderID);
        } else {
          if (kDebugMode) {
            print('Elder Input fail');
          }
        }
      } else if (event is AddNewElderEvent) {
        if (elderValidate()) {
          createNewElder(event.context);
        } else {
          if (kDebugMode) {
            print('Elder Input fail');
          }
        }
      } else if (event is GetAllElderEvent) {
        getAllElder();
      } else if (event is GetElderDetailDataEvent) {
        getElderByID(event.elderID);
      } else if (event is DeleteElderEvent) {
        deleteElder(event.context, event.elderID);
      } else if (event is GetByHealthStatusElderEvent) {
        getElderByHealthStatus(event.healthStatus);
      } else if (event is FillIDCardNumberEvent) {
        idNumber = event.idNumber;
      } else if (event is GetCheckDataElderEvent) {
        getCheckDataElder(event.idNumber);
      }else if (event is AddRelationElderEvent) {
        addRelation(event.context, event.elderID);
      }else {
        if (kDebugMode) {
          print('Elder bloc do nothing');
        }
      }
    });
  }

  bool elderValidate() {
    bool isValid = false;
    bool isValidFullName = false;
    bool isValidDOB = false;
    bool isValidGender = false;
    bool isValidHealthStatus = false;
    bool isValidIDNumber = false;
    if (fullName == null || fullName!.trim().isEmpty) {
      errors.addAll({"fullName": "Vui lòng điền tên"});
    } else {
      errors.remove("fullname");
      isValidFullName = true;
    }
    if (dob == null || dob!.trim().isEmpty) {
      errors.addAll({"dob": "Vui lòng nhập ngày sinh"});
    } else {
      if (Validations.isValidElderAge(dob)) {
        errors.remove("dob");
        isValidDOB = true;
      } else {
        errors.addAll({"dob": "Tuổi của người thân phải >=50"});
      }
    }
    if (gender == null || gender!.trim().isEmpty) {
      errors.addAll({"gender": "Vui lòng chọn giới tính"});
    } else {
      errors.remove("gender");
      isValidGender = true;
    }
    if (healthStatus == null || healthStatus!.trim().isEmpty) {
      errors.addAll({"healthStatus": "Vui lòng chọn tình trạng sức khỏe"});
    } else {
      errors.remove("healthStatus");
      isValidHealthStatus = true;
    }
    if (idNumber == null || idNumber!.trim().isEmpty) {
      errors.addAll({"idNumber": "Vui lòng nhập cccd/cmnd"});
    } else {
      errors.remove("idNumber");
      isValidIDNumber = true;
    }
    if (isValidFullName &&
        isValidDOB &&
        isValidGender &&
        isValidHealthStatus &&
        isValidIDNumber) {
      stateController.sink.add(ElderOtherState());

      isValid = true;
    } else {
      stateController.sink.addError(errors);
    }

    return isValid;
  }

  Future<void> createNewElder(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/elder/mobile/create");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "fullName": fullName,
            "dob": dob!,
            "healthStatus": healthStatus,
            "note": "",
            "gender": gender,
            "idCardNumber": idNumber,
            "idCustomer": globals.customerID,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Thêm thông tin người thân mới thành công",
                  buttonName: "Quản lý người thân",
                  navigatorPath: '/elderScreen'),
            ),
            (route) => false);
      } else {
        if (json.decode(response.body)["message"].toString().contains(
            "Đã có người thân trong hệ thống vui lòng xác nhận có phải là người thân không")) {
          showCheckElderDialog(context, idNumber!);
        } else {
          showFailDialog(
              context, json.decode(response.body)["message"].toString());
        }
      }
    } finally {}
  }
  Future<void> addRelation(BuildContext context, String elderID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/elder/mobile/add-relationship");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "customerId": globals.customerID,
            "elderId": elderID,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Thêm thông tin người thân thành công",
                  buttonName: "Quản lý người thân",
                  navigatorPath: '/elderScreen'),
            ),
                (route) => false);
      } else {

          showFailDialog(
              context, json.decode(response.body)["message"].toString());

      }
    } finally {}
  }

  Future<void> getAllElder() async {
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
        stateController.sink.add(GetAllElderState(
            elderList: ElderModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch elder from the REST API');
      }
    } finally {}
  }
  Future<void> getCheckDataElder(String idNumber) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/elder/mobile/find-by/$idNumber");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetCheckDataElderState(
            elderCheckData: CheckElderModel.fromJson(json.decode(response.body)).data));
      } else {
        throw Exception('Unable to fetch elder check from the REST API');
      }
    } finally {}
  }

  Future<void> getElderByHealthStatus(String healthStatus) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/elder/mobile/get_all_health_status_and_customer/$healthStatus/${globals.customerID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetByHealthStatusElderState(
            elderList: ElderModel.fromJson(json.decode(response.body))));
      } else if (response.statusCode.toString() == '404') {
        stateController.sink.add(ElderOtherState());
      } else {
        throw Exception('Unable to fetch elder from the REST API');
      }
    } finally {}
  }

  Future<void> getElderByID(String elderID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/elder/mobile/$elderID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(ElderDetailState(
            elder: ElderDetailModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch elder from the REST API');
      }
    } finally {}
  }

  Future<void> updateElder(BuildContext context, String elderID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/elder/mobile/update");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "id": elderID,
            "fullName": fullName,
            "dob": dob!,
            "healthStatus": healthStatus,
            "note": "",
          },
        ),
      );

      if (response.statusCode.toString() == '200') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Thay đổi thông tin người thân mới thành công",
                  buttonName: "Quản lý người thân",
                  navigatorPath: '/elderScreen'),
            ));
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> deleteElder(BuildContext context, String elderID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/elder/mobile/remove/$elderID");
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );

      if (response.statusCode.toString() == '200') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                  content: "Xóa thông tin người thân thành công",
                  buttonName: "Quản lý người thân",
                  navigatorPath: '/elderScreen'),
            ));
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
