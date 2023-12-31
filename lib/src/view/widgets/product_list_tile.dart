import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../model/product.dart';
import '../screens/details/product_details_screen.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product, this.quantity = 0});
  final Product product;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;

    return GestureDetector(
      onTap: () {
        if (quantity == 0) {
          Get.off(() => ProductDetailsScreen(), arguments: product);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 130,
                      child: AutoSizeText(
                        product.name,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                        minFontSize: 8,
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: AutoSizeText(
                        product.scientificName,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                        minFontSize: 8,
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: AutoSizeText(
                        product.brand,
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: Colors.grey.shade600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                        minFontSize: 8,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      quantity != 0
                          ? Column(
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '$quantity ${"pc".tr}',
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.primaryColor,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: 130,
                        child: AutoSizeText(
                          "${product.price.toString()} ${"SP".tr}",
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: const Color.fromARGB(255, 23, 171, 28),
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          minFontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
            //visualDensity: VisualDensity(vertical: 5),
            ),
      ),
    );
  }
}
