import 'package:elscus/core/models/package_service_models/service_dto.dart';
import 'package:intl/intl.dart';

class MyUtils {
  double getPackageCostPrice(List<ServiceDto> serviceDtos) {
    double totalPrice = 0;
    for (ServiceDto dto in serviceDtos) {
      totalPrice += dto.price;
    }
    return totalPrice;
  }
  String convertDateToStringInput(DateTime date) {
    return "${date.year}-${(date.month > 9) ? date.month : "0${date
        .month}"}-${(date.day > 9) ? date.day : "0${date.day}"}T${(date.hour >
        9) ? date.hour : "0${date.hour}"}:${(date.minute > 9)
        ? date.minute
        : "0${date.minute}"}";
  }

  String convertInputDateFromDateTime(DateTime date) {
    return "${date.year}-${(date.month > 9) ? date.month : "0${date.month}"}-${(date.day > 9) ? date.day : "0${date.day}"}";
  }

  List<String> getStartAndEndDateTime(
      DateTime pickedDate, String startTime, int estimateTime) {
    String startDateTime = "";
    String endDateTime = "";
    List<String> listTime = [];
    int hour = int.parse(startTime.split("-")[0]);
    int minute = int.parse(startTime.split("-")[1]);
    if ((hour + estimateTime) >= 24) {
      startDateTime =
          "${pickedDate.year}-${(pickedDate.month > 9) ? pickedDate.month : "0${pickedDate.month}"}-${(pickedDate.day > 9) ? pickedDate.day : "0${pickedDate.day}"}T${(hour > 9) ? hour : "0$hour"}:${(minute > 9) ? minute : "0$minute"}";
      DateTime nextDate = pickedDate.add(const Duration(days: 1));
      int endHour = (hour + estimateTime) - 24;
      endDateTime =
          "${nextDate.year}-${(nextDate.month > 9) ? nextDate.month : "0${nextDate.month}"}-${(nextDate.day > 9) ? nextDate.day : "0${nextDate.day}"}T${(endHour > 9) ? endHour : "0$endHour"}:${(minute > 9) ? minute : "0$minute"}";
    } else {
      startDateTime =
          "${pickedDate.year}-${(pickedDate.month > 9) ? pickedDate.month : "0${pickedDate.month}"}-${(pickedDate.day > 9) ? pickedDate.day : "0${pickedDate.day}"}T${(hour > 9) ? hour : "0$hour"}:${(minute > 9) ? minute : "0$minute"}";
      int endHour = (hour + estimateTime);
      endDateTime =
          "${pickedDate.year}-${(pickedDate.month > 9) ? pickedDate.month : "0${pickedDate.month}"}-${(pickedDate.day > 9) ? pickedDate.day : "0${pickedDate.day}"}T${(endHour > 9) ? endHour : "0$endHour"}:${(minute > 9) ? minute : "0$minute"}";
    }
    listTime.add(startDateTime);
    listTime.add(endDateTime);
    return listTime;
  }

  DateTime convertDateFromStr(String date) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parseLoose(date);
    return dateTime;
  }

  String displayDateTimeInScheduleItem(String dateTime) {
    String date = dateTime.split("T")[0];
    String time = dateTime.split("T")[1];
    return "${date.split("-")[2]}-${date.split("-")[1]} ${time.split(":")[0]}:${time.split(":")[1]}";
  }
  String revertYMD(String date){
    return "${date.split("-")[2]}-${date.split("-")[1]}-${date.split("-")[0]}";
  }
}
