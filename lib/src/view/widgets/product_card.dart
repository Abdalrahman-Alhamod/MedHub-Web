import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/product.dart';
import '../screens/details/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return GestureDetector(
      onTap: () {
        Get.off(() => ProductDetailsScreen(), arguments: product);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                color: Colors.grey.shade300,
                image: DecorationImage(
                  image: NetworkImage(
                    product.image,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              height: 100,
              width: 230,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                color: theme.primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: AutoSizeText(
                          product.name,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: AutoSizeText(
                          product.scientificName,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    flex: 1,
                    child: AutoSizeText(
                      "${product.price.toString()} ${"SP".tr}",
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: const Color.fromARGB(255, 181, 255, 183)),
                      minFontSize: 8,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
