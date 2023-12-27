import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/src/Cubits/Category/category_cubit.dart';

import 'show_loading_dialog.dart';
import 'show_snack_bar.dart';

void showDeleteCateggoryDialog({required int id}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: SizedBox(
          width: 750,
          child: BlocListener<CategoryCubit, CategoryState>(
            listener: (context, state) {
             if (state is CategoryDeleteLoading) {
              showLoadingDialog();
            } else if (state is CategoryDeleteSuccess) {
              Get.back();
              showSnackBar("Category deleted successfully".tr, SnackBarMessageType.success);
              Get.until((route) => !Get.isDialogOpen!);
            } else if (state is CategoryDeleteNetworkFailure) {
              Get.back();
              showSnackBar(state.errorMessage, SnackBarMessageType.error);
              Get.until((route) => !Get.isDialogOpen!);
            } else if (state is CategoryDeleteFailure) {
              Get.back();
              Get.until((route) => !Get.isDialogOpen!);
              showSnackBar(state.errorMessage, SnackBarMessageType.error);
              Get.until((route) => !Get.isDialogOpen!);
            }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Delete Category".tr,
                  style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "${"Are you sure you want to delete the category with id".tr} #${id.toString()} ${"?".tr}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28.0,
                  ),
                ),
                const SizedBox(height: 44.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Get.back(); // Close the dialog
                      },
                      child: Text(
                        'cancel'.tr,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 75.0),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<CategoryCubit>(Get.context!)
                            .deleteCategory(id: id);
                      },
                      child: Text(
                        'confirm'.tr,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
