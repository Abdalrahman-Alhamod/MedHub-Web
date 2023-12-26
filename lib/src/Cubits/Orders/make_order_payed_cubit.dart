import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'make_order_payed_state.dart';

class MakeOrderPayedCubit extends Cubit<MakeOrderPayedState> {
  MakeOrderPayedCubit() : super(MakeOrderPayedInitial());

  void makePayed({required int orderId}) async {
    try {
      emit(MakeOrderPayedLoading());
      Map<String, dynamic> jsonData = await Api.request(
        url: 'admin/carts/pay/$orderId',
        body: {},
        token: User.token,
        methodType: MethodType.post,
      ) as Map<String, dynamic>;
      logger.f(jsonData.toString());
      emit(MakeOrderPayedSuccess());
    } on DioException catch (exception) {
      logger.e(
          "Make Order Cubit Payed : \nNetwork Failure \n${exception.message}");
      emit(MakeOrderPayedNetworkFailure(
          errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Make Orders Payed Cubit : \nFailure \n$e");
      emit(MakeOrderPayedFailure(errorMessage: e.toString()));
    }
  }
}
