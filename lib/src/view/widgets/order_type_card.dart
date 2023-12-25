import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'show_image.dart';

class OrderTypeCard extends StatelessWidget {
  const OrderTypeCard({
    super.key,
    required this.isSelected,
    required this.color,
    required this.image,
    required this.title,
    required this.onTap,
  });
  final bool isSelected;
  final Color color;
  final String image;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: Get.locale.toString() == 'en'
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                  border: Border.all(color: color),
                ),
                child: ShowImage(imagePath: image, height: 100, width: 100),
              ),
              Container(
                decoration: BoxDecoration(
                  color: isSelected ? color : Colors.white,
                  borderRadius: Get.locale.toString() == 'en'
                      ? const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                  border: Border.all(color: color),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: isSelected ? Colors.white : color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
