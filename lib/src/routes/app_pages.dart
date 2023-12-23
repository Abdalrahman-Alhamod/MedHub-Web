import 'package:flutter/material.dart';

import '../view/screens/app bar/notification_screen.dart';
import '../view/screens/auth/login_screen.dart';
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
  static const String INITIAL = Routes.HOME;

  static final Map<String, WidgetBuilder> routes = {
    Routes.SPLASH: (context) => const SplashScreen(),
    Routes.WELCOME: (context) => const WelcomeScreen(),
    Routes.LOGIN: (context) => LoginScreen(),
    Routes.HOME: (context) => const HomeScreen(),
    Routes.PRODUCT_DETAILS: (context) => ProductDetailsScreen(),
    Routes.NOTIFICATIONS: (context) => const NotificationScreen(),
    Routes.PROFILE: (context) => const ProfileScreen(),
    Routes.STATISTICS: (context) => const StatisticsScreen(),
    Routes.ORDER_DETAILS: (context) => const OrderDetailsScreen(),
  };
}
