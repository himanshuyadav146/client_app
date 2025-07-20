import 'package:client_app/blocs/payu/payu_bloc.dart';
import 'package:client_app/core/widgets/core_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  late PayuBloc _payuBloc;
  bool _isTestMode = true; // Default to test mode

  @override
  void initState() {
    super.initState();
    _payuBloc = PayuBloc();
    _payuBloc.setContext(context); // Pass context to BLoC
  }

  @override
  void dispose() {
    _payuBloc.close();
    super.dispose();
  }

  void _initiatePayUPayment() {
    // These are placeholder parameters.
    // In a real app, you'd fetch these dynamically or from user input/order details.
    // final paymentParams = {
    //   // PayUPaymentParamKey.key will be set in the BLoC based on mode
    //   'amount': "1.0", // Example amount
    //   'productInfo': "Product Info",
    //   'firstName': "FirstName",
    //   'email': "email@example.com",
    //   'phone': "9999999999",
    //   // SURL and FURL will be set in BLoC
    //   // PayUPaymentParamKey.environment will be set in BLoC
    //   // PayUPaymentParamKey.transactionId will be generated in BLoC
    //   'additionalParam': {
    //     // PayUAdditionalParamKeys.udf1: "udf1",
    //     // ... other UDFs or additional params
    //   },
    // };

    final paymentParams = {
      'amount': '10.0', // example amount
      'productInfo': 'Test Product',
      'firstName': 'John',
      'email': 'john@example.com',
      'phone': '9876543210',
      "userToken" : "83746sjhkdgfsjdgf874673465",
    };

    if (_isTestMode) {
      _payuBloc.add(PayUTestPaymentProcess(paymentParams: paymentParams));
    } else {
      _payuBloc.add(PayUProductionPaymentProcess(paymentParams: paymentParams));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _payuBloc,
      child: CoreScaffold(
        title: 'Order Details',
        appBarBackgroundColor: Theme.of(context).primaryColor,
        appBarForegroundColor: Colors.white,
        showBackButton: true,
        isDrawer: false,
        isResizeToAvoidBottomInset: true,
        onBackButtonPressed: () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        },
        body: BlocListener<PayuBloc, PayuState>(
          listener: (context, state) {
            if (state is PayuSuccess) {
              GoRouter.of(context).push(RouteName.orderStatus);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        "Payment Successful: ${state.response.toString()}")),
              );
            } else if (state is PayuFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Payment Failed: ${state.error.toString()}")),
              );
            }
          },
          child: Padding(
            padding: AppPadding.paddingAllM,
            child: Column(
              children: [
                _buildPersonalDetailsUI(),
                const SizedBox(height: AppSizes.paddingL),
                _buildPaymentDetailsUI(),
                const SizedBox(height: AppSizes.paddingM),
                _buildModeToggle(), // Added mode toggle
                const Spacer(),
                _buildFormSubmit(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Test Mode'),
        Switch(
          value: !_isTestMode, // True for Production, False for Test
          onChanged: (value) {
            setState(() {
              _isTestMode = !value;
            });
          },
        ),
        const Text('Production Mode'),
      ],
    );
  }

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
            text: 'himanshuyadav@example.com',
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
            text: '9876543210',
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
            height: 350, // Adjusted height to accommodate toggle switch
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                if (index < 5) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Item ${index + 1}'),
                        Text(
                          '₹${(index + 1) * 100}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                } else {
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
      child: BlocBuilder<PayuBloc, PayuState>(
        builder: (context, state) {
          if (state is PayuLoading) {
            return const CircularProgressIndicator();
          }
          return CoreButton(
            text: 'Pay Now',
            onPressed: _initiatePayUPayment,
          );
        },
      ),
    );
  }
}
