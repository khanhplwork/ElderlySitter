abstract class ConfirmPayState {}

class OtherConfirmPayState extends ConfirmPayState{}
class LoadingConfirmPayState extends ConfirmPayState{}
class ErrorConfirmPayState extends ConfirmPayState{
  ErrorConfirmPayState({required this.message});
  String message;
}
class SuccessConfirmPayState extends ConfirmPayState{
}

