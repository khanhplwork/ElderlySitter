import 'package:elscus/presentation/promotion_screen/widgets/promotion_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/models/promotion_models/promotion_data_model.dart';

// ignore: must_be_immutable
class PromotionScreen extends StatefulWidget {
  PromotionScreen({Key? key, required this.listPromo}) : super(key: key);
  List<PromotionDataModel> listPromo;
  @override
  // ignore: no_logic_in_create_state
  State<PromotionScreen> createState() => _PromotionScreenState(listPromo: listPromo);
}

class _PromotionScreenState extends State<PromotionScreen> {
  _PromotionScreenState({required this.listPromo});
  List<PromotionDataModel> listPromo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
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
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.16),
          child: const Text(
            "Ưu đãi hiện có",
          ),
        ),
        titleTextStyle: GoogleFonts.roboto(
          fontSize: size.height * 0.024,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      body: Material(
        color: Colors.white,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                ListView.separated(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return promotionItem(context, listPromo[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: size.height * 0.02,
                    ),
                    itemCount: listPromo.length),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
