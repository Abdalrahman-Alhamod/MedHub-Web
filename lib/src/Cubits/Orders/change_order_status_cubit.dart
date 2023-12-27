import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'change_order_status_state.dart';

class ChangeOrderStatusCubit extends Cubit<ChangeOrderStatusState> {
  ChangeOrderStatusCubit() : super(ChangeOrderStatusInitial());

  void changeStatus({required int orderId, required String newStatus}) async {
    try {
      emit(ChangeOrderStatusLoading());
      await Api.request(
        url: 'admin/carts/$orderId',
        body: {"status": newStatus},
        token: User.token,
        methodType: MethodType.post,
      ) as Map<String, dynamic>;
      emit(ChangeOrderStatusSuccess());
    } on DioException catch (exception) {
      logger.e(
          "Change Order Status Cubit : \nNetwork Failure \n${exception.message}");
      emit(ChangeOrderStatusNetworkFailure(
          errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Change Order Status Cubit : \nFailure \n$e");
      emit(ChangeOrderStatusFailure(errorMessage: e.toString()));
    }
  }
}
