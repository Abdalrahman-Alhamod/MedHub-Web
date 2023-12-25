import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/app_images.dart';
import '../../model/order.dart';
import '../screens/order_details_screen.dart';
import 'order_spec_text.dart';
import 'order_status_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return GestureDetector(
      onTap: () {
        Get.off(() => const OrderDetailsScreen(), arguments: order.id);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
          ),
          height: 250,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderSpecText(
                    content: 'orderID'.tr,
                    imagePath: AppImages.orderID,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OrderSpecText(
                    content: 'totalBill'.tr,
                    imagePath: AppImages.orderBill,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OrderSpecText(
                    content: 'status'.tr,
                    imagePath: AppImages.orderStatus,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OrderSpecText(
                    content: 'date'.tr,
                    imagePath: AppImages.orderDate,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OrderSpecText(
                    content: 'Pharmacist Name'.tr,
                    imagePath: AppImages.userName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OrderSpecText(
                    content: 'Pharmacy Name'.tr,
                    imagePath: AppImages.pharmacyName,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "#${order.id}",
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 140,
                    child: AutoSizeText(
                      "${order.bill} ${"SP".tr}",
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OrderStatusText(
                    status: order.status,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    order.date,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    order.user!.name,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    order.user!.pharmacyName,
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


