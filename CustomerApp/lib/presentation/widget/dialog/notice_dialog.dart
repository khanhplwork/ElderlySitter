import 'package:flutter/Material.dart';

Future<void> showNoticeDialog(BuildContext context, String noticeMsg) async {
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
            noticeMsg,
          ),
        )),
        actions: <Widget>[
          TextButton(
            child: const Text('Xác nhận'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
