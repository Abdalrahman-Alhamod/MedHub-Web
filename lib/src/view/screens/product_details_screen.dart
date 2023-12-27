import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/src/Cubits/Products/products_cubit.dart';
import 'package:pharmacy_warehouse_store_web/src/view/helpers/show_custome_dialog.dart';
import 'package:pharmacy_warehouse_store_web/src/view/screens/edit_product_details_screen.dart';

import '../../../core/assets/app_vectors.dart';
import '../../../core/constants/app_colors.dart';
import '../../model/product.dart';
import '../helpers/show_loading_dialog.dart';
import '../helpers/show_snack_bar.dart';
import '../widgets/custome_button.dart';
import '../widgets/custome_card.dart';
import '../widgets/custome_icon_button.dart';
import 'navigation bar/home_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});
  final Product product = Get.arguments;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 380,
              child: Stack(
                children: [
                  // Container - product background
                  const Positioned.fill(
                    child: _ProductImageBackground(),
                  ),

                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: _ProductImage(
                        product: product,
                      )),
                  // Back button
                  const Positioned(
                    top: 24,
                    left: 24,
                    right: 24,
                    child: _AppBar(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(width: 430, child: _ProductName(product: product)),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 430,
                        child: _ProductScientificName(product: product)),
                  ],
                ),
                Expanded(child: _ProductPrice(product: product)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(height: 100, child: _ProductDescription(product: product)),
            const SizedBox(
              height: 10,
            ),
            //// Product Details Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AspectRatio(
                aspectRatio: 10,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 550,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3,
                  ),
                  children: [
                    CustomeCard(
                      title: product.brand,
                      subtitle: "brand".tr,
                      icon: const Icon(
                        Icons.business,
                        color: Colors.teal,
                        size: 50,
                      ), // Example color
                    ),
                    CustomeCard(
                      title: product.expirationDate.toString(),
                      subtitle: "expiration".tr,
                      icon: const Icon(
                        Icons.date_range,
                        color: Colors.red,
                        size: 50,
                      ), // Example color
                    ),
                    CustomeCard(
                      title: product.inStock == 0
                          ? "unavailable".tr
                          : product.inStock.toString(),
                      subtitle: "inStock".tr,
                      icon: const Icon(
                        Icons.warehouse,
                        color: Colors.green,
                        size: 50,
                      ),
                      titleColor: product.inStock == 0
                          ? Colors.red
                          : AppColors.primaryColor, // Example color
                    ),
                    CustomeCard(
                      title: product.category.name,
                      subtitle: "category".tr,
                      icon: const Icon(
                        Icons.category,
                        color: Colors.orange,
                        size: 50,
                      ), // Example color
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _Buttons(
              product: product,
            )
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 80,
        width: 600,
        child: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              BlocListener<ProductsCubit, ProductsState>(
                listener: (context, state) {
                  if (state is ProductDeleteLoading) {
                    showLoadingDialog();
                  } else if (state is ProductDeleteSuccess) {
                    Get.until((route) => !Get.isDialogOpen!);
                    showSnackBar("Product Deleted Successfully !".tr,
                        SnackBarMessageType.success);
                    Get.off(() => const HomeScreen());
                  } else if (state is ProductDeleteNetworkFailure) {
                    Get.until((route) => !Get.isDialogOpen!);
                    showSnackBar(state.errorMessage, SnackBarMessageType.error);
                  } else if (state is ProductDeleteFailure) {
                    Get.until((route) => !Get.isDialogOpen!);
                    showSnackBar(state.errorMessage, SnackBarMessageType.error);
                  }
                },
                child: CustomeButton(
                  title: "Delete".tr,
                  onTap: () {
                    showCustomeDialog(
                        title: "Delete Product".tr,
                        content:
                            "${"Are you sure you want to delete the product with id ".tr}#${product.id} ${"?".tr}",
                        onConfirm: () {
                          BlocProvider.of<ProductsCubit>(context)
                              .deleteProduct(productId: product.id);
                        });
                  },
                  width: 260,
                  height: 70,
                  backgroundColor: Colors.red,
                  icon: const Icon(
                    Icons.delete,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              CustomeButton(
                title: "Edit Information".tr,
                onTap: () {
                  Get.off(
                    () => EditProductDetailsScreen(
                      productID: product.id,
                    ),
                  );
                },
                width: 260,
                height: 70,
                icon: const Icon(
                  Icons.edit_note_sharp,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AutoSizeText(
        product.description,
        style: theme.textTheme.bodyLarge!.copyWith(fontSize: 24),
        maxLines: 4,
      ),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  const _ProductPrice({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25, top: 20),
      child: AutoSizeText(
        "${product.price} ${"SP".tr}",
        style: theme.textTheme.displayLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
          fontSize: 32,
        ),
        maxLines: 1,
      ),
    );
  }
}

class _ProductScientificName extends StatelessWidget {
  const _ProductScientificName({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AutoSizeText(
        product.scientificName,
        style: theme.textTheme.displayMedium!.copyWith(fontSize: 28),
        maxLines: 1,
      ),
    );
  }
}

class _ProductName extends StatelessWidget {
  const _ProductName({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AutoSizeText(
        product.name,
        style: theme.textTheme.displaySmall!.copyWith(fontSize: 32),
        maxLines: 1,
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      product.image,
      width: 350,
      height: 350,
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 65,
          width: 65,
          child: CustomIconButton(
            onPressed: () {
              Get.off(() => const HomeScreen());
            },
            icon: SvgPicture.asset(
              AppVector.backArrowIcon,
              fit: BoxFit.none,
              matchTextDirection: true,
              // ignore: deprecated_member_use
              color: Colors.white,
              width: 65,
              height: 65,
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

class _ProductImageBackground extends StatelessWidget {
  const _ProductImageBackground();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppVector.container,
      fit: BoxFit.fill,
      // ignore: deprecated_member_use
      color: Colors.grey.shade300,
    );
  }
}
