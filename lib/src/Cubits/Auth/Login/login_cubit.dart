import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import '../../../model/user.dart';
import '../../../services/api.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void signInWithPhoneNumberAndPassword(
      {required String phoneNumber, required String password}) async {
    try {
      emit(LoginLoading());
      dynamic loginData = await Api.request(
        url: 'login',
        body: {
          'phoneNumber': phoneNumber,
          'password': password,
        },
        token: User.token,
        methodType: MethodType.post,
      );
      dynamic token = loginData['token'];
      User.token = token;
      // await Future.delayed(const Duration(seconds: 2));
      emit(LoginSuccess());
    } on DioException catch (exception) {
      logger.e("Login Cubit : \nNetwork Failure + ${exception.toString()}");
      emit(LoginFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Login Cubit : \nGeneral Failure + ${e.toString()}");
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
