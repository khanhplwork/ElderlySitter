
  
import 'dart:convert';

import 'package:elscus/presentation/booking_v2/choose_package/model/package_model_v2.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/globals.dart' as globals;

class BookingPackageApi{
 static Future<List<PackageModelV2>> fetchListPackage(String statusHealth)async{
    List<PackageModelV2> list=[];
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/package/mobile/get-all-by-activate-and-healthStatus/${statusHealth}");
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
        list = mapData.map<PackageModelV2>((json) {
          return PackageModelV2.fromJson(json);
        }).toList();
        return list;
      } else {
        print(response.statusCode);
        throw Exception('Unable to fetch Schedule from the REST API');
      }
    } finally {
    }
  }
}