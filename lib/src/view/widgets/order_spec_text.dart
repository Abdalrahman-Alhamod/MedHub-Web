import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/src/view/widgets/show_image.dart';

class OrderSpecText extends StatelessWidget {
  const OrderSpecText(
      {super.key, required this.content, required this.imagePath});

  final String content;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Row(
      children: [
        ShowImage(
          imagePath: imagePath,
          height: 40,
          width: 40,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          content,
          style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}
