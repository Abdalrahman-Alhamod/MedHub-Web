import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../model/order.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  void getOrders({required String ordersType}) async {
    try {
      emit(OrdersFetchLoading());
      String endpoint = "";
      if (ordersType == OrderStatus().Preparing) {
        endpoint = "prep";
      } else if (ordersType == OrderStatus().Delivering) {
        endpoint = "getDel";
      } else if (ordersType == OrderStatus().Recieved) {
        endpoint = "del";
      } else if (ordersType == OrderStatus().Refused) {
        endpoint = "refused";
      }
      Map<String, dynamic> ordersJsonData = await Api.request(
          url: 'admin/carts/$endpoint',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      List<Order> orders = Order.fromListJson(ordersJsonData);
      if (orders.isEmpty) {
        emit(OrdersFetchEmpty());
      } else {
        emit(OrdersFetchSuccess(orders: orders));
      }
    } on DioException catch (exception) {
      logger.e("Orders Cubit : \nNetwork Failure \n${exception.message}");
      emit(OrdersNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Orders Cubit : \nFetch Failure \n$e");
      emit(OrdersFetchFailure(errorMessage: e.toString()));
    }
  }

  void getOrder({required int id}) async {
    try {
      emit(OrderFetchLoading());
      Map<String, dynamic> orderJsonData = await Api.request(
          url: 'api/carts/$id',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      Order order = Order.fromJson(orderJsonData['data']);
      emit(OrderFetchSuccess(order: order));
    } on DioException catch (exception) {
      logger.e("Orders Cubit : \nNetwork Failure \n${exception.message}");
      emit(OrderNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Orders Cubit : \nFetch Failure \n$e");
      emit(OrderFetchFailure(errorMessage: e.toString()));
    }
  }
}
