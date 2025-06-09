import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/order_status/order_status.dart';

class AnimatedStatusItem extends StatelessWidget {
  final OrderStatus status;
  final Animation<double> animation;
  final bool isFirst;
  final bool isLast;
  final int totalItems;
  final int itemIndex;

  const AnimatedStatusItem({
    required this.status,
    required this.animation,
    required this.isFirst,
    required this.isLast,
    required this.totalItems,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (itemIndex + 1) / totalItems;
    final double animatedProgress = Curves.easeInOut.transform(animation.value);
    final bool isActive = animatedProgress >= progress || status.isCompleted;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              if (!isFirst)
                Container(
                  width: 2,
                  height: 20,
                  color: isActive ? Colors.green : Colors.grey[300],
                ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.green : Colors.grey[300],
                ),
                child: isActive
                    ? Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 20,
                  color: isActive ? Colors.green : Colors.grey[300],
                ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.black : Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '📍 ${DateFormat('hh:mm a, d MMM y').format(status.time)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                if (status.isLast)
                  Column(
                    children: [
                      SizedBox(height: 8),
                      Text(
                        'Finish time in 3 min',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}