import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_bloc.dart';
import 'package:elscus/presentation/booking_v2/confirmpay/bloc/confirm_pay_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailPayWidget extends StatelessWidget {
  const FailPayWidget(
      {super.key, required this.message, required this.blocConfirm});

  final String message;
  final ConfirmPayBloc blocConfirm;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstant.imgFail,
              width: size.width * 0.64,
              height: size.width * 0.5,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Thất bại',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: ColorConstant.red1,
                fontWeight: FontWeight.w800,
                fontSize: size.height * 0.04,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              message,
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
            Container(
              width: size.width * 0.4,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.red1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                // ignore: sort_child_properties_last
                child: Row(children: [
                  Container(
                    width: size.width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      'Xác nhận',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                ]),
                onPressed: () {
                  blocConfirm.stateController.add(OtherConfirmPayState());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
