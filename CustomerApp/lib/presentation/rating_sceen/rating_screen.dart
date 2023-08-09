import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/core/models/booking_models/sitter_dto.dart';
import 'package:elscus/presentation/rating_sceen/widgets/hastags_widget.dart';
import 'package:elscus/process/bloc/rating_bloc.dart';
import 'package:elscus/process/event/rating_event.dart';
import 'package:elscus/process/state/rating_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class RatingScreen extends StatefulWidget {
  RatingScreen({Key? key, required this.bookingID, required this.sitter})
      : super(key: key);
  String bookingID;
  SitterDto sitter;

  @override
  State<RatingScreen> createState() =>
      // ignore: no_logic_in_create_state
      _RatingScreenState(bookingID: bookingID, sitter: sitter);
}

class _RatingScreenState extends State<RatingScreen> {
  _RatingScreenState({required this.bookingID, required this.sitter});

  String bookingID;
  SitterDto sitter;
  final ratingBloc = RatingBloc();
  double ratingStar = 0.0;
  List<String> listHashtag = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: ratingBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is ChooseHashTagRatingState) {
            listHashtag =
                (snapshot.data as ChooseHashTagRatingState).listChoosedHashTag;
            ratingBloc.stateController.sink.add(OtherRatingState());
          }
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstant.primaryColor,
            toolbarHeight: 0,
            elevation: 0,
            bottomOpacity: 0,
            automaticallyImplyLeading: false,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            color: Colors.white,
            width: size.width,
            height: size.height * 0.12,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    ratingBloc.eventController.sink.add(ConfirmRatingEvent(
                        context: context, bookingID: bookingID));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    textStyle: TextStyle(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  child: const Text("Xác nhận"),
                ),
              ),
            ),
          ),
          body: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                color: ColorConstant.primaryColor,
                image: DecorationImage(
                    image: AssetImage(ImageConstant.bgRating),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            size: size.height * 0.03,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          "Đánh Giá",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: size.height * 0.08,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    width: size.width,
                    alignment: Alignment.center,
                    child: Container(
                      width: size.height * 0.15,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(sitter.image),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Chăm sóc viên',
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    sitter.fullName!,
                    style: GoogleFonts.roboto(
                        fontSize: size.height * 0.026,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "Cảm nhận của bạn thế nào?",
                    style: GoogleFonts.roboto(
                        fontSize: size.height * 0.026,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: size.height * 0.03),
                  RatingBar.builder(
                    itemSize: size.height * 0.05,
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    unratedColor: ColorConstant.primaryColor.withOpacity(0.2),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: ColorConstant.primaryColor,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        ratingStar = rating;
                        ratingBloc.eventController.sink
                            .add(ChooseStarRatingEvent(ratingStar: ratingStar));
                      });
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  (snapshot.hasError &&
                          (snapshot.error as Map<String, String>)
                              .containsKey("rate"))
                      ? Text(
                          (snapshot.error as Map<String, String>)["rate"]!,
                          style: GoogleFonts.roboto(
                            fontSize: size.height*0.016,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.redErrorText,
                          ),
                        )
                      : const SizedBox(),
                  hastagsWidget(context, ratingStar, listHashtag, ratingBloc),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: null,
                        onChanged: (value) {
                          ratingBloc.eventController.sink.add(
                              FillContentRatingEvent(
                                  content: value.toString()));
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.04,
                            right: size.width * 0.04,
                            top: size.height * 0.04,
                          ),
                          // filled: true,
                          // fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: ColorConstant.grayEE,
                          ),
                          hintText: "Nội dung",

                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        maxLines: 6,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.2,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
