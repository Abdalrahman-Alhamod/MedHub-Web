import 'package:flutter/material.dart';

import '../view/screens/auth/login_screen.dart';
import '../view/screens/navigation rail/statistics_screen.dart';
import '../view/screens/navigation rail/home.dart';
import '../view/screens/details/order_details_screen.dart';
import '../view/screens/details/product_details_screen.dart';
import '../view/screens/start/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  const AppPages._();

  // ignore: constant_identifier_names
  static const String INITIAL = Routes.HOME;

  static final Map<String, WidgetBuilder> routes = {
    Routes.SPLASH: (context) => const SplashScreen(),
    Routes.LOGIN: (context) => LoginScreen(),
    Routes.HOME: (context) => const Home(),
    Routes.PRODUCT_DETAILS: (context) => ProductDetailsScreen(),
    Routes.STATISTICS: (context) => const StatisticsScreen(),
    Routes.ORDER_DETAILS: (context) => const OrderDetailsScreen(),
  };
}
