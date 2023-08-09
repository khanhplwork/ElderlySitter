import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elscus/process/event/rating_event.dart';
import 'package:elscus/process/state/rating_state.dart';
import 'package:flutter/Material.dart';

import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;
import '../../presentation/success_screen/success_screen.dart';
import '../../presentation/widget/dialog/fail_dialog.dart';
class RatingBloc{
  final eventController = StreamController<RatingEvent>();
  final stateController = StreamController<RatingState>();
  double? ratingStar;
  String content = "";
  List<String> listHashTag = [];
  final Map<String, String> errors = HashMap();
  RatingBloc(){
    eventController.stream.listen((event) {
      if(event is OtherRatingEvent){
        stateController.sink.add(OtherRatingState());
      }
      if(event is ChooseStarRatingEvent){
        ratingStar = event.ratingStar;
        listHashTag = [];
        errors.remove("rate");
      }
      if(event is FillContentRatingEvent){
        content = event.content;
      }
      if(event is ChooseHashTagRatingEvent){
        if(listHashTag.contains(event.hashTag)){
          listHashTag.remove(event.hashTag);
        }else{
          listHashTag.add(event.hashTag);
        }
        stateController.sink.add(ChooseHashTagRatingState(listChoosedHashTag: listHashTag));
      }
      if(event is ConfirmRatingEvent){
        if(ratingStar != null){

          rating(event.context, event.bookingID);
        }else{
          errors.addAll({"rate": "Vui lòng chọn số sao"});
          stateController.sink.addError(errors);
        }
      }
    });
  }
  Future<void> rating(BuildContext context, String bookingID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/rating/mobile/add");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "rate": ratingStar,
            "comment": content,
            "hagTag": listHashTag.toString(),
            "bookingId": bookingID
          },
        ),
      );
      print('Test report rating:${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SuccessScreen(content: "Đánh giá thành công", buttonName: "Trở về trang chủ", navigatorPath: '/homeScreen'),));
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}