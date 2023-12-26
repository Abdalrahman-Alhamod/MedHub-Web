import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/main.dart';
import 'package:pharmacy_warehouse_store_web/src/Cubits/Orders/change_order_status_cubit.dart';
import 'package:pharmacy_warehouse_store_web/src/Cubits/Orders/make_order_payed_cubit.dart';

import '../../../core/assets/app_images.dart';
import '../../../core/constants/app_colors.dart';
import '../../Cubits/Orders/orders_cubit.dart';
import '../../model/order.dart';
import '../helpers/show_loading_dialog.dart';
import '../helpers/show_snack_bar.dart';
import '../widgets/order_spec_text.dart';
import '../widgets/order_status_text.dart';
import '../widgets/order_type_card.dart';
import '../widgets/product_list_tile.dart';
import '../widgets/show_image.dart';
import 'navigation bar/home_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrdersCubit>(context).getOrder(id: Get.arguments as int);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "orderDetails".tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.off(() => const HomeScreen());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrderFetchFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          } else if (state is OrderNetworkFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          }
        },
        builder: (context, state) {
          if (state is OrderFetchSuccess) {
            Order order = state.order;
            return _OrderSuccessView(order: order);
          } else if (state is OrdersFetchLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is OrderFetchFailure) {
            return const Center(
              child: ShowImage(
                imagePath: AppImages.error,
                height: 500,
                width: 500,
              ),
            );
          } else if (state is OrderNetworkFailure) {
            return const Center(
              child: ShowImage(
                imagePath: AppImages.error404,
                height: 500,
                width: 500,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }
}

class _OrderSuccessView extends StatelessWidget {
  const _OrderSuccessView({required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Flexible(
            flex: 3,
            child: _OrderDetails(order: order),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Text(
                  "Change Order Status".tr,
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 24),
                ),
                Expanded(
                  child: _OrdersStatusCardsView(
                    order: order,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Text(
                  "Change Payment Statues".tr,
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 24),
                ),
                Expanded(
                  child: _OrdersPaymentCardsView(
                    order: order,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            flex: 8,
            child: _OrderProducts(order: order),
          ),
        ],
      ),
    );
  }
}

class _OrderProducts extends StatelessWidget {
  const _OrderProducts({
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 550,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3, // Adjust this value based on your design
        ),
        itemCount: order.orderedProducts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ProductListTile(
              product: order.orderedProducts[index].product,
              quantity: order.orderedProducts[index].orderedQuantity,
            ),
          );
        },
      ),
    );
  }
}

class _OrderDetails extends StatelessWidget {
  const _OrderDetails({
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderSpecText(
                      content: 'orderID'.tr,
                      imagePath: AppImages.orderID,
                    ),
                    OrderSpecText(
                      content: 'totalBill'.tr,
                      imagePath: AppImages.orderBill,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          "#${order.id}",
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 40,
                      child: Center(
                        child: AutoSizeText(
                          "${order.bill} ${"SP".tr}",
                          style: theme.textTheme.titleLarge,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderSpecText(
                      content: 'status'.tr,
                      imagePath: AppImages.orderStatus,
                    ),
                    OrderSpecText(
                      content: 'date'.tr,
                      imagePath: AppImages.orderDate,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: OrderStatusText(
                          status: order.status,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          order.date,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderSpecText(
                      content: 'Pharmacist Name'.tr,
                      imagePath: AppImages.userName,
                    ),
                    OrderSpecText(
                      content: 'Pharmacy Name'.tr,
                      imagePath: AppImages.pharmacyName,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          order.user!.name,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          order.user!.pharmacyName,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OrdersStatusCardsView extends StatelessWidget {
  const _OrdersStatusCardsView({required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    // if (widget.order.status == OrderStatus().Preparing) {
    //   selectedIndex = 0;
    // } else if (widget.order.status == OrderStatus().Delivering) {
    //   selectedIndex = 1;
    // } else if (widget.order.status == OrderStatus().Recieved) {
    //   selectedIndex = 2;
    // } else if (widget.order.status == OrderStatus().Refused) {
    //   selectedIndex = 3;
    // }
    return BlocListener<ChangeOrderStatusCubit, ChangeOrderStatusState>(
      listener: (context, state) {
        if (state is ChangeOrderStatusLoading) {
          showLoadingDialog();
        } else if (state is ChangeOrderStatusSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(
              "Order with id #${order.id} status changed Successfully !".tr,
              SnackBarMessageType.success);
          BlocProvider.of<OrdersCubit>(context).getOrder(id: order.id);
        } else if (state is ChangeOrderStatusNetworkFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        } else if (state is ChangeOrderStatusFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                OrderTypeCard(
                  isSelected: order.status == OrderStatus().Preparing,
                  color: Colors.orange,
                  image: AppImages.orderPreparing,
                  title: OrderStatus().Preparing,
                  isEnabled: false,
                  onTap: () {},
                ),
                OrderTypeCard(
                  isSelected: order.status == OrderStatus().Delivering,
                  color: Colors.blueGrey,
                  image: AppImages.orderDelivering,
                  title: OrderStatus().Delivering,
                  isEnabled: order.status == OrderStatus().Preparing,
                  onTap: () {
                    BlocProvider.of<ChangeOrderStatusCubit>(context)
                        .changeStatus(
                            orderId: order.id, newStatus: "getting delivered");
                  },
                ),
                OrderTypeCard(
                  isSelected: order.status == OrderStatus().Refused,
                  color: Colors.red,
                  image: AppImages.orderRefused,
                  title: OrderStatus().Refused,
                  isEnabled: order.status == OrderStatus().Preparing,
                  onTap: () {
                    BlocProvider.of<ChangeOrderStatusCubit>(context)
                        .changeStatus(orderId: order.id, newStatus: "refused");
                  },
                ),
                OrderTypeCard(
                  isSelected: order.status == OrderStatus().Recieved,
                  color: Colors.green,
                  image: AppImages.orderRecieved,
                  title: OrderStatus().Recieved,
                  isEnabled:
                      order.status == OrderStatus().Delivering && order.isPayed,
                  onTap: () {
                    BlocProvider.of<ChangeOrderStatusCubit>(context)
                        .changeStatus(
                            orderId: order.id, newStatus: "delivered");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrdersPaymentCardsView extends StatelessWidget {
  const _OrdersPaymentCardsView({required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    logger.f(order);
    return BlocListener<MakeOrderPayedCubit, MakeOrderPayedState>(
      listener: (context, state) {
        if (state is MakeOrderPayedLoading) {
          showLoadingDialog();
        } else if (state is MakeOrderPayedSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar("Order with id #${order.id} Payed Successfully !".tr,
              SnackBarMessageType.success);
          BlocProvider.of<OrdersCubit>(context).getOrder(id: order.id);
        } else if (state is MakeOrderPayedNetworkFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
          BlocProvider.of<OrdersCubit>(context).getOrder(id: order.id);
        } else if (state is MakeOrderPayedFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
          BlocProvider.of<OrdersCubit>(context).getOrder(id: order.id);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                OrderTypeCard(
                  isSelected: !order.isPayed,
                  color: Colors.deepOrange,
                  image: AppImages.orderNotPayed,
                  title: OrderStatus().NotPayed,
                  isEnabled: false,
                  onTap: () {},
                ),
                OrderTypeCard(
                  isSelected: order.isPayed,
                  color: Colors.teal,
                  image: AppImages.orderPayed,
                  title: OrderStatus().Payed,
                  isEnabled:
                      !order.isPayed && order.status != OrderStatus().Refused,
                  onTap: () {
                    BlocProvider.of<MakeOrderPayedCubit>(context)
                        .makePayed(orderId: order.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
