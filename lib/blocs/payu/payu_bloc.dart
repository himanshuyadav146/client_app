import 'package:bloc/bloc.dart';
import 'package:client_app/blocs/payu/payu_callback_handler.dart';
import 'package:equatable/equatable.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

part 'payu_event.dart';
part 'payu_state.dart';

class PayuBloc extends Bloc<PayuEvent, PayuState> {
  late PayUCheckoutProFlutter _checkoutPro;
  late PayUCallbackHandler _callbackHandler;
  BuildContext? _context;

  // Test credentials
  final String testMerchantKey = '8796453';
  final String testMerchantSalt = '6leDdSgxlBUd5dI0gM2HZPHwtA49OSsW'; // Common test salt

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
        payUCheckoutProConfig: {
          'merchantName': 'Your Merchant Name',
          'merchantLogo': 'https://example.com/logo.png',
        },
      );
    } catch (e) {
      emit(PayuFailure(error: e.toString()));
    }
  }

  void _onPayUTestPaymentProcess(PayUTestPaymentProcess event, Emitter<PayuState> emit) async {
    emit(PayuLoading());
    try {
      final txnId = DateTime.now().millisecondsSinceEpoch.toString();
      final amount = event.paymentParams['amount'] ?? "1.0";

      var paymentParams = {
        PayUPaymentParamKey.key: testMerchantKey,
        PayUPaymentParamKey.amount: amount,
        PayUPaymentParamKey.productInfo: event.paymentParams['productInfo'] ?? "Test Product",
        PayUPaymentParamKey.firstName: event.paymentParams['firstName'] ?? "Test",
        PayUPaymentParamKey.email: event.paymentParams['email'] ?? "test@example.com",
        PayUPaymentParamKey.phone: event.paymentParams['phone'] ?? "9999999999",
        PayUPaymentParamKey.ios_surl: "https://payu.herokuapp.com/ios_success",
        PayUPaymentParamKey.ios_furl: "https://payu.herokuapp.com/ios_failure",
        PayUPaymentParamKey.android_surl: "https://payu.herokuapp.com/success",
        PayUPaymentParamKey.android_furl: "https://payu.herokuapp.com/failure",
        PayUPaymentParamKey.environment: "1", // 1 for Test
        PayUPaymentParamKey.transactionId: txnId,
        PayUPaymentParamKey.additionalParam: event.paymentParams['additionalParam'] ?? {},
      };

      _checkoutPro.openCheckoutScreen(
        payUPaymentParams: paymentParams,
        payUCheckoutProConfig: {
          'merchantName': 'Tax Plus',
          'showExitConfirmationOnCheckoutScreen': true,
          'showExitConfirmationOnPaymentScreen': true,
        },
      );
    } catch (e) {
      emit(PayuFailure(error: e.toString()));
      if (_context != null && _context!.mounted) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(content: Text("Payment Error: ${e.toString()}")),
        );
      }
    }
  }

  void generatePayUHash(Map response) {
    try {
      final hashName = response[PayUHashConstantsKeys.hashName];
      String hashString = "";

      // Extract only the JSON part from the hashString
      final rawHashString = response[PayUHashConstantsKeys.hashString];

      // Assuming it's something like: <json>|<timestamp>|
      final parts = rawHashString.split('|');
      final jsonPart = parts[0]; // The first part is the JSON string

      final Map<String, dynamic> data = jsonDecode(jsonPart);

      if (hashName == "quickPayEvent") {
        hashString = _generatePaymentHash(
          key: testMerchantKey,
          txnId: data['requestId'],         // Assuming this is the txnId
          amount: data['amount'].toString(),// Ensure it's String
          productInfo: data['requestType'], // You can adjust this
          firstName: data['userToken'],     // Replace with actual field if needed
          email: data['phone'],             // Replace with actual email if present
        );
      } else if (hashName == "vasForMobileSDKHash") {
        hashString = _generateVasHash(
          key: testMerchantKey,
          txnId: data['requestId'],         // Assuming this is the txnId
        );
      }

      Map hashResponse = {
        PayUHashConstantsKeys.hashName: hashName,
        PayUHashConstantsKeys.hashString: hashString,
      };

      _checkoutPro.hashGenerated(hash: hashResponse);
    } catch (e) {
      emit(PayuFailure(error: "Hash generation failed: ${e.toString()}"));
    }
  }


// Updated hash generation methods to handle the new format
  String _generatePaymentHash({
    required String key,
    required String txnId,
    required String amount,
    required String productInfo,
    required String firstName,
    required String email,
  }) {
    final hashData = [
      key,
      txnId,
      amount,
      productInfo,
      firstName,
      email,
      '', // udf1
      '', // udf2
      '', // udf3
      '', // udf4
      '', // udf5
      '', '', '', '', '', // Empty fields
      testMerchantSalt,
    ].join('|');

    return _generateSHA512(hashData);
  }

  String _generateVasHash({
    required String key,
    required String txnId,
  }) {
    final hashData = [
      key,
      txnId,
      testMerchantSalt,
    ].join('|');

    return _generateSHA512(hashData);
  }

  // Helper method to generate SHA512 hash
  String _generateSHA512(String input) {
    final bytes = utf8.encode(input);
    final digest = sha512.convert(bytes);
    return digest.toString();
  }

  // Method called by PayUCallbackHandler
  void onPayUPaymentSuccess(dynamic response) {
    emit(PayuSuccess(response: response));
    if (_context != null && _context!.mounted) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text("Payment Successful: ${response.toString()}")),
      );
    }
  }

  // Method called by PayUCallbackHandler
  void onPayUPaymentFailure(dynamic response) {
    emit(PayuFailure(error: response.toString()));
    if (_context != null && _context!.mounted) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text("Payment Failed: ${response.toString()}")),
      );
    }
  }

  // Method called by PayUCallbackHandler
  void onPayUPaymentCancel(Map? response) {
    emit(PayuFailure(error: "Payment Cancelled by user"));
    if (_context != null && _context!.mounted) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(content: Text("Payment Cancelled by user")),
      );
    }
  }

  // Method called by PayUCallbackHandler
  void onPayUError(Map? response) {
    emit(PayuFailure(error: response ?? {"error": "An unknown PayU error occurred"}));
    if (_context != null && _context!.mounted) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text("PayU Error: ${response.toString()}")),
      );
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(PayuFailure(error: {"error": "BLoC error: ${error.toString()}"}));
    super.onError(error, stackTrace);
  }
}