import 'package:get/get.dart';

import '../view/screens/app bar/notification_screen.dart';
import '../view/screens/auth/login_screen.dart';
import '../view/screens/auth/register_screen.dart';
import '../view/screens/drawer/profile_screen.dart';
import '../view/screens/drawer/statistics_screen.dart';
import '../view/screens/navigation bar/home_screen.dart';
import '../view/screens/order_details_screen.dart';
import '../view/screens/product_details_screen.dart';
import '../view/screens/start/splash_screen.dart';
import '../view/screens/start/welcome_screen.dart';
import 'app_routes.dart';

class AppPages {
  const AppPages._();
  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => const SplashScreen()),
    GetPage(name: Routes.WELCOME, page: () => const WelcomeScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
    GetPage(name: Routes.HOME, page: () => const HomeScreen()),
    GetPage(
      name: Routes.PRODUCT_DETAILS,
      page: () => ProductDetailsScreen(),
    ),
    GetPage(name: Routes.NOTIFICATIONS, page: () => const NotificationScreen()),
    GetPage(name: Routes.PROFILE, page: () => const ProfileScreen()),
    GetPage(name: Routes.STATISTICS, page: () => const StatisticsScreen()),
    GetPage(name: Routes.ORDER_DETAILS, page: () => const OrderDetailsScreen()),
  ];
}
