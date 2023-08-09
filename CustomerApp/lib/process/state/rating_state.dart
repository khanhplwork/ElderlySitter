abstract class RatingState{}
class OtherRatingState extends RatingState{}
class ChooseHashTagRatingState extends RatingState{
  ChooseHashTagRatingState({required this.listChoosedHashTag});
  final List<String> listChoosedHashTag;
}