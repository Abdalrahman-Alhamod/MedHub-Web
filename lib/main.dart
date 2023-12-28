import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_lib;
import 'package:logger/logger.dart';
import 'package:pharmacy_warehouse_store_web/firebase_options.dart';
import 'core/constants/app_general_constants.dart';
import 'core/constants/app_theme.dart';
import 'src/Cubits/Auth/Login/login_cubit.dart';
import 'src/Cubits/Auth/Logout/logout_cubit.dart';
import 'src/Cubits/BottomNavBar/bottom_nav_bar_cubit.dart';
import 'src/Cubits/Cart/cart_cubit.dart';
import 'src/Cubits/Category/category_cubit.dart';
import 'src/Cubits/Favourite/favourite_cubit.dart';
import 'src/Cubits/Home/home_cubit.dart';
import 'src/Cubits/Orders/change_order_status_cubit.dart';
import 'src/Cubits/Orders/make_order_payed_cubit.dart';
import 'src/Cubits/Orders/orders_cubit.dart';
import 'src/Cubits/Products/products_cubit.dart';
import 'src/Cubits/Statistics/statistics_cubit.dart';
import 'src/Cubits/User/user_cubit.dart';
import 'src/Locale/local_controller.dart';
import 'src/Locale/locale.dart';
import 'src/routes/app_pages.dart';
import 'src/services/firebase_api.dart';
import 'src/services/simple_bloc_observer.dart';
import 'src/view/screens/start/splash_screen.dart';

Logger logger = Logger(printer: PrettyPrinter(printEmojis: false));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  await FirebaseApi().initNotifications();
  get_lib.Get.put(AppLocalController());
  Bloc.observer = SimpleBlocObserver();
  return runApp(const MedHubWeb());
}

class MedHubWeb extends StatelessWidget {
  const MedHubWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider(
          create: (context) => FavouriteCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(),
        ),
        BlocProvider(
          create: (context) => OrdersCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => StatisticsCubit(),
        ),
        BlocProvider(
          create: (context) => MakeOrderPayedCubit(),
        ),
        BlocProvider(
          create: (context) => ChangeOrderStatusCubit(),
        ),
      ],
      child: get_lib.GetMaterialApp(
        title: kAppTitle,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        defaultTransition: get_lib.Transition.native,
        transitionDuration: const Duration(seconds: 1),
        translations: AppLocale(),
        locale: const Locale('en'),
        routes: AppPages.routes,
        home: const SplashScreen(),
      ),
    );
  }
}
