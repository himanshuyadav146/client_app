import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'payu_bloc.dart';

class PayUCallbackHandler implements PayUCheckoutProProtocol {
  final PayuBloc bloc;

  PayUCallbackHandler(this.bloc);

  @override
  void generateHash(Map response) {
    bloc.generatePayUHash(response);
  }

  @override
  void onPaymentSuccess(dynamic response) {
    bloc.onPayUPaymentSuccess(response);
  }

  @override
  void onPaymentFailure(dynamic response) {
    bloc.onPayUPaymentFailure(response);
  }

  @override
  void onPaymentCancel(Map? response) {
    bloc.onPayUPaymentCancel(response);
  }

  @override
  void onError(Map? response) {
    bloc.onPayUError(response);
  }
}
