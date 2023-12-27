part of 'category_cubit.dart';

class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoriesFetchLoading extends CategoryState {}

final class CategoriesFetchSuccess extends CategoryState {
  List<Category> categories;
  CategoriesFetchSuccess({required this.categories});
}

final class CategoriesFetchFailure extends CategoryState {
  final String errorMessage;
  CategoriesFetchFailure({required this.errorMessage});
}

final class CategoriesNetworkFailure extends CategoryState {
  final String errorMessage;
  CategoriesNetworkFailure({required this.errorMessage});
}

final class CategoryFetchLoading extends CategoryState {}

final class CategoryFetchSuccess extends CategoryState {}

final class CategoryFetchFailure extends CategoryState {
  final String errorMessage;
  CategoryFetchFailure({required this.errorMessage});
}

final class CategoryFetchNetworkFailure extends CategoryState {
  final String errorMessage;
  CategoryFetchNetworkFailure({required this.errorMessage});
}

final class CategoryAddLoading extends CategoryState {}

final class CategoryAddSuccess extends CategoryState {}

final class CategoryAddFailure extends CategoryState {
  final String errorMessage;
  CategoryAddFailure({required this.errorMessage});
}

final class CategoryAddNetworkFailure extends CategoryState {
  final String errorMessage;
  CategoryAddNetworkFailure({required this.errorMessage});
}

final class CategoryDeleteLoading extends CategoryState {}

final class CategoryDeleteSuccess extends CategoryState {}

final class CategoryDeleteFailure extends CategoryState {
  final String errorMessage;
  CategoryDeleteFailure({required this.errorMessage});
}

final class CategoryDeleteNetworkFailure extends CategoryState {
  final String errorMessage;
  CategoryDeleteNetworkFailure({required this.errorMessage});
}
