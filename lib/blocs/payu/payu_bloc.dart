import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:flutter/material.dart'; // Required for BuildContext

import 'payu_callback_handler.dart'; // Import the new handler

part 'payu_event.dart';
part 'payu_state.dart';

class PayuBloc extends Bloc<PayuEvent, PayuState> {
  late PayUCheckoutProFlutter _checkoutPro;
  late PayUCallbackHandler _callbackHandler;

  BuildContext? _context;

  PayuBloc() : super(PayuInitial()) {
    _callbackHandler = PayUCallbackHandler(this);
    _checkoutPro = PayUCheckoutProFlutter(_callbackHandler);

    on<PayUProductionPaymentProcess>(_onPayUProductionPaymentProcess);
    on<PayUTestPaymentProcess>(_onPayUTestPaymentProcess);
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void _onPayUProductionPaymentProcess(PayUProductionPaymentProcess event, Emitter<PayuState> emit) async {
    emit(PayuLoading());
    try {
      var paymentParams = {
        PayUPaymentParamKey.key: "YOUR_PRODUCTION_KEY", // TODO: Replace with actual key
        PayUPaymentParamKey.amount: event.paymentParams['amount'] ?? "1.0",
        PayUPaymentParamKey.productInfo: event.paymentParams['productInfo'] ?? "Test Product",
        PayUPaymentParamKey.firstName: event.paymentParams['firstName'] ?? "Test",
        PayUPaymentParamKey.email: event.paymentParams['email'] ?? "test@example.com",
        PayUPaymentParamKey.phone: event.paymentParams['phone'] ?? "9999999999",
        PayUPaymentParamKey.ios_surl: "https://payu.herokuapp.com/ios_success",
        PayUPaymentParamKey.ios_furl: "https://payu.herokuapp.com/ios_failure",
        PayUPaymentParamKey.android_surl: "https://payu.herokuapp.com/success",
        PayUPaymentParamKey.android_furl: "https://payu.herokuapp.com/failure",
        PayUPaymentParamKey.environment: "0", // 0 for Production
        PayUPaymentParamKey.transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
        PayUPaymentParamKey.additionalParam: event.paymentParams['additionalParam'] ?? {},
      };
      _checkoutPro.openCheckoutScreen(
        payUPaymentParams: paymentParams,
        payUCheckoutProConfig: {}, // Added missing config as per your latest snippet
      );
    } catch (e) {
      emit(PayuFailure(error: e.toString()));
    }
  }

  void _onPayUTestPaymentProcess(PayUTestPaymentProcess event, Emitter<PayuState> emit) async {
    emit(PayuLoading());
    try {
      var paymentParams = {
        PayUPaymentParamKey.key: "8796453", // TODO: Replace with actual key
        PayUPaymentParamKey.amount: event.paymentParams['amount'] ?? "1.0",
        PayUPaymentParamKey.productInfo: event.paymentParams['productInfo'] ?? "Test Product",
        PayUPaymentParamKey.firstName: event.paymentParams['firstName'] ?? "Test",
        PayUPaymentParamKey.email: event.paymentParams['email'] ?? "test@example.com",
        PayUPaymentParamKey.phone: event.paymentParams['phone'] ?? "9999999999",
        PayUPaymentParamKey.ios_surl: "https://payu.herokuapp.com/ios_success",
        PayUPaymentParamKey.ios_furl: "https://payu.herokuapp.com/ios_failure",
        PayUPaymentParamKey.android_surl: "https://payu.herokuapp.com/success",
        PayUPaymentParamKey.android_furl: "https://payu.herokuapp.com/failure",
        PayUPaymentParamKey.environment: "1", // 1 for Test
        PayUPaymentParamKey.transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
        PayUPaymentParamKey.additionalParam: event.paymentParams['additionalParam'] ?? {},
      };
      _checkoutPro.openCheckoutScreen(
        payUPaymentParams: paymentParams,
        payUCheckoutProConfig: {}, // Added missing config as per your latest snippet
      );
    } catch (e) {
      emit(PayuFailure(error: e.toString()));
    }
  }

  // Method called by PayUCallbackHandler
  void generatePayUHash(Map response) {
    // TODO: Implement hash generation logic by calling your backend
    Map hashResponse = {
      PayUHashConstantsKeys.hashName: response[PayUHashConstantsKeys.hashName],
      PayUHashConstantsKeys.hashString: "dummyHash", // Replace with actual hash from backend
      // Add other hash details if required by the SDK
    };
    _checkoutPro.hashGenerated(hash: hashResponse);
  }

  // Method called by PayUCallbackHandler
  void onPayUPaymentSuccess(dynamic response) {
    emit(PayuSuccess(response: response));
    // if (_context != null) {
    //   GoRouter.of(_context!).push(RouteName.orderStatus);
    //   ScaffoldMessenger.of(_context!).showSnackBar(
    //     SnackBar(content: Text("Payment Successful: ${response.toString()}")),
    //   );
    // }
  }

  // Method called by PayUCallbackHandler
  void onPayUPaymentFailure(dynamic response) {
    emit(PayuFailure(error: response));
    // if (_context != null) {
    //   ScaffoldMessenger.of(_context!).showSnackBar(
    //     SnackBar(content: Text("Payment Failed: ${response.toString()}")),
    //   );
    // }
  }

  // Method called by PayUCallbackHandler
  void onPayUPaymentCancel(Map? response) {
    emit(PayuFailure(error: "Payment Cancelled by user"));
    // if (_context != null) {
    //   ScaffoldMessenger.of(_context!).showSnackBar(
    //     const SnackBar(content: Text("Payment Cancelled by user")),
    //   );
    // }
  }

  // Method called by PayUCallbackHandler
  void onPayUError(Map? response) {
    emit(PayuFailure(error: response ?? {"error": "An unknown PayU error occurred"}));
    // if (_context != null) {
    //   ScaffoldMessenger.of(_context!).showSnackBar(
    //     SnackBar(content: Text("PayU Error: ${response.toString()}")),
    //   );
    // }
  }

  // This method is from BlocBase (for BLoC internal errors)
  // This remains to catch any errors originating from the BLoC itself.
  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(PayuFailure(error: {"error": "BLoC error: ${error.toString()}"}));
    super.onError(error, stackTrace); // Important to call super
  }
}
