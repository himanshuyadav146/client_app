import 'package:client_app/core/widgets/core_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart'; // Import Razorpay

import '../../core/constant/app_sizes.dart';
import '../../core/constant/colors.dart';
import '../../core/route/route_name.dart';
import '../../core/widgets/core_button.dart';
import '../../core/widgets/core_scafold.dart';

// Renamed to PaymentPage to avoid potential naming conflicts and to signify it's a page
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear listeners
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Navigate to order status screen on successful payment
    GoRouter.of(context).push(RouteName.orderStatus);
    // You might want to pass response.paymentId or response.orderId to the next screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful: ${response.paymentId}")),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Show a Snackbar with the error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Show a Snackbar for external wallet interaction
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet: ${response.walletName}")),
    );
  }

  void _openRazorpayCheckout() {
    // Replace 'YOUR_RAZORPAY_KEY_ID' with your actual test key ID
    // It's recommended to fetch this from a secure configuration
    var options = {
      'key': 'rzp_test_XXXXXXXXXXXXXX', // IMPORTANT: Replace with your Test Key ID
      'amount': 100, // Amount in paise (e.g., 100 paise = 1 INR)
      'name': 'Test Order',
      'description': 'Payment for services',
      'prefill': {'contact': '9876543210', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error opening payment screen: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'Order Details',
      appBarBackgroundColor: Theme.of(context).primaryColor,
      appBarForegroundColor: Colors.white,
      showBackButton: true,
      isDrawer: false,
      isResizeToAvoidBottomInset: true,
      onBackButtonPressed: () {
        // Check if context is still mounted before using it
        if (mounted) {
          Navigator.of(context).pop();
        }
      },
      body: Padding(
        padding: AppPadding.paddingAllM,
        child: Column(
          children: [
            _buildPersonalDetailsUI(), // Changed to method call
            const SizedBox(height: AppSizes.paddingL),
            _buildPaymentDetailsUI(), // Changed to method call
            const SizedBox(height: AppSizes.paddingM),
            const Spacer(),
            _buildFormSubmit(context), // Remains a method call
          ],
        ),
      ),
    );
  }

  // Moved UI helper methods into the State class
  Widget _buildPersonalDetailsUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: CoreLevel(
            icon: Icons.person,
            textAlign: TextAlign.start,
            text: 'Himanshu Yadav', // Placeholder, consider passing data
            style: TextStyle(
              color: kDarkPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.paddingXXS),
        Align(
          alignment: Alignment.topLeft,
          child: CoreLevel(
            icon: Icons.email,
            textAlign: TextAlign.start,
            text: 'himanshuyadav@example.com', // Placeholder
            style: TextStyle(
              color: kDarkPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.paddingXXS),
        Align(
          alignment: Alignment.topLeft,
          child: CoreLevel(
            icon: Icons.phone,
            textAlign: TextAlign.start,
            text: '9876543210', // Placeholder
            style: TextStyle(
              color: kDarkPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetailsUI() {
    return Padding(
      padding: AppPadding.paddingAllXXS,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: CoreLevel(
              textAlign: TextAlign.start,
              text: 'Payment Summary',
              style: TextStyle(
                color: kDarkPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 400, // Consider making this more dynamic
            child: ListView.builder(
              itemCount: 6, // 5 items + 1 total
              itemBuilder: (context, index) {
                if (index < 5) {
                  // Payment items
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Item ${index + 1}'),
                        Text(
                          '₹${(index + 1) * 100}', // Example amount
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Total row
                  int totalAmount = List.generate(5, (i) => (i + 1) * 100)
                      .reduce((a, b) => a + b);
                  return Container(
                    color: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₹$totalAmount',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFormSubmit(BuildContext context) {
    return SafeArea(
      child: CoreButton(
        text: 'Pay Now',
        onPressed: _openRazorpayCheckout, // Updated onPressed
      ),
    );
  }
}
