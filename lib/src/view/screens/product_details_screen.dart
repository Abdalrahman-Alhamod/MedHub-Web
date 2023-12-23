import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets/app_vectors.dart';
import '../../../core/constants/app_colors.dart';
import '../../Cubits/Cart/cart_cubit.dart';
import '../../Cubits/Favourite/favourite_cubit.dart';
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
        child: BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartAddLoading) {
              Get.until((route) => !Get.isBottomSheetOpen!);
              showLoadingDialog();
            } else if (state is CartAddSuccess) {
              Get.until((route) => !Get.isDialogOpen!);
              showSnackBar(
                  "addedToCartSuccessfully".tr, SnackBarMessageType.success);
            } else if (state is CartAddFailure) {
              Get.until((route) => !Get.isDialogOpen!);
              showSnackBar(
                  "failedToAddToTheCart".tr, SnackBarMessageType.error);
            }
          },
          child: ListView(
            children: [
              SizedBox(
                height: 280,
                child: Stack(
                  children: [
                    // Container - product background
                    const Positioned.fill(
                      child: _ProductImageBackground(),
                    ),

                    Positioned(
                        top: 15,
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
                      SizedBox(
                          width: 230, child: _ProductName(product: product)),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                          width: 230,
                          child: _ProductScientificName(product: product)),
                    ],
                  ),
                  Expanded(child: _ProductPrice(product: product)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 100, child: _ProductDescription(product: product)),
              const SizedBox(
                height: 10,
              ),
              //// Product Details Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView(
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 100,
                  ),
                  children: [
                    CustomeCard(
                      title: product.brand,
                      subtitle: "brand".tr,
                      icon: const Icon(Icons.business,
                          color: Colors.teal, size: 30), // Example color
                    ),
                    CustomeCard(
                      title: product.expirationDate.toString(),
                      subtitle: "expiration".tr,
                      icon: const Icon(Icons.date_range,
                          color: Colors.red, size: 30), // Example color
                    ),
                    CustomeCard(
                      title: product.inStock == 0
                          ? "unavailable".tr
                          : product.inStock.toString(),
                      subtitle: "inStock".tr,
                      icon: const Icon(Icons.warehouse,
                          color: Colors.green, size: 30),
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
                        size: 30,
                      ), // Example color
                    ),
                  ],
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
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    bool isFav = product.isFavorite;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomeButton(
            title: "addToCart".tr,
            onTap: () {
              Get.bottomSheet(
                _QuantityCounter(
                  product: product,
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
              );
            },
            width: 260,
            height: 70,
            isEnabled: product.inStock != 0,
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor),
            ),
            child: BlocConsumer<FavouriteCubit, FavouriteState>(
              listener: (context, state) {
                if (state is FavourateToggleLoading) {
                  showLoadingDialog();
                } else if (state is FavoureteToggleFailure) {
                  if (Get.isDialogOpen!) Get.back();
                  showSnackBar(state.errorMessage, SnackBarMessageType.error);
                } else if (state is FavourateToggleSuccess) {
                  if (Get.isDialogOpen!) Get.back();
                  isFav = !isFav;
                }
              },
              builder: (context, state) => IconButton(
                onPressed: () {
                  BlocProvider.of<FavouriteCubit>(context)
                      .toggleFavourate(product: product);
                  product.isFavorite = !product.isFavorite;
                },
                icon: Icon(
                  Icons.favorite,
                  color: isFav ? Colors.red : Colors.grey,
                  size: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityCounter extends StatefulWidget {
  const _QuantityCounter({required this.product});
  final Product product;

  @override
  State<_QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<_QuantityCounter> {
  late int _quantity;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) {
      setState(() {
        _quantity = newQuantity;
      });
    }
  }

  @override
  void initState() {
    _quantity = 0;
    super.initState();
  }

  Future<void> _showQuantityDialog() async {
    int? newQuantity;

    await Get.dialog<int>(
      AlertDialog(
        backgroundColor: Colors.white, // Match with scaffold background color
        title: Text(
          "enterQuantity".tr,
          style: Get.theme.textTheme.titleLarge,
        ),
        content: TextField(
          keyboardType: TextInputType.number,
          controller: TextEditingController(text: _quantity.toString()),
          onChanged: (String value) {
            if (int.tryParse(value) != null) {
              newQuantity = int.parse(value);
            }
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.primaryColor.withOpacity(.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
            errorStyle: const TextStyle(color: Colors.red),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: null);
            },
            child: Text(
              "cancel".tr,
              style: Get.theme.textTheme.labelLarge!.copyWith(
                color: Colors.red, // Match with primary color
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: newQuantity);
            },
            child: Text(
              "confirm".tr,
              style: Get.theme.textTheme.labelLarge!.copyWith(
                color: AppColors.primaryColor, // Match with primary color
              ),
            ),
          ),
        ],
      ),
    );

    if (newQuantity != null) {
      quantity = newQuantity!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "quantity".tr,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: _showQuantityDialog,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity--;
                        });
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                      color: theme.primaryColor,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 5,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      quantity.toString(),
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      color: theme.primaryColor,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomeButton(
            title: "add".tr,
            onTap: () {
              if (_quantity > 0) {
                BlocProvider.of<CartCubit>(context)
                    .addToCart(product: widget.product, quantity: _quantity);
              }
            },
            width: double.infinity,
            height: 50.0,
          ),
        ],
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
        style: theme.textTheme.bodyLarge,
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
            fontWeight: FontWeight.bold, color: AppColors.primaryColor),
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
        style: theme.textTheme.displayMedium,
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
        style: theme.textTheme.displaySmall,
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
      width: 250,
      height: 250,
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
        CustomIconButton(
          onPressed: () {
            Get.off(() => const HomeScreen());
          },
          icon: SvgPicture.asset(
            AppVector.backArrowIcon,
            fit: BoxFit.none,
            matchTextDirection: true,
            // ignore: deprecated_member_use
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
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
