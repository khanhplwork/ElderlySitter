import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elscus/core/models/package_service_models/package_service_detail_model.dart';
import 'package:elscus/core/models/package_service_models/package_service_model.dart';
import 'package:elscus/core/utils/math_lib.dart';
import 'package:elscus/core/validators/validations.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/process/event/package_service_event.dart';
import 'package:elscus/process/state/package_service_state.dart';

import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/models/elder_models/elder_model.dart';
import '../../core/utils/globals.dart' as globals;
import '../../presentation/widget/dialog/fail_dialog.dart';

class PackageServiceBloc{
  final eventController = StreamController<PackageServiceEvent>();

  final stateController = StreamController<PackageServiceState>();

  PackageServiceBloc(){
    eventController.stream.listen((event) {
      if(event is GetAllPackageServiceEvent){
        getAllPackageService();
      }
      if(event is GetPackageDetailPackageServiceEvent){
        getPackageServiceDetail(event.packageID);
      }
      if(event is GetRandomPackageServiceEvent){
        getRandomPackageService(event.count);

      }
    });
  }
  Future<void> getRandomPackageService(int count) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/package/mobile/random_package/$count");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetRandomPackageServiceState(
            listPackage: PackageServiceModel.fromJson(json.decode(response.body)).data));
      } else {
        throw Exception('Unable to fetch package from the REST API');
      }
    } finally {}
  }
  Future<void> getAllPackageService() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/package/mobile/activate-packages");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllPackageServiceState(
            listPackage: PackageServiceModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch package from the REST API');
      }
    } finally {}
  }
  Future<void> getPackageServiceDetail(String packageID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/package/mobile/package/$packageID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetPackageDetailPackageServiceState(
            packageDetail: PackageServiceDetailModel.fromJson(json.decode(response.body)).data));
      } else {
        throw Exception('Unable to fetch package from the REST API');
      }
    } finally {}
  }
}
