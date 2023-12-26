import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pharmacy_warehouse_store_web/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_web/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_web/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_web/src/Cubits/Products/products_cubit.dart';
import 'package:pharmacy_warehouse_store_web/src/model/category.dart';
import 'package:pharmacy_warehouse_store_web/src/model/product.dart';
import 'package:pharmacy_warehouse_store_web/src/model/warehouse_product.dart';
import 'package:pharmacy_warehouse_store_web/src/view/widgets/custome_button.dart';
import 'package:pharmacy_warehouse_store_web/src/view/widgets/custome_text_field.dart';

import '../../helpers/show_loading_dialog.dart';
import '../../helpers/show_snack_bar.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double floatingLabelFontSize = 24;

    final formKey = GlobalKey<FormState>();

    bool validateOnChange = 1 != 1;

    String enName = "",
        enScientificName = "",
        enBrand = "",
        enDescription = "",
        price = "",
        quantity = "",
        arName = "",
        arScientificName = "",
        arDescription = "",
        arBrand = "",
        profit = "";
    var selectedDate = "".obs;
    dynamic image;
    var imageName = "".obs;
    Category? category = AppData.categories[1];
    var selectedCategoryName = "".obs;
    Color selectedDateTextColor = Colors.grey;
    Color selectedImageTextColor = Colors.grey;
    Color selectedCategoryTextColor = Colors.grey;

    bool validateProfit() {
      int? intProfit = int.tryParse(profit);
      int? intPrice = int.tryParse(price);
      return intProfit != null && intPrice != null && intProfit < intPrice;
    }

    textValidator(value) {
      if (value!.isEmpty) {
        return "fieldIsRequired".tr;
      } else {
        return null;
      }
    }

    numberValidator(value) {
      if (value!.isEmpty) {
        return "fieldIsRequired".tr;
      } else if (int.tryParse(value) == null) {
        return "enterValidNumber".tr;
      } else if (int.tryParse(value) != null && int.tryParse(value)! <= 0) {
        return "Value must be greate than zero".tr;
      } else {
        return null;
      }
    }

    profitValidator(value) {
      if (value!.isEmpty) {
        return "fieldIsRequired".tr;
      } else if (int.tryParse(value) == null) {
        return "enterValidNumber".tr;
      } else if (int.tryParse(value) != null && int.tryParse(value)! <= 0) {
        return "Value must be greate than zero".tr;
      } else if (!validateProfit()) {
        return "Profit must be smaller than price".tr;
      } else {
        return null;
      }
    }

    Future<void> selectImage() async {
      // FilePickerResult? result = await FilePicker.platform.pickFiles(
      //   type: FileType.custom,
      //   allowedExtensions: ['png'],
      // );
      // if (result != null) {
      //   var picked = result.files.single.bytes;
      //   imageName.value = result.files.single.name;
      //   image = dio.MultipartFile.fromBytes(picked as List<int>,
      //       contentType: MediaType('application', 'form-data'));
      //   //image = base64Encode(picked as List<int>);
      //   selectedImageTextColor = Colors.grey;
      // } else {}

      final imageBytes = await ImagePickerWeb.getImageAsBytes();
      if (imageBytes != null) {
        image = base64Encode(imageBytes);
      }
    }

    Future<void> pickDate() async {
      DateTime date = DateTime.now();

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != date) {
        date = picked;
        selectedDate.value = date.toString().split(' ')[0];
        selectedDateTextColor = Colors.grey;
      }
    }

    selectCategory() {
      selectedCategoryName.value = category.name;
      selectedCategoryTextColor = Colors.grey;
    }

    addProduct() {
      WarehouseProduct addedProduct = WarehouseProduct(
        product: Product(
          id: 0,
          category: category,
          name: enName,
          scientificName: enScientificName,
          brand: enBrand,
          description: enDescription,
          expirationDate: selectedDate.string,
          price: int.parse(price),
          image: image,
          inStock: int.parse(quantity),
          isFavorite: false,
        ),
        arName: arName,
        arScientificName: arScientificName,
        arDescription: arDescription,
        arBrand: arBrand,
        profit: int.parse(profit),
      );
      BlocProvider.of<ProductsCubit>(context)
          .addProduct(warehouseProduct: addedProduct);
    }

    resetValues() {
      formKey.currentState!.reset();
      selectedCategoryName.value = "";
      selectedCategoryTextColor = Colors.grey;
      selectedDate.value = "";
      selectedDateTextColor = Colors.grey;
      imageName.value = "";
      selectedImageTextColor = Colors.grey;
      image = null;
    }

    bool validateValues() {
      bool check1 = false, check2 = false, check3 = false, check4 = false;
      check1 = formKey.currentState!.validate();

      if (selectedCategoryName.value == "") {
        selectedCategoryName.value = "Category is required !".tr;
        selectedCategoryTextColor = Colors.red;
      } else {
        check2 = true;
      }

      if (selectedDate.value == "") {
        selectedDate.value = "Date is required !".tr;
        selectedDateTextColor = Colors.red;
      } else {
        check3 = true;
      }

      if (image == null) {
        imageName.value = "Image is required !".tr;
        selectedImageTextColor = Colors.red;
      } else {
        check4 = true;
      }
      return check1 && check2 && check3 && check4;
    }

    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductAddLoading) {
          showLoadingDialog();
        } else if (state is ProductAddSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(
              "Product Added Successfully !".tr, SnackBarMessageType.success);
          resetValues();
        } else if (state is ProductAddFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        } else if (state is ProductAddNetworkFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.startWallpaper,
            ), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 128),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  "Add Product".tr,
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 12,
                child: Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 10,
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            CustomeTextField(
                              hintText: "English Name".tr,
                              onChanged: (value) {
                                enName = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: textValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.label,
                              textDirection: TextDirection.ltr,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomeTextField(
                              hintText: "English Scientific Name".tr,
                              onChanged: (value) {
                                enScientificName = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: textValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.science,
                              textDirection: TextDirection.ltr,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomeTextField(
                              hintText: "English Description".tr,
                              onChanged: (value) {
                                enDescription = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: textValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.description,
                              maxLines: 7,
                              textDirection: TextDirection.ltr,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomeTextField(
                              hintText: "English Brand Name".tr,
                              onChanged: (value) {
                                enBrand = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: textValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.business,
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Flexible(
                        flex: 10,
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            CustomeTextField(
                              hintText: "Arabic Name".tr,
                              onChanged: (value) {
                                arName = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: textValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.label,
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomeTextField(
                              hintText: "Arabic Scientific Name".tr,
                              onChanged: (value) {
                                arScientificName = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: textValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.science,
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomeTextField(
                              hintText: "Arabic Description".tr,
                              onChanged: (value) {
                                arDescription = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: textValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.description,
                              maxLines: 7,
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomeTextField(
                              hintText: "Arabic Brand Name".tr,
                              onChanged: (value) {
                                arBrand = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: textValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.business,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Flexible(
                        flex: 10,
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            CustomeTextField(
                              hintText: "Price".tr,
                              onChanged: (value) {
                                price = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: numberValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.monetization_on,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomeTextField(
                              hintText: "Profit".tr,
                              onChanged: (value) {
                                profit = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: profitValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.money,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomeTextField(
                              hintText: "Quantity".tr,
                              onChanged: (value) {
                                quantity = value;
                                if (validateOnChange) {
                                  formKey.currentState!.validate();
                                }
                              },
                              validator: numberValidator,
                              floatingLabelFontSize: floatingLabelFontSize,
                              prefixIcon: Icons.warehouse,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 220,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Product Category".tr,
                                        style: const TextStyle(
                                            fontSize: 24, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Text(
                                        "Expiration Date".tr,
                                        style: const TextStyle(
                                            fontSize: 24, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Text(
                                        "Product Image".tr,
                                        style: const TextStyle(
                                            fontSize: 24, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          selectCategory();
                                        },
                                        icon: const Icon(
                                          Icons.category,
                                          size: 40,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await pickDate();
                                        },
                                        icon: const Icon(
                                          Icons.date_range,
                                          size: 40,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await selectImage();
                                        },
                                        icon: const Icon(
                                          Icons.image,
                                          size: 40,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => SizedBox(
                                          width: 200,
                                          child: Text(
                                            selectedCategoryName.string,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: selectedCategoryTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Obx(
                                        () => Text(
                                          selectedDate.string,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: selectedDateTextColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Obx(
                                        () => SizedBox(
                                          width: 200,
                                          child: Text(
                                            imageName.string,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: selectedImageTextColor,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: CustomeButton(
                  title: "Add".tr,
                  onTap: () {
                    if (validateValues()) {
                      addProduct();
                    }
                  },
                  width: 350,
                  height: 80,
                  titleFontSize: 32,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
