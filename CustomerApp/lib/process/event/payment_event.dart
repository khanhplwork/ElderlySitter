
import 'package:flutter/cupertino.dart';

abstract class PaymentEvent{}
class ChoosePaymentMethodPaymentEvent extends PaymentEvent{
  ChoosePaymentMethodPaymentEvent({required this.paymentMethod});
  final String paymentMethod;
}

class ConfirmDepositMoneyIntoWalletPaymentEvent extends PaymentEvent{
  ConfirmDepositMoneyIntoWalletPaymentEvent({required this.context});
  final BuildContext context;
}

class AddTransactionInfoPaymentEvent extends PaymentEvent{
  AddTransactionInfoPaymentEvent({required this.context});
  final BuildContext context;
}

class FillAmountPaymentEvent extends PaymentEvent{
  FillAmountPaymentEvent({required this.amount});
  final int amount;
}

class OtherPaymentEvent extends PaymentEvent{}