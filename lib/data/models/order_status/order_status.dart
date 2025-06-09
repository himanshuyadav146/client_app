class OrderStatus {
  final String title;
  final DateTime time;
  final bool isCompleted;
  final bool isLast;

  OrderStatus({
    required this.title,
    required this.time,
    this.isCompleted = false,
    this.isLast = false,
  });
}