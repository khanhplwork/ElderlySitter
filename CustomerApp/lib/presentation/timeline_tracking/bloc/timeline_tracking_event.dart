import 'package:flutter/Material.dart';

abstract class TimeLineEvent{}

class OtherTimelineEvent extends TimeLineEvent{}


class FetchTimelineEvent extends TimeLineEvent{
  FetchTimelineEvent({required this.context});
  BuildContext context;
}