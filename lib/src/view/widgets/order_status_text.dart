import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/order.dart';

class OrderStatusText extends StatelessWidget {
  const OrderStatusText({super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    Color color = Colors.black;
    OrderStatus orderStatus = OrderStatus();
    if (status == orderStatus.Preparing) {
      color = Colors.orange;
    } else if (status == orderStatus.Delivering) {
      color = Colors.blueGrey;
    } else if (status == orderStatus.Recieved) {
      color = Colors.green;
    } else if (status == orderStatus.Refused) {
      color = Colors.red;
    }
    return Text(
      status,
      style: theme.textTheme.titleLarge!.copyWith(color: color),
    );
  }
}
