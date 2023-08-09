import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailScreen extends StatefulWidget {
  final String content;
  final String buttonName;
  final String navigatorPath;

  const FailScreen(
      {Key? key,
        required this.content,
        required this.buttonName,
        required this.navigatorPath})
      : super(key: key);

  @override
  State<FailScreen> createState() => _FailScreenState(
    content: content,
    buttonName: buttonName,
    navigatorPath: navigatorPath,
  );
}

class _FailScreenState extends State<FailScreen> {
  String content;
  String buttonName;
  String navigatorPath;

  _FailScreenState(
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
            Navigator.pushNamed(context, navigatorPath);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
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
            image: AssetImage(ImageConstant.bgFail),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.15),
            Image.asset(
              ImageConstant.icFail,
              width: size.width * 0.6,
              height: size.height * 0.3,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Thất bại',
              style: GoogleFonts.roboto(
                color: ColorConstant.redFail,
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              content,
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
