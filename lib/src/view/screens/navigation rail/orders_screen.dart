import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../Cubits/Orders/orders_cubit.dart';
import '../../../model/order.dart';
import '../../helpers/show_snack_bar.dart';
import '../../widgets/order_card.dart';
import '../../widgets/order_type_card.dart';
import '../../widgets/show_image.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrdersCubit>(context)
        .getOrders(ordersType: OrderStatus().All);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const _OrdersTypeCardsView(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocConsumer<OrdersCubit, OrdersState>(
                listener: (context, state) {
                  if (state is OrdersFetchFailure) {
                    showSnackBar(state.errorMessage, SnackBarMessageType.error);
                  } else if (state is OrdersNetworkFailure) {
                    showSnackBar(state.errorMessage, SnackBarMessageType.error);
                  }
                },
                builder: (context, state) {
                  if (state is OrdersFetchSuccess) {
                    List<Order> orders = state.orders;
                    return _OrdersSuccessView(orders: orders);
                  } else if (state is OrdersFetchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (state is OrdersFetchEmpty) {
                    return const Center(
                      child: ShowImage(
                        imagePath: AppImages.emptyOrders,
                        height: 500,
                        width: 500,
                      ),
                    );
                  } else if (state is OrdersFetchFailure) {
                    return const Center(
                      child: ShowImage(
                        imagePath: AppImages.error,
                        height: 500,
                        width: 500,
                      ),
                    );
                  } else if (state is OrdersNetworkFailure) {
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
            ),
          ],
        ),
      ),
    );
  }
}

class _OrdersSuccessView extends StatelessWidget {
  const _OrdersSuccessView({required this.orders});
  final List<Order> orders;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 650,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.3, // Adjust this value based on your design
      ),
      itemCount: orders.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
        );
      },
    );
  }
}

class _OrdersTypeCardsView extends StatefulWidget {
  const _OrdersTypeCardsView();

  @override
  State<_OrdersTypeCardsView> createState() => _OrdersTypeCardsViewState();
}

class _OrdersTypeCardsViewState extends State<_OrdersTypeCardsView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 80,
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
                isSelected: selectedIndex == 0,
                color: AppColors.primaryColor,
                image: AppImages.allOrders,
                title: OrderStatus().All,
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                    BlocProvider.of<OrdersCubit>(context)
                        .getOrders(ordersType: OrderStatus().All);
                  });
                },
              ),
              OrderTypeCard(
                isSelected: selectedIndex == 1,
                color: Colors.orange,
                image: AppImages.orderPreparing,
                title: OrderStatus().Preparing,
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                    BlocProvider.of<OrdersCubit>(context)
                        .getOrders(ordersType: OrderStatus().Preparing);
                  });
                },
              ),
              OrderTypeCard(
                isSelected: selectedIndex == 2,
                color: Colors.blueGrey,
                image: AppImages.orderDelivering,
                title: OrderStatus().Delivering,
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                    BlocProvider.of<OrdersCubit>(context)
                        .getOrders(ordersType: OrderStatus().Delivering);
                  });
                },
              ),
              OrderTypeCard(
                isSelected: selectedIndex == 3,
                color: Colors.green,
                image: AppImages.orderRecieved,
                title: OrderStatus().Recieved,
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                    BlocProvider.of<OrdersCubit>(context)
                        .getOrders(ordersType: OrderStatus().Recieved);
                  });
                },
              ),
              OrderTypeCard(
                isSelected: selectedIndex == 4,
                color: Colors.red,
                image: AppImages.orderRefused,
                title: OrderStatus().Refused,
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                    BlocProvider.of<OrdersCubit>(context)
                        .getOrders(ordersType: OrderStatus().Refused);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
