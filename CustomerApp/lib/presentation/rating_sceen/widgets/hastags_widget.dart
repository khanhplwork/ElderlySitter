import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/process/bloc/rating_bloc.dart';
import 'package:elscus/process/event/rating_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/globals.dart' as globals;

StatefulWidget hastagsWidget(BuildContext context, double ratingStar, List<String> listChooseHashTag, RatingBloc ratingBloc) {
  var size = MediaQuery.of(context).size;
  List<String> listHastag = [];
  if(ratingStar == 1.0){
    listHastag = globals.hashtagStar1;
  }else if(ratingStar == 2.0){
    listHastag = globals.hashtagStar2;
  }else if(ratingStar == 3.0){
    listHastag = globals.hashtagStar3;
  }else if(ratingStar == 4.0){
    listHastag = globals.hashtagStar4;
  }else if(ratingStar == 5.0){
    listHastag = globals.hashtagStar5;
  }
  bool isChoosedHashTag(String curHashTag){
    for(String hashTag in listChooseHashTag){
      if(hashTag == curHashTag){
        return true;
      }
    }
    return false;
  }
  if (listHastag.isNotEmpty) {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        width: size.width,
        height: size.height * 0.08,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.separated(
            padding: EdgeInsets.only(
              top: size.height*0.02,

            ),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  ratingBloc.eventController.sink.add(ChooseHashTagRatingEvent(hashTag: listHastag[index]));
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: size.width*0.05,
                    right: size.width*0.05,
                    top: size.height*0.005,
                    bottom: size.height*0.005,
                  ),
                  decoration: BoxDecoration(
                    color: (isChoosedHashTag(listHastag[index]))? ColorConstant.primaryColor :ColorConstant.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(size.height*0.03),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.primaryColor.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(
                            0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    listHastag[index],
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height*0.02,
                      color: (isChoosedHashTag(listHastag[index]))? Colors.white :ColorConstant.primaryColor,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: size.width*0.03,),
            itemCount: listHastag.length,
          ),
        ),
      ),
    );
  } else {
    return StatefulBuilder(
      builder: (context, setState) => const SizedBox(),
    );
  }
}
