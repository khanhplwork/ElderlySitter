import 'package:elscus/presentation/elder_screen/widget/elder_detail.dart';
import 'package:elscus/presentation/elder_screen/widget/elder_item.dart';
import 'package:elscus/presentation/loading_screen/loading_screen.dart';
import 'package:elscus/presentation/widget/booking/booking_empty.dart';
import 'package:elscus/process/event/elder_event.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_constant.dart';
import '../../process/bloc/elder_bloc.dart';
import '../../process/state/elder_state.dart';

class ElderScreen extends StatefulWidget {
  const ElderScreen({Key? key}) : super(key: key);

  @override
  State<ElderScreen> createState() => _ElderScreenState();
}

class _ElderScreenState extends State<ElderScreen> {
  final _elderBloc = ElderBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _elderBloc.eventController.sink.add(GetAllElderEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<ElderState>(
      stream: _elderBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
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
                padding: EdgeInsets.only(left: size.width * 0.08),
                child: const Text(
                  "Quản Lý Thân Nhân",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addNewElderScreen');
              },
              elevation: 0.0,
              backgroundColor: ColorConstant.primaryColor,
              child: const Icon(Icons.add),
            ),
            body: Material(
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ((snapshot.data as GetAllElderState)
                              .elderList
                              .data
                              .isEmpty)
                          ? const SizedBox()
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(
                                left: size.width * 0.05,
                                right: size.width * 0.05,
                                top: size.height * 0.03,
                              ),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ElderDetailScreen(
                                            elderID: (snapshot.data
                                                    as GetAllElderState)
                                                .elderList
                                                .data[index]
                                                .id),
                                      ));
                                },
                                child: elderItem(
                                    context,
                                    (snapshot.data as GetAllElderState)
                                        .elderList
                                        .data[index]),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount: (snapshot.data as GetAllElderState)
                                  .elderList
                                  .data
                                  .length,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return bookingEmptyWidget(context, "Chưa có dữ liệu");
        }
      },
    );
  }
}
