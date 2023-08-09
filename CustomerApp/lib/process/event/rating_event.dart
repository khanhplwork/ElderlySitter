import 'package:flutter/material.dart';

abstract class RatingEvent{}
class OtherRatingEvent extends RatingEvent{}
class ChooseStarRatingEvent extends RatingEvent{
  ChooseStarRatingEvent({required this.ratingStar});
  final double ratingStar;
}
class FillContentRatingEvent extends RatingEvent{
  FillContentRatingEvent({required this.content});
  final String content;
}
class ChooseHashTagRatingEvent extends RatingEvent{
  ChooseHashTagRatingEvent({required this.hashTag});
  final String hashTag;
}

class ConfirmRatingEvent extends RatingEvent{
  ConfirmRatingEvent({required this.context, required this.bookingID});
  final BuildContext context;
  final String bookingID;
}