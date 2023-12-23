import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import '../../../model/user.dart';
import '../../../services/api.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void registerWithPhoneNumber(
      {required String userName,
      required String pharmacyName,
      required String phoneNumber,
      required String password}) async {
    try {
      emit(RegisterLoading());
      dynamic registerData = await Api.request(
        url: 'register',
        body: {
          'name': userName,
          'pharmacyName': pharmacyName,
          'phoneNumber': phoneNumber,
          'password': password,
        },
        token: User.token,
        methodType: MethodType.post,
      );

      dynamic token = registerData['token'];
      User.token = token;
      //await Future.delayed(const Duration(seconds: 2));
      emit(RegisterSuccess());
    } on DioException catch (exception) {
      logger.e("Register Cubit : \nNetwork Failure + ${exception.toString()}");
      emit(RegisterFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Register Cubit : \nGeneral Failure + ${e.toString()}");
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
