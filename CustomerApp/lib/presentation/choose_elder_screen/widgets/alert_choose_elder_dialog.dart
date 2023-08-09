import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showChooseElderAlertDialog(BuildContext context) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                "Vui lòng chọn thân nhân được chăm sóc",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: size.height*0.022,
                ),
              ),
            )
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Thêm thông tin thân nhân'),
            onPressed: () {
              Navigator.pushNamed(context, '/elderScreen');
            },
          ),
        ],
      );
    },
  );
}