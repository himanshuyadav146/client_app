import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:flutter/material.dart'; // Required for BuildContext

part 'payu_event.dart';
part 'payu_state.dart';

class PayuBloc extends Bloc<PayuEvent, PayuState> implements PayUCheckoutProProtocol {
  late PayUCheckoutProFlutter _checkoutPro;
  // Store context from the widget to be used for navigation or showing snackbars
  BuildContext? _context;


  PayuBloc() : super(PayuInitial()) {
    _checkoutPro = PayUCheckoutProFlutter(this);

    on<PayUProductionPaymentProcess>(_onPayUProductionPaymentProcess);
    on<PayUTestPaymentProcess>(_onPayUTestPaymentProcess);
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void _onPayUProductionPaymentProcess(PayUProductionPaymentProcess event, Emitter<PayuState> emit) async {
    emit(PayuLoading());
    try {
      // TODO: Replace with actual production payment parameters
      var paymentParams = {
        PayUPaymentParamKey.key: "YOUR_PRODUCTION_KEY",
        PayUPaymentParamKey.amount: "1.0",
        PayUPaymentParamKey.productInfo: "Test Product",
        PayUPaymentParamKey.firstName: "Test",
        PayUPaymentParamKey.email: "test@example.com",
        PayUPaymentParamKey.phone: "9999999999",
        PayUPaymentParamKey.ios_surl: "https://payu.herokuapp.com/ios_success",
        PayUPaymentParamKey.ios_furl: "https://payu.herokuapp.com/ios_failure",
        PayUPaymentParamKey.android_surl: "https://payu.herokuapp.com/success",
        PayUPaymentParamKey.android_furl: "https://payu.herokuapp.com/failure",
        PayUPaymentParamKey.environment: "0", // 0 for Production
        PayUPaymentParamKey.transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
        PayUPaymentParamKey.additionalParam: {},
      };
      _checkoutPro.openCheckoutScreen(
        payUPaymentParams: paymentParams,
      );
    } catch (e) {
      emit(PayuFailure(error: e.toString()));
    }
  }

  void _onPayUTestPaymentProcess(PayUTestPaymentProcess event, Emitter<PayuState> emit) async {
    emit(PayuLoading());
    try {
      // TODO: Replace with actual test payment parameters
      var paymentParams = {
        PayUPaymentParamKey.key: "YOUR_TEST_KEY",
        PayUPaymentParamKey.amount: "1.0",
        PayUPaymentParamKey.productInfo: "Test Product",
        PayUPaymentParamKey.firstName: "Test",
        PayUPaymentParamKey.email: "test@example.com",
        PayUPaymentParamKey.phone: "9999999999",
        PayUPaymentParamKey.ios_surl: "https://payu.herokuapp.com/ios_success",
        PayUPaymentParamKey.ios_furl: "https://payu.herokuapp.com/ios_failure",
        PayUPaymentParamKey.android_surl: "https://payu.herokuapp.com/success",
        PayUPaymentParamKey.android_furl: "https://payu.herokuapp.com/failure",
        PayUPaymentParamKey.environment: "1", // 1 for Test
        PayUPaymentParamKey.transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
        PayUPaymentParamKey.additionalParam: {},
      };
      _checkoutPro.openCheckoutScreen(
        payUPaymentParams: paymentParams,
      );
    } catch (e) {
      emit(PayuFailure(error: e.toString()));
    }
  }

  @override
  generateHash(Map response) {
    // TODO: Implement hash generation logic by calling your backend
    // This is a placeholder implementation
    // In a real scenario, you would make an API call to your server
    // to generate the hash using the data in the `response` map.
    // The server would then return the hash, which you pass to the SDK.
    // Example:
    // myBackend.generateHash(response).then((hashResponse) {
    //   _checkoutPro.hashGenerated(hash: hashResponse);
    // }).catchError((error) {
    //   emit(PayuFailure(error: "Hash generation failed: $error"));
    // });

    // Placeholder hash response
    Map hashResponse = {
      PayUHashConstantsKeys.hashName: response[PayUHashConstantsKeys.hashName],
      PayUHashConstantsKeys.hashString: "dummyHash", // Replace with actual hash from backend
    };
    _checkoutPro.hashGenerated(hash: hashResponse);
  }

  @override
  onPaymentSuccess(dynamic response) {
    emit(PayuSuccess(response: response));
    // TODO: Handle navigation or UI updates on success
    // if (_context != null) {
    //   GoRouter.of(_context!).push(RouteName.orderStatus);
    //   ScaffoldMessenger.of(_context!).showSnackBar(
    //     SnackBar(content: Text("Payment Successful: ${response.toString()}")),
    //   );
    // }
  }

  @override
  onPaymentFailure(dynamic response) {
    emit(PayuFailure(error: response));
    // TODO: Handle navigation or UI updates on failure
    // if (_context != null) {
    //   ScaffoldMessenger.of(_context!).showSnackBar(
    //     SnackBar(content: Text("Payment Failed: ${response.toString()}")),
    //   );
    // }
  }

  @override
  onPaymentCancel(Map? response) {
    emit(PayuFailure(error: "Payment Cancelled"));
    // TODO: Handle navigation or UI updates on cancellation
    // if (_context != null) {
    //   ScaffoldMessenger.of(_context!).showSnackBar(
    //     const SnackBar(content: Text("Payment Cancelled by user")),
    //   );
    // }
  }

  @override
  onError(Map? response) {
    emit(PayuFailure(error: response ?? "An unknown error occurred"));
    // TODO: Handle navigation or UI updates on error
    // if (_context != null) {
    //   ScaffoldMessenger.of(_context!).showSnackBar(
    //     SnackBar(content: Text("Error: ${response.toString()}")),
    //   );
    // }
  }
}
