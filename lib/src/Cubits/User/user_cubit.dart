import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void getUser() async {
    try {
      emit(UserFetchLoading());
      Map<String, dynamic> userJsonDate = await Api.request(
          url: 'api/user',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      User user = User.fromJson(userJsonDate['data']);
      emit(UserFetchSuccess(user: user));
    } on DioException catch (exception) {
      logger.e("User Cubit : \nNetwork Failure \n${exception.message}");
      emit(UserNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("User Cubit : \nFetch Failure \n$e");
      emit(UserFetchFailure(errorMessage: e.toString()));
    }
  }
}
