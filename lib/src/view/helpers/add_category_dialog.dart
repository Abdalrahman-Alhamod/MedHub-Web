import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/src/Cubits/Category/category_cubit.dart';
import 'package:pharmacy_warehouse_store_web/src/model/category.dart';
import 'package:pharmacy_warehouse_store_web/src/view/widgets/custome_text_field.dart';

import 'show_loading_dialog.dart';
import 'show_snack_bar.dart';

// ignore: non_constant_identifier_names
void showAdd_EditCategoryDialog({Category? editedCategory}) {
  String name = "", arName = "";
  Get.until((route) => !Get.isDialogOpen!);
  String title = "";
  String successMessage = "";
  if (editedCategory == null) {
    title = "Add New Category".tr;
    successMessage = "Category Add Successfully".tr;
  } else {
    title = "Edit Category".tr;
    successMessage = "Category Edited Successfully".tr;
    name = editedCategory.name;
    arName = editedCategory.arName;
  }
  final formKey = GlobalKey<FormState>();
  textValidator(value) {
    if (value!.isEmpty) {
      return "fieldIsRequired".tr;
    } else {
      return null;
    }
  }

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
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
        child: BlocListener<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CategoryAddLoading) {
              showLoadingDialog();
            } else if (state is CategoryAddSuccess) {
              Get.back();
              showSnackBar(successMessage, SnackBarMessageType.success);
              Get.until((route) => !Get.isDialogOpen!);
            } else if (state is CategoryAddNetworkFailure) {
              Get.back();
              showSnackBar(state.errorMessage, SnackBarMessageType.error);
              Get.until((route) => !Get.isDialogOpen!);
            } else if (state is CategoryAddFailure) {
              Get.back();
              Get.until((route) => !Get.isDialogOpen!);
              showSnackBar(state.errorMessage, SnackBarMessageType.error);
              Get.until((route) => !Get.isDialogOpen!);
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32.0),
                CustomeTextField(
                  hintText: "Category English Name".tr,
                  onChanged: (value) {
                    name = value;
                  },
                  validator: textValidator,
                  prefixIcon: Icons.align_horizontal_left,
                  content: editedCategory == null ? "" : editedCategory.name,
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 16.0),
                CustomeTextField(
                  hintText: "Category Arabic Name".tr,
                  onChanged: (value) {
                    arName = value;
                  },
                  validator: textValidator,
                  prefixIcon: Icons.align_horizontal_right,
                  content: editedCategory == null ? "" : editedCategory.arName,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 32.0),
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Category category =
                              Category(id: 0, name: name, arName: arName);
                          if (editedCategory == null) {
                            await BlocProvider.of<CategoryCubit>(Get.context!)
                                .addCategory(
                              category: category,
                            );
                          } else {
                            await BlocProvider.of<CategoryCubit>(Get.context!)
                                .addCategory(
                                    category: category, id: editedCategory.id);
                          }
                        }
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
    barrierDismissible: true,
  );
}
