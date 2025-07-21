import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'payu_bloc.dart';

class PayUCallbackHandler implements PayUCheckoutProProtocol {
  final PayuBloc bloc;

  PayUCallbackHandler(this.bloc);

  @override
  void generateHash(Map response) {
    print("PayU Callback: generateHash called with: $response");
    bloc.generatePayUHash(response);
  }

  @override
  void onPaymentSuccess(dynamic response) {
    print("PayU Callback: onPaymentSuccess called with: $response");
    bloc.onPayUPaymentSuccess(response);
  }

  @override
  void onPaymentFailure(dynamic response) {
    print("PayU Callback: onPaymentFailure called with: $response");
    bloc.onPayUPaymentFailure(response);
  }

  @override
  void onPaymentCancel(Map? response) {
    print("PayU Callback: onPaymentCancel called with: $response");
    bloc.onPayUPaymentCancel(response);
  }

  @override
  void onError(Map? response) {
    print("PayU Callback: onError called with: $response");
    bloc.onPayUError(response);
  }
}
