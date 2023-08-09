import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/presentation/transaction_history_screen/transaction_history_screen.dart';
import 'package:elscus/presentation/widget/dialog/notice_dialog.dart';
import 'package:elscus/process/bloc/transaction_bloc.dart';
import 'package:elscus/process/bloc/wallet_bloc.dart';
import 'package:elscus/process/event/transaction_event.dart';
import 'package:elscus/process/event/wallet_event.dart';
import 'package:elscus/process/state/transaction_state.dart';
import 'package:elscus/process/state/wallet_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _walletBloc = WalletBloc();
  final transactionBloc = TransactionBloc();
  String walletBalance = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _walletBloc.eventController.sink.add(GetBalanceWalletEvent());
    transactionBloc.eventController.sink.add(GetAllTransactionEvent());
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder<Object>(
        stream: _walletBloc.stateController.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data is GetBalanceWalletState){
              walletBalance = (snapshot.data as GetBalanceWalletState).balance;
            }
          }
          return Material(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottomOpacity: 0,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: size.height * 0.03,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/accountScreen');
                },
              ),
              title: Padding(
                padding: EdgeInsets.only(left: size.width * 0.16),
                child: const Text(
                  "Ví Của Bạn",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: size.width * 0.84,
              height: size.height * 0.055,
              child: ElevatedButton(
                onPressed: () {
                  _walletBloc.eventController.sink.add(ChoosePaymentMethodToDepositMoneyIntoWalletEvent(context: context));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                ),
                child: Text(
                  "Nạp tiền vào ví",
                  style: GoogleFonts.roboto(
                    fontSize: size.width * 0.045,
                  ),
                ),
              ),
            ),
            body: Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width,
                      margin: EdgeInsets.only(
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                        top: size.height * 0.05,
                      ),
                      padding: EdgeInsets.only(
                          left: size.width * 0.03,
                          right: size.width * 0.03,
                          top: size.height * 0.015,
                          bottom: size.height * 0.015),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height * 0.02),
                        color: Colors.white,
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
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số dư trong ví",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.024,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Text(
                                "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(double.parse(walletBalance).ceil())} VNĐ",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.03,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),

                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionHistoryScreen(),));
                      },
                      child: Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: size.height * 0.05,
                        ),
                        padding: EdgeInsets.only(
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                            top: size.height * 0.015,
                            bottom: size.height * 0.015),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size.height * 0.02),
                          color: Colors.white,
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
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lịch sử giao dịch",
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.024,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                StreamBuilder(
                                  stream: transactionBloc.stateController.stream,
                                  builder: (context, snapshot) {
                                    int transactionCount = 0;
                                    if(snapshot.hasData){
                                      if(snapshot.data is GetAllTransactionState){
                                          transactionCount = (snapshot.data as GetAllTransactionState).listTransaction.length;
                                      }
                                    }
                                    return SizedBox(
                                      width: size.width * 0.7,
                                      child: Text(
                                        "$transactionCount giao dịch đã được thực hiện",
                                        maxLines: 2,
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.022,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstant.primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ],
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: size.height * 0.026,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        });
  }
}
