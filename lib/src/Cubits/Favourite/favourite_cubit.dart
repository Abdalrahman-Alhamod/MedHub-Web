import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../model/product.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  Future<void> toggleFavourate({required Product product}) async {
    try {
      emit(FavourateToggleLoading());
      String endPoint = '';
      if (product.isFavorite) {
        endPoint = 'api/user/unFavor';
      } else {
        endPoint = 'api/user/favor';
      }
      Api.request(
          url: '$endPoint/${product.id}',
          body: {},
          token: User.token,
          methodType: MethodType.post);

      // await Future.delayed(
      //   const Duration(seconds: 2),
      // );
      // add to favourate
      emit(FavourateToggleSuccess());
    } on DioException catch (exception) {
      logger.e("Favourite Cubit Toggle Favourite : \nNetwork Failure");
      emit(FavourateNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Favourite Cubit Toggle Favourite : \nToggle Failure");
      emit(FavoureteToggleFailure(errorMessage: e.toString()));
    }
  }
}
