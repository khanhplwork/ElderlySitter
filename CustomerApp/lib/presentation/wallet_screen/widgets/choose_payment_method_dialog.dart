import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elscus/core/constants/image_constant.dart';
import 'package:elscus/process/bloc/payment_bloc.dart';
import 'package:elscus/process/event/payment_event.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_constant.dart';

Future<void> showChoosePaymentMethodDialog(BuildContext context) async {
  final List<String> paymentMethodItems = [
    'Thanh toán với Momo',
    'Khác',
  ];
  final _paymentBloc = PaymentBloc();
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return StreamBuilder<Object>(
          stream: _paymentBloc.stateController.stream,
          builder: (context, snapshot) {
            return AlertDialog(
              contentPadding: EdgeInsets.only(
                top: size.height*0.02,
              ),
              content: SingleChildScrollView(
                  child: Container(
                width: size.width*0.9,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: size.width * 0.03,
                      right: size.width * 0.03,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: GoogleFonts.roboto(
                      color: Colors.black,
                    ),
                    labelText: 'Phương thức thanh toán: ',
                    // errorText: (snapshot.hasError &&
                    //     (snapshot.error
                    //     as Map<String, String>)
                    //         .containsKey("gender"))
                    //     ? (snapshot.error
                    // as Map<String, String>)["gender"]
                    //     : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ),
                  hint: const Text(
                    'Chọn phương thức thanh toán',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                  ),
                  iconSize: size.width * 0.06,
                  buttonHeight: size.height * 0.07,
                  buttonPadding: const EdgeInsets.all(0),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: paymentMethodItems
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: [
                              _getIcon(context, item),
                              Text(
                                item,
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.022,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    _paymentBloc.eventController.sink.add(
                        ChoosePaymentMethodPaymentEvent(
                            paymentMethod: value.toString()));
                  },
                ),
              )),
              actions: <Widget>[
                TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Xác nhận'),
                  onPressed: () {
                    _paymentBloc.eventController.sink.add(ConfirmDepositMoneyIntoWalletPaymentEvent(context: context));
                  },
                ),
              ],
            );
          });
    },
  );
}

Widget _getIcon(BuildContext context, String method) {
  var size = MediaQuery.of(context).size;
  if (method == "Thanh toán với Momo") {
    return Image.asset(
      ImageConstant.icMomo,
      width: size.height * 0.03,
      height: size.height*0.03,
    );
  } else {
    return const SizedBox();
  }
}
