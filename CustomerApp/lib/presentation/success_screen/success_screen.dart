import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatefulWidget {
  final String content;
  final String buttonName;
  final String navigatorPath;

  const SuccessScreen(
      {Key? key,
      required this.content,
      required this.buttonName,
      required this.navigatorPath})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SuccessScreen> createState() => _SuccessScreenState(
        content: content,
        buttonName: buttonName,
        navigatorPath: navigatorPath,
      );
}

class _SuccessScreenState extends State<SuccessScreen> {
  String content;
  String buttonName;
  String navigatorPath;

  _SuccessScreenState(
      {required this.content,
      required this.buttonName,
      required this.navigatorPath});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: Container(
        width: size.width*0.84,
        height: size.height*0.06,

        child: ElevatedButton(
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, navigatorPath, (route) => false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            buttonName,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: size.height*0.024,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding:
            EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.07),
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgSuccress),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.15),
            Image.asset(
              ImageConstant.icSuccess,
              width: size.width * 0.6,
              height: size.height * 0.3,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Thành công',
              style: GoogleFonts.roboto(
                color: ColorConstant.primaryColor,
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              content,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w400,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
