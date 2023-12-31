import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../model/statistics_data.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(StatisticsInitial());
  void getStatistics({
    required DateTime monthChartsDate,
    required DateTime yearChartsDate,
  }) async {
    try {
      emit(StatisticsFetchLoading());
      Map<String, dynamic> statisticsJsonData = await Api.request(
          url: 'admin/stat',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      Map<String, dynamic> monthChartsJsonData = await Api.request(
          url: 'admin/charts/${monthChartsDate.year}/${monthChartsDate.month}',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      Map<String, dynamic> yearChartsJsonData = await Api.request(
          url: 'admin/charts/${monthChartsDate.year}/0',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      StatisticsData statistics = StatisticsData.fromJson(statisticsJsonData);
      statistics.monthCharts = monthChartsJsonData['income'];
      statistics.yearCharts = yearChartsJsonData['income'];
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
