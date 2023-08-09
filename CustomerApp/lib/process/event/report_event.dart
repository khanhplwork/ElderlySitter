import 'package:elscus/core/utils/my_enum.dart';
import 'package:flutter/Material.dart';

abstract class ReportEvent {}

class OtherReportEvent extends ReportEvent {}

class ChooseTitleReportEvent extends ReportEvent {
  ChooseTitleReportEvent({required this.title});
  final String title;
}

class ChooseAttitudeContentReportEvent extends ReportEvent {
  ChooseAttitudeContentReportEvent(
      {required this.content, required this.attitudeType});
  final String content;
  final AttitudeType attitudeType;
}

class ChooseSitterInfoContentReportEvent extends ReportEvent {
  ChooseSitterInfoContentReportEvent(
      {required this.content, required this.sitterInfoType});
  final String content;
  final SitterInfoType sitterInfoType;
}

class FillContentReportEvent extends ReportEvent {
  FillContentReportEvent({required this.content});
  final String content;
}

class ConfirmReportEvent extends ReportEvent {
  ConfirmReportEvent(
      {required this.context,
      required this.bookingDetailID,
      required this.sitterID});
  final BuildContext context;
  final String bookingDetailID;
  final String sitterID;
}

class GetAllReportEvent extends ReportEvent {
  GetAllReportEvent();
}
