import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/assets/app_animations.dart';
import '../../../../core/assets/app_icons.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../Cubits/Auth/Login/login_cubit.dart';
import '../../helpers/show_loading_dialog.dart';
import '../../helpers/show_snack_bar.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/custome_text_field.dart';
import '../navigation rail/home.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  // ignore: unused_field
  static String? phoneNumber, password;

  final formKey = GlobalKey<FormState>();

  String? Function(String?) userNumberValidator = (value) {
    if (value!.isEmpty) {
      return "fieldIsRequired".tr;
    } else if (value.length >= 2 && value.substring(0, 2) != '09') {
      return "phoneNumberShouldStart".tr;
    } else if (value.length < 10 || value.length > 10) {
      return "phoneNumberLength".tr;
    } else if (int.tryParse(value) == null) {
      return "enterValidNumber".tr;
    } else {
      return null;
    }
  };

  String? Function(String?) passwordValidator = (value) {
    if (value!.isEmpty) {
      return "fieldIsRequired".tr;
    } else if (value.length < 8) {
      return "passwordShouldBe8".tr;
    } else {
      return null;
    }
  };

  @override
  Widget build(BuildContext context) {
    void signInUser() async {
      if (formKey.currentState!.validate()) {
        BlocProvider.of<LoginCubit>(context).signInWithPhoneNumberAndPassword(
            phoneNumber: phoneNumber!, password: password!);
      }
    }

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showLoadingDialog();
        } else if (state is LoginSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar("signedInSuccess".tr, SnackBarMessageType.success);
          Get.off(() => const Home());
        } else if (state is LoginFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Row(
          children: [
            Flexible(
              flex: 2,
              child: Center(
                child: Lottie.asset(AppAnimations.startAnimation),
              ),
            ),
            VerticalDivider(
              thickness: 3,
              width: 3,
              color: Colors.grey.shade300,
            ),
            Flexible(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages
                        .startWallpaper), // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: 360,
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo
                              const Icon(
                                AppIcons.lock,
                                size: 100,
                                color: AppColors.primaryColor,
                              ),

                              // Welcome message
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                "welcomeMessage".tr,
                                style: const TextStyle(
                                    fontSize: 32,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "enterCredentials".tr,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.secondaryTextColor,
                                    fontWeight: FontWeight.bold),
                              ),

                              // user email textfield
                              const SizedBox(
                                height: 50,
                              ),
                              CustomeTextField(
                                validator: userNumberValidator,
                                obscureText: false,
                                hintText: "userNumber".tr,
                                onChanged: (text) {
                                  phoneNumber = text;
                                  formKey.currentState!.validate();
                                },
                                keyboardType: TextInputType.phone,
                                prefixIcon: AppIcons.phone,
                              ),

                              // password textfield
                              const SizedBox(
                                height: 20,
                              ),
                              CustomeTextField(
                                validator: passwordValidator,
                                obscureText: true,
                                hintText: "password".tr,
                                onChanged: (text) {
                                  password = text;
                                  formKey.currentState!.validate();
                                },
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: AppIcons.password,
                              ),

                              // sign in button
                              const SizedBox(
                                height: 50,
                              ),
                              CustomeButton(
                                title: "signIn".tr,
                                onTap: signInUser,
                                height: 60,
                                width: 360,
                              ),

                              // not a member> register now
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
