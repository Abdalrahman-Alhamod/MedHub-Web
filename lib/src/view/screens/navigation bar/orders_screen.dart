import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../Cubits/Orders/orders_cubit.dart';
import '../../../model/order.dart';
import '../../helpers/show_snack_bar.dart';
import '../../widgets/order_card.dart';
import '../../widgets/show_image.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrdersCubit>(context).getOrders();
    return Scaffold(
      body: BlocConsumer<OrdersCubit, OrdersState>(
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
    );
  }
}

class _OrdersSuccessView extends StatelessWidget {
  const _OrdersSuccessView({required this.orders});
  final List<Order> orders;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      itemCount: orders.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: OrderCard(
            order: orders[index],
          ),
        );
      },
    );
  }
}
