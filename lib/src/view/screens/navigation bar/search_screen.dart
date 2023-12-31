import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../Cubits/Category/category_cubit.dart';
import '../../../Cubits/Products/products_cubit.dart';
import '../../../model/product.dart';
import '../../helpers/show_snack_bar.dart';
import '../../widgets/custome_text_field.dart';
import '../../widgets/product_list_tile.dart';
import '../../widgets/show_image.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryCubit>(context).getCategories();
    BlocProvider.of<ProductsCubit>(context).search();
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 8, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _CustomeSearchBar(),
            SizedBox(
              height: 10,
            ),
            _CategoriesCardsView(),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: _ProductCardsView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomeSearchBar extends StatelessWidget {
  const _CustomeSearchBar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: CustomeTextField(
          obscureText: false,
          hintText: "searchFor".tr,
          onChanged: (value) {
            BlocProvider.of<ProductsCubit>(context).searchBarContent = value;
          },
          onSubmit: (value) {
            BlocProvider.of<ProductsCubit>(context).search();
          },
          validator: null,
          keyboardType: TextInputType.text,
          prefixIcon: Icons.search,
          onTap: () {
            BlocProvider.of<ProductsCubit>(context).search();
          },
          isSearchBar: true,
        ),
      ),
    );
  }
}

class _ProductCardsView extends StatelessWidget {
  const _ProductCardsView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsFetchFailure) {
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        } else if (state is ProductNetworkFailure) {
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      builder: (context, state) {
        if (state is ProductsFetchSuccess) {
          var products = state.products;
          return _ProductsSuccessView(products: products);
        } else if (state is ProductsFetchLoading) {
          return SizedBox(
            height: Get.size.height - 350,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          );
        } else if (state is ProductsNotFound) {
          return const ShowImage(
            imagePath: AppImages.noData,
            height: 500,
            width: 500,
          );
        } else if (state is ProductsFetchFailure) {
          return const ShowImage(
            imagePath: AppImages.error,
            height: 500,
            width: 500,
          );
        } else if (state is ProductNetworkFailure) {
          return const ShowImage(
            imagePath: AppImages.error404,
            height: 500,
            width: 500,
          );
        }
        return SizedBox(
          height: Get.size.height - 350,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        );
      },
    );
  }
}

class _ProductsSuccessView extends StatelessWidget {
  const _ProductsSuccessView({
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 550,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3, // Adjust this value based on your design
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductListTile(
            product: products[index],
          );
        },
      ),
    );
  }
}

class _CategoriesCardsView extends StatefulWidget {
  const _CategoriesCardsView();

  @override
  State<_CategoriesCardsView> createState() => _CategoriesCardsViewState();
}

class _CategoriesCardsViewState extends State<_CategoriesCardsView> {
  int selectedIndex = 0;
  @override
  void initState() {
    // if choosen category is set, make it selected to paint it
    selectedIndex = BlocProvider.of<ProductsCubit>(context).choosenCategory.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoriesFetchFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          } else if (state is CategoriesNetworkFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          }
        },
        builder: (context, state) {
          if (state is CategoriesFetchSuccess) {
            var categories = state.categories;
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          selectedIndex = index;
                          BlocProvider.of<ProductsCubit>(context)
                              .choosenCategory = categories[selectedIndex];
                          BlocProvider.of<ProductsCubit>(context).search();
                        },
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: index == selectedIndex
                              ? AppColors.primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Text(
                              categories[index].name,
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: index == selectedIndex
                                    ? Colors.white
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is CategoriesFetchFailure) {
            return const ShowImage(
              imagePath: AppImages.error,
              height: 200,
              width: 200,
            );
          } else if (state is CategoriesNetworkFailure) {
            return const ShowImage(
              imagePath: AppImages.error404,
              height: 200,
              width: 200,
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
