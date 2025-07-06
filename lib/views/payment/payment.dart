import 'package:client_app/core/widgets/core_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart'; // Import Razorpay

import '../../core/constant/app_sizes.dart';
import '../../core/constant/colors.dart';
import '../../core/route/route_name.dart';
import '../../core/widgets/core_button.dart';
import '../../core/widgets/core_scafold.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            text: 'Himanshu Yadav',
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
        onPressed: (){},
      ),
    );
  }
}
