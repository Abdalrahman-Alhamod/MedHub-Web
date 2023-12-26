part of 'change_order_status_cubit.dart';

final class ChangeOrderStatusState {}

final class ChangeOrderStatusInitial extends ChangeOrderStatusState {}

final class ChangeOrderStatusLoading extends ChangeOrderStatusState {}

final class ChangeOrderStatusSuccess extends ChangeOrderStatusState {}

final class ChangeOrderStatusFailure extends ChangeOrderStatusState {
  String errorMessage;
  ChangeOrderStatusFailure({required this.errorMessage});
}

final class ChangeOrderStatusNetworkFailure extends ChangeOrderStatusState {
  String errorMessage;
  ChangeOrderStatusNetworkFailure({required this.errorMessage});
}
