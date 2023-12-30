import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/src/Cubits/Report/report_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../helpers/show_loading_dialog.dart';
import '../../helpers/show_snack_bar.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.now().subtract(const Duration(days: 1)),
        endDate = DateTime.now();
    var startDateString = startDate.toString().split(" ").first.obs;
    var endDateString = endDate.toString().split(" ").first.obs;
    return Scaffold(
      body: Center(
        child: BlocListener<ReportCubit, ReportState>(
          listener: (context, state) async {
            if (state is ReportFetchLoading) {
              showLoadingDialog();
            } else if (state is ReportFetchSuccess) {
              Get.until((route) => !Get.isDialogOpen!);
              await Dio().get(state.pdfLink);
              showSnackBar("Report exported Successfully".tr,
                  SnackBarMessageType.success);
            } else if (state is ReportFetchNetworkFailure) {
              Get.until((route) => !Get.isDialogOpen!);
              showSnackBar(state.errorMessage, SnackBarMessageType.error);
            } else if (state is ReportFetchFailure) {
              Get.until((route) => !Get.isDialogOpen!);
              showSnackBar(state.errorMessage, SnackBarMessageType.error);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Export Report as PDF".tr,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 55,
                        child: Center(
                          child: Text(
                            "Start Date".tr,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: Center(
                          child: Text(
                            "End Date".tr,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: startDate,
                                firstDate: DateTime(2023),
                                lastDate: DateTime.now()
                                    .subtract(const Duration(days: 1)),
                              );
                              if (picked != null && picked != startDate) {
                                startDate = picked;
                                startDateString.value =
                                    startDate.toString().split(" ").first;
                              }
                            },
                            icon: const Icon(
                              Icons.date_range,
                              size: 40,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              startDateString.string,
                              style: const TextStyle(
                                  fontSize: 28, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate:
                                    startDate.add(const Duration(days: 1)),
                                firstDate:
                                    startDate.add(const Duration(days: 1)),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null && picked != endDate) {
                                endDate = picked;
                                endDateString.value =
                                    endDate.toString().split(" ").first;
                              }
                            },
                            icon: const Icon(
                              Icons.date_range,
                              size: 40,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              endDateString.string,
                              style: const TextStyle(
                                  fontSize: 28, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 70,
                width: 150,
                child: MaterialButton(
                  onPressed: () async {
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<ReportCubit>(context)
                        .getReport(startDate: startDate, endDate: endDate);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.primaryColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.ios_share,
                        size: 40,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Export".tr,
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
