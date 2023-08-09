import 'package:elscus/core/models/report_models/report_all_model.dart';
import 'package:elscus/core/utils/my_enum.dart';

abstract class ReportState {}

class OtherReportState extends ReportState {}

class ChooseAttitudeContentReportState extends ReportState {
  ChooseAttitudeContentReportState({required this.attitudeType});
  final AttitudeType attitudeType;
}

class ChooseSitterInfoContentReportState extends ReportState {
  ChooseSitterInfoContentReportState({required this.sitterInfoType});
  final SitterInfoType sitterInfoType;
}

class GetAllReportState extends ReportState {
  GetAllReportState({required this.reportList});
  final ReportAllModel reportList;
}
