import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../model/statistics.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(StatisticsInitial());
  void getStatistics() async {
    try {
      emit(StatisticsFetchLoading());
      Map<String, dynamic> statisticsJsonData = await Api.request(
          url: 'api/user/stat',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      Statistics statistics = Statistics.fromJson(statisticsJsonData);
      logger.f(statistics);

      emit(StatisticsFetchSuccess(statistics: statistics));
    } on DioException catch (exception) {
      logger.e("Orders Cubit : \nNetwork Failure \n${exception.message}");
      emit(
          StatisticsNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Orders Cubit : \nFetch Failure \n$e");
      emit(StatisticsFetchFailure(errorMessage: e.toString()));
    }
  }
}
