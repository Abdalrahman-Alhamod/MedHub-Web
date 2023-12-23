import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_web/src/view/widgets/show_image.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../Cubits/Auth/Logout/logout_cubit.dart';
import '../../../Cubits/BottomNavBar/bottom_nav_bar_cubit.dart';
import '../../helpers/select_lang_dialog.dart';
import '../../helpers/show_loading_dialog.dart';
import '../../helpers/show_snack_bar.dart';
import '../auth/login_screen.dart';
import 'cart_screen.dart';
import 'favourite_screen.dart';
import 'orders_screen.dart';
import 'products_list_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const List<Widget> screen = [
    ProductsListScreen(),
    SearchScreen(),
    OrdersScreen(),
    FavouriteScreen(),
    CartScreen(),
  ];

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          showLoadingDialog();
        } else if (state is LogoutSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar("logedOutSuccess".tr, SnackBarMessageType.success);
          Get.off(() => LoginScreen());
        } else if (state is LogoutFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          return Row(
            children: [
              const NavRailExample(),
              Expanded(
                child: Scaffold(
                  body: SizedBox.expand(
                    child: HomeScreen.screen[
                        BlocProvider.of<BottomNavBarCubit>(context).index],
                  ),
                  //  bottomNavigationBar: const _CustomeNavigationBar(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NavRailExample extends StatefulWidget {
  const NavRailExample({super.key});

  @override
  State<NavRailExample> createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = BlocProvider.of<BottomNavBarCubit>(context).index;
    var theme = context.theme;
    const double iconsSize = 50;
    const double padding = 8;
    return NavigationRail(
      selectedIndex: selectedIndex,
      elevation: 50,
      backgroundColor: Colors.grey.shade100,
      minWidth: 150,
      onDestinationSelected: (int index) {
        setState(() {
          selectedIndex = index;
          BlocProvider.of<BottomNavBarCubit>(context).navigate(index: index);
        });
      },
      labelType: NavigationRailLabelType.selected,
      leading: const Text(
        'MedHub',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      selectedLabelTextStyle: const TextStyle(
        color: AppColors.primaryColor,
      ),
      unselectedLabelTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      useIndicator: false,
      trailing: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                showSelectLangDialog();
              },
              icon: const Icon(
                Icons.language,
                color: AppColors.primaryColor,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<LogoutCubit>(context).logout();
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.secondaryColor,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const ShowImage(imagePath: AppImages.logo, height: 100, width: 100),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          icon: const Icon(
            Icons.home_outlined,
            size: iconsSize,
          ),
          selectedIcon: const Icon(
            Icons.home,
            size: iconsSize,
            color: AppColors.primaryColor,
          ),
          label: Text(
            "home".tr,
            style: theme.textTheme.titleLarge,
          ),
          padding: const EdgeInsets.all(padding),
        ),
        NavigationRailDestination(
          icon: const Icon(
            Icons.search_outlined,
            size: iconsSize,
          ),
          selectedIcon: const Icon(
            Icons.search,
            size: iconsSize,
            color: AppColors.primaryColor,
          ),
          label: Text(
            "search".tr,
            style: theme.textTheme.titleLarge,
          ),
          padding: const EdgeInsets.all(padding),
        ),
        NavigationRailDestination(
          icon: const Icon(
            Icons.add_outlined,
            size: iconsSize,
          ),
          selectedIcon: const Icon(
            Icons.add,
            size: iconsSize,
            color: AppColors.primaryColor,
          ),
          label: Text(
            "orders".tr,
            style: theme.textTheme.titleLarge,
          ),
          padding: const EdgeInsets.all(padding),
        ),
        NavigationRailDestination(
          icon: const Icon(
            Icons.receipt_outlined,
            size: iconsSize,
          ),
          selectedIcon: const Icon(
            Icons.receipt,
            size: iconsSize,
            color: AppColors.primaryColor,
          ),
          label: Text(
            "orders".tr,
            style: theme.textTheme.titleLarge,
          ),
          padding: const EdgeInsets.all(padding),
        ),
        NavigationRailDestination(
          icon: const Icon(
            Icons.assessment_outlined,
            size: iconsSize,
          ),
          selectedIcon: const Icon(
            Icons.assessment,
            size: iconsSize,
            color: AppColors.primaryColor,
          ),
          label: Text(
            "orders".tr,
            style: theme.textTheme.titleLarge,
          ),
          padding: const EdgeInsets.all(padding),
        ),
      ],
    );
  }
}
