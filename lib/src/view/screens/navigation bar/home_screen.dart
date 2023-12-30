import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_web/src/view/screens/drawer/statistics_screen.dart';
import 'package:pharmacy_warehouse_store_web/src/view/screens/navigation%20bar/add_product_screen.dart';
import 'package:pharmacy_warehouse_store_web/src/view/screens/navigation%20bar/report_view_screen.dart';
import 'package:pharmacy_warehouse_store_web/src/view/widgets/show_image.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../Cubits/Auth/Logout/logout_cubit.dart';
import '../../../Cubits/BottomNavBar/bottom_nav_bar_cubit.dart';
import '../../helpers/select_lang_dialog.dart';
import '../../helpers/show_loading_dialog.dart';
import '../../helpers/show_snack_bar.dart';
import '../auth/login_screen.dart';
import 'orders_screen.dart';
import 'products_list_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<Widget> screen = [
    const ProductsListScreen(),
    const SearchScreen(),
    const AddProductScreen(),
    const OrdersScreen(),
    const StatisticsScreen(),
    const ReportScreen(),
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
              const CustomeNaveRail(),
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

class CustomeNaveRail extends StatefulWidget {
  const CustomeNaveRail({super.key});

  @override
  State<CustomeNaveRail> createState() => _CustomeNaveRailState();
}

class _CustomeNaveRailState extends State<CustomeNaveRail> {
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    const double iconsSize = 50;
    const double padding = 8;
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        int selectedIndex = BlocProvider.of<BottomNavBarCubit>(context).index;
        return NavigationRail(
          selectedIndex: selectedIndex,
          elevation: 50,
          backgroundColor: Colors.grey.shade100,
          minWidth: 150,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
              BlocProvider.of<BottomNavBarCubit>(context)
                  .navigate(index: index);
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
                  onPressed: () async {
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
                const ShowImage(
                    imagePath: AppImages.logo, height: 100, width: 100),
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
                "Add".tr,
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
                "statistics".tr,
                style: theme.textTheme.titleLarge,
              ),
              padding: const EdgeInsets.all(padding),
            ),
          ],
        );
      },
    );
  }
}
