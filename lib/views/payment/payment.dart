import 'package:client_app/core/widgets/core_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/app_sizes.dart';
import '../../core/constant/colors.dart';
import '../../core/route/route_name.dart';
import '../../core/widgets/core_button.dart';
import '../../core/widgets/core_scafold.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

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
        Navigator.of(context).pop();
      },
      body: Padding(
        padding: AppPadding.paddingAllM,
        child: Column(
          children: [
            _personalDetailsUI(),
            const SizedBox(height: AppSizes.paddingL),
            _paymentDetailsUI(),
            const SizedBox(height: AppSizes.paddingM),
            Spacer(),
            _buildFormSubmit(context),
          ],
        ),
      ),
    );
  }
}

Widget _personalDetailsUI() {
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
      SizedBox(height: AppSizes.paddingXXS,),
      Align(
        alignment: Alignment.topLeft,
        child: CoreLevel(
          icon: Icons.email,
          textAlign: TextAlign.start,
          text: 'himanshuyadav@gmail.com',
          style: TextStyle(
            color: kDarkPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(height: AppSizes.paddingXXS,),
      Align(
        alignment: Alignment.topLeft,
        child: CoreLevel(
          icon: Icons.phone,
          textAlign: TextAlign.start,
          text: '9415555209',
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

Widget _paymentDetailsUI() {
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
            height: 400,
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
                          '₹${(index + 1) * 100}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Total row
                  int totalAmount = List.generate(5, (i) => (i + 1) * 100).reduce((a, b) => a + b);
                  return Container(
                    color: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        onPressed:() {
          GoRouter.of(context).push(RouteName.orderStatus);
        }
    ),
  );
}
