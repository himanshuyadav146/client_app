part of 'payu_bloc.dart';

abstract class PayuEvent extends Equatable {
  const PayuEvent();

  @override
  List<Object> get props => [];
}

class PayUPaymentProcess extends PayuEvent {
  final Map<String, dynamic> paymentParams;

  const PayUPaymentProcess({required this.paymentParams});

  @override
  List<Object> get props => [paymentParams];
}

class PayUProductionPaymentProcess extends PayuEvent {
  final Map<String, dynamic> paymentParams;

  const PayUProductionPaymentProcess({required this.paymentParams});

  @override
  List<Object> get props => [paymentParams];
}

class PayUTestPaymentProcess extends PayuEvent {
  final Map<String, dynamic> paymentParams;

  const PayUTestPaymentProcess({required this.paymentParams});

  @override
  List<Object> get props => [paymentParams];
}
