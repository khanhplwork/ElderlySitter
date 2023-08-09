class MathLib{
  String getWeekDate(DateTime date){
    if(date.weekday == 1){
      return "T2";
    }else if(date.weekday == 2){
      return "T3";
    }else if(date.weekday == 3){
      return "T4";
    }else if(date.weekday == 4){
      return "T5";
    }else if(date.weekday == 5){
      return "T6";
    }else if(date.weekday == 6){
      return "T7";
    }else if(date.weekday == 7){
      return "CN";
    }else{
      return "";
    }
  }
  String convertInputElderDob(String dob){
    List<String> dobStr = dob.split("-");
    return "${dobStr[2]}-${dobStr[1]}-${dobStr[0]}";
  }

}