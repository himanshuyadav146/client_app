import 'package:flutter/material.dart';

import '../../core/constant/app_sizes.dart';
import '../../core/widgets/animated_status_list.dart';
import '../../core/widgets/core_button.dart';
import '../../core/widgets/core_scafold.dart';
import '../../data/models/order_status/order_status.dart';


class OrderStatusScreen extends StatefulWidget {

  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<OrderStatus> statusItems = [
    OrderStatus(
      title: "Order received",
      time: DateTime(2018, 5, 9, 9, 10),
      isCompleted: true,
    ),
    OrderStatus(
      title: "On the way",
      time: DateTime(2018, 5, 9, 9, 15),
      isCompleted: true,
    ),
    OrderStatus(
      title: "Delivered",
      time: DateTime(2018, 5, 9, 9, 18),
      isCompleted: true,
      isLast: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'Order Status',
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
            _buildStatusPage(statusItems,_animation),
            const Spacer(),
            _buildFormSubmit(context), // Remains a method call
          ],
        ),
      ),
    );
  }
}

Widget _buildStatusPage(List<OrderStatus> statusItems, Animation<double> animation){
  return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INVOICE : 12A394',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'TRACKING',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: Expanded(
                  child: AnimatedStatusList(
                    statusItems: statusItems,
                    animation: animation,
                  ),
                ),
              ),
            ],
          ),
      );
}

Widget _buildFormSubmit(BuildContext context) {
  return SafeArea(
    child: CoreButton(
        text: 'Back To Home',
        // onPressed: _openRazorpayCheckout, // Updated onPressed
        onPressed:() {
          //GoRouter.of(context).push(RouteName.orderStatus);
          Navigator.of(context).pop();
        }
    ),
  );
}