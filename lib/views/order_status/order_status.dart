import 'package:flutter/material.dart';

import '../../core/widgets/animated_status_list.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
        centerTitle: true,
      ),
      body: Padding(
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
            Expanded(
              child: AnimatedStatusList(
                statusItems: statusItems,
                animation: _animation,
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle delivery confirmation
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Confirm Delivery',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}