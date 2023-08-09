import 'package:elscus/presentation/elder_screen/widget/check_elder_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/image_constant.dart';
import '../../../core/constants/color_constant.dart';

Future<void> showCheckElderDialog(BuildContext context, String idNumber) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstant.imgForWard,
                width: size.width * 0.64,
                height: size.width * 0.5,
              ),

              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Thân nhân đã được đăng ký.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: ColorConstant.gray4A,
                  fontWeight: FontWeight.normal,
                  fontSize: size.height * 0.022,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.yellowFF,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  // ignore: sort_child_properties_last
                  child: Row(children: [
                    Container(
                      width: size.width * 0.44,
                      alignment: Alignment.center,
                      child: Text(
                        'Kiểm tra thông tin',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.02,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_forward,
                          size: size.height * 0.03,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                  onPressed: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckElderScreen(idNumber: idNumber),))),
              SizedBox(
                height: size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Quay lại",
                  style: GoogleFonts.roboto(
                    color: ColorConstant.yellowFF,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.02,
                  ),
                ),
              )
            ],
          ),
        )),
      );
    },
  );
}
