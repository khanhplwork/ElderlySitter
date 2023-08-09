import 'dart:async';

import 'package:elscus/presentation/timeline_tracking/api/timeline_tracking_api.dart';
import 'package:elscus/presentation/timeline_tracking/bloc/timeline_tracking_event.dart';
import 'package:elscus/presentation/timeline_tracking/bloc/timeline_tracking_state.dart';
import 'package:elscus/presentation/timeline_tracking/model/timeline_model.dart';
import 'package:elscus/presentation/widget/dialog/fail_dialog.dart';
import 'package:flutter/Material.dart';

class TimelineBloc {
  final eventController = StreamController<TimeLineEvent>();
  final stateController = StreamController<TimeLineState>();
  String idBooking = "";
  String errorMessage = "";
  List<TimelineModel> listTimeLine = [];
  Map<String,TimelineModel> mapdata={}; 
  TimelineBloc() {
    eventController.stream.listen((event) async {
      if (event is OtherTimelineEvent) {
        stateController.sink.add(OtherTimelineState());
      }
      if (event is FetchTimelineEvent) {
        try {
          mapdata = await TimelineTrackingApi.fetchDataTimeLine(idBooking);
          print(mapdata);
        } catch (e) {
          Navigator.pop(event.context);
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
           stateController.sink.add(OtherTimelineState());
      }
    });
  }
}
