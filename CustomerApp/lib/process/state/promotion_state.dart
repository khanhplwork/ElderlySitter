import '../../core/models/promotion_models/promotion_data_model.dart';

abstract class PromotionState{}
class OtherPromotionState extends PromotionState{}
class GetAllPromotionState extends PromotionState{
  GetAllPromotionState({required this.listPromo});
  final List<PromotionDataModel> listPromo;
}