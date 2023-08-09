library els_cus_mobile.globlas;

import 'package:elscus/core/models/cus_models/cus_detail_data_model.dart';

String deviceID = "";
String bearerToken = "";
String customerID = "";
CusDetailDataModel? cusDetailModel;
List<String> hashtagStar1 = [
  "Rất tệ",
  "Không thân thiện",
  "Không biết chăm sóc",
  "Thái độ không phù hợp"
];
List<String> hashtagStar2 = [
  "Tệ",
  "Không đúng giờ",
  "Lười biếng",
  "Không hoàn thành công việc"
];
List<String> hashtagStar3 = [
  "Bình thường",
  "Thái độ tốt",
  "Chăm chỉ",
  "Hòa đồng"
];
List<String> hashtagStar4 = [
  "Nhiệt tình",
  "Siêng năng",
  "Hoạt bát",
  "Nhanh nhẹn"
];
List<String> hashtagStar5 = [
  "Trên cả tuyệt vời",
  "Thái độ rất tốt",
  "Làm việc chăm chỉ",
  "Tính tình vui vẻ"
];
const String kUriPrefix = 'https://elderlysitter.page.link';
const String kHomepageLink = '/homeScreen';
const String kWalletLink = '/walletScreen';
