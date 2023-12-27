part of 'products_cubit.dart';

final class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsFetchLoading extends ProductsState {}

final class ProductsFetchSuccess extends ProductsState {
  List<Product> products;
  ProductsFetchSuccess({required this.products});
}

final class ProductsFetchFailure extends ProductsState {
  String errorMessage;
  ProductsFetchFailure({required this.errorMessage});
}

final class ProductsNotFound extends ProductsState {}

final class ProductNetworkFailure extends ProductsState {
  String errorMessage;
  ProductNetworkFailure({required this.errorMessage});
}

final class ProductAddLoading extends ProductsState {}

final class ProductAddSuccess extends ProductsState {}

final class ProductAddFailure extends ProductsState {
  String errorMessage;
  ProductAddFailure({required this.errorMessage});
}

final class ProductAddNetworkFailure extends ProductsState {
  String errorMessage;
  ProductAddNetworkFailure({required this.errorMessage});
}

final class ProductDeleteLoading extends ProductsState {}

final class ProductDeleteSuccess extends ProductsState {}

final class ProductDeleteFailure extends ProductsState {
  String errorMessage;
  ProductDeleteFailure({required this.errorMessage});
}

final class ProductDeleteNetworkFailure extends ProductsState {
  String errorMessage;
  ProductDeleteNetworkFailure({required this.errorMessage});
}

final class WarehouseProductsFetchLoading extends ProductsState {}

final class WarehouseProductsFetchSuccess extends ProductsState {
 WarehouseProduct warehouseProduct;
  WarehouseProductsFetchSuccess({required this.warehouseProduct});
}

final class WarehouseProductsFetchFailure extends ProductsState {
  String errorMessage;
  WarehouseProductsFetchFailure({required this.errorMessage});
}

final class WarehouseProductFetchNetworkFailure extends ProductsState {
  String errorMessage;
  WarehouseProductFetchNetworkFailure({required this.errorMessage});
}