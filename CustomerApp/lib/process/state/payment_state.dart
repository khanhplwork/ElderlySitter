abstract class PaymentState{}
class FillAmountPaymentState extends PaymentState{
  FillAmountPaymentState({required this.amount});
  final int amount;
}
class OtherPaymentState extends PaymentState{}