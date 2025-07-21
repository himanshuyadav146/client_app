import 'package:bloc/bloc.dart';
import 'package:client_app/blocs/payu/payu_callback_handler.dart';
import 'package:equatable/equatable.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:async';

part 'payu_event.dart';
part 'payu_state.dart';

class PayuBloc extends Bloc<PayuEvent, PayuState> {
  late PayUCheckoutProFlutter _checkoutPro;
  late PayUCallbackHandler _callbackHandler;
  BuildContext? _context;

  // Test credentials
  final String testMerchantKey = '8796453';
  final String testMerchantSalt = '6leDdSgxIBUd5dI0gM2HZPHwtA49OSsW'; // Updated salt from dashboard

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

      print("PayU Test Mode - Merchant Key: $testMerchantKey, Salt: $testMerchantSalt");

      var paymentParams = {
        PayUPaymentParamKey.key: "13140558", // Use production merchant key
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
        PayUPaymentParamKey.additionalParam: {
          'udf1': event.paymentParams['userToken'] ?? '',
        },
      };

      print("PayU Payment Params: $paymentParams");

      // Add a timeout to prevent infinite loading
      Timer(const Duration(seconds: 30), () {
        if (!emit.isDone && state is PayuLoading) {
          print("PayU Timeout - No response received");
          emit(PayuFailure(error: "Payment timeout - no response from PayU"));
        }
      });

      // Try with minimal configuration
      _checkoutPro.openCheckoutScreen(
        payUPaymentParams: paymentParams,
        payUCheckoutProConfig: {
          'merchantName': 'Tax Plus',
        },
      );
    } catch (e) {
      print("PayU Error: $e");
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

      print("PayU Hash Request - Name: $hashName, Response: $response");

      // Extract only the JSON part from the hashString
      final rawHashString = response[PayUHashConstantsKeys.hashString];
      print("Raw Hash String: $rawHashString");

      // Handle different hash types
      if (hashName == "get_sdk_configuration") {
        // For SDK configuration hash
        hashString = _generateSDKConfigHash();
      } else if (hashName == "get_checkout_details") {
        // For checkout details hash - extract JSON from pipe-separated string
        final parts = rawHashString.split('|');
        if (parts.length >= 3) {
          final jsonPart = parts[2]; // The JSON part is at index 2
          final Map<String, dynamic> data = jsonDecode(jsonPart);
          hashString = _generateCheckoutDetailsHash(data);
        }
      } else if (hashName == "quickPayEvent") {
        // For payment hash - extract JSON from pipe-separated string
        final parts = rawHashString.split('|');
        if (parts.length >= 1) {
          final jsonPart = parts[0]; // The JSON part is at index 0
          final Map<String, dynamic> data = jsonDecode(jsonPart);
          hashString = _generatePaymentHash(
            key: testMerchantKey,
            txnId: data['requestId'] ?? '',
            amount: data['amount']?.toString() ?? '1.0',
            productInfo: data['requestType'] ?? 'Test Product',
            firstName: data['userToken'] ?? 'Test',
            email: data['phone'] ?? 'test@example.com',
          );
        }
      } else if (hashName == "vasForMobileSDKHash") {
        // For VAS hash - extract JSON from pipe-separated string
        final parts = rawHashString.split('|');
        if (parts.length >= 1) {
          final jsonPart = parts[0]; // The JSON part is at index 0
          final Map<String, dynamic> data = jsonDecode(jsonPart);
          hashString = _generateVasHash(
            key: testMerchantKey,
            txnId: data['requestId'] ?? '',
          );
        }
      } else if (hashName == "get_all_offer_details") {
        // For offer details hash - extract JSON from pipe-separated string
        final parts = rawHashString.split('|');
        if (parts.length >= 1) {
          final jsonPart = parts[0]; // The JSON part is at index 0
          final Map<String, dynamic> data = jsonDecode(jsonPart);
          hashString = _generateOfferDetailsHash(data);
        }
      }

      print("Generated Hash: $hashString");

      if (hashString.isEmpty) {
        print("Warning: Generated hash is empty for $hashName");
        // Generate a fallback hash to prevent crashes
        hashString = _generateFallbackHash(hashName);
      }

      Map hashResponse = {
        PayUHashConstantsKeys.hashName: hashName,
        PayUHashConstantsKeys.hashString: hashString,
      };

      print("Sending hash response: $hashResponse");
      _checkoutPro.hashGenerated(hash: hashResponse);
    } catch (e) {
      print("Hash Generation Error: $e");
      // Generate a fallback hash to prevent crashes
      final fallbackHash = _generateFallbackHash(response[PayUHashConstantsKeys.hashName]);
      Map hashResponse = {
        PayUHashConstantsKeys.hashName: response[PayUHashConstantsKeys.hashName],
        PayUHashConstantsKeys.hashString: fallbackHash,
      };
      print("Sending fallback hash response: $hashResponse");
      _checkoutPro.hashGenerated(hash: hashResponse);
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
    // For quickPayEvent, use a simpler hash format
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

    print("Payment Hash Data: $hashData");
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

  String _generateSDKConfigHash() {
    final hashData = [
      testMerchantKey,
      'get_sdk_configuration',
      'GET',
      testMerchantSalt,
    ].join('|');

    return _generateSHA512(hashData);
  }

  String _generateCheckoutDetailsHash(Map<String, dynamic> data) {
    final hashData = [
      testMerchantKey,
      'get_checkout_details',
      jsonEncode(data),
      testMerchantSalt,
    ].join('|');

    return _generateSHA512(hashData);
  }

  String _generateOfferDetailsHash(Map<String, dynamic> data) {
    final hashData = [
      testMerchantKey,
      'get_all_offer_details',
      jsonEncode(data),
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

  // Fallback hash generation method
  String _generateFallbackHash(String hashName) {
    final hashData = [
      testMerchantKey,
      hashName,
      DateTime.now().millisecondsSinceEpoch.toString(),
      testMerchantSalt,
    ].join('|');

    return _generateSHA512(hashData);
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