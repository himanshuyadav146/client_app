import 'package:flutter/material.dart';
import '../../data/models/order_status/order_status.dart';
import 'animated_status_item.dart';

class AnimatedStatusList extends StatelessWidget {
  final List<OrderStatus> statusItems;
  final Animation<double> animation;

  const AnimatedStatusList({
    required this.statusItems,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: statusItems.length,
      itemBuilder: (context, index) {
        final status = statusItems[index];
        return AnimatedStatusItem(
          status: status,
          animation: animation,
          isFirst: index == 0,
          isLast: index == statusItems.length - 1,
          totalItems: statusItems.length,
          itemIndex: index,
        );
      },
    );
  }
}