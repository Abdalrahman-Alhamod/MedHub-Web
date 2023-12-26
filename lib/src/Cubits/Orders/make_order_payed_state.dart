part of 'make_order_payed_cubit.dart';

final class MakeOrderPayedState {}

final class MakeOrderPayedInitial extends MakeOrderPayedState {}


final class MakeOrderPayedLoading extends MakeOrderPayedState {}

final class MakeOrderPayedSuccess extends MakeOrderPayedState {}

final class MakeOrderPayedFailure extends MakeOrderPayedState {
  String errorMessage;
  MakeOrderPayedFailure({required this.errorMessage});
}

final class MakeOrderPayedNetworkFailure extends MakeOrderPayedState {
  String errorMessage;
  MakeOrderPayedNetworkFailure({required this.errorMessage});
}
