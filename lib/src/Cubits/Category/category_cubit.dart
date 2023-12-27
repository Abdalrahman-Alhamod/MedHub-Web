import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../model/category.dart';
import '../../model/user.dart';
import '../../services/api.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  List<Category>? currentCategories;
  Category? fetchedCategory;
  Future<void> getCategories() async {
    try {
      emit(CategoriesFetchLoading());

      // Fetch Categories from API
      Map<String, dynamic> categoriesJsonData = await Api.request(
          url: 'api/categories',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      List<Category> categories = Category.fromListJson(categoriesJsonData);
      currentCategories = categories.toList();
      categories.insert(0, Category(id: 0, name: "All".tr));

      // await Future.delayed(const Duration(seconds: 2));
      // List<Category> categories = AppData.categories;
      emit(CategoriesFetchSuccess(categories: categories));
    } on DioException catch (exception) {
      logger.e("Category Cubit Fetch : \nNetwork Failure ");
      emit(
          CategoriesNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Category Cubit Fetch : \nFetch Failure ");
      emit(CategoriesFetchFailure(errorMessage: e.toString()));
    }
  }

  Future<void> addCategory({required Category category, int? id}) async {
    try {
      emit(CategoryAddLoading());
      String endpoint = "";
      if (id != null) {
        endpoint = id.toString();
      }
      // Fetch Categories from API
     await Api.request(
        url: 'admin/categories/$endpoint',
        body: category.toJson(),
        token: User.token,
        methodType: MethodType.post,
      ) as Map<String, dynamic>;


      // await Future.delayed(const Duration(seconds: 2));
      // List<Category> categories = AppData.categories;
      emit(CategoryAddSuccess());
    } on DioException catch (exception) {
      logger.e("Category Cubit Add : \nNetwork Failure ");
      emit(CategoryAddNetworkFailure(
          errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Category Cubit Add : \nFetch Failure ");
      emit(CategoryAddFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getCategory({required int id}) async {
    try {
      emit(CategoryFetchLoading());

      // Fetch Categories from API
      Map<String, dynamic> categoryJsonData = await Api.request(
          url: 'admin/categories/$id',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;

      fetchedCategory = Category.fromJson(categoryJsonData['category']);

      emit(CategoryFetchSuccess());
    } on DioException catch (exception) {
      logger.e("Category Cubit Fetch : \nNetwork Failure ");
      emit(CategoryFetchNetworkFailure(
          errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Category Cubit Fetch : \nFetch Failure \n${e.toString()}");
      emit(CategoryFetchFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteCategory({required int id}) async {
    try {
      emit(CategoryDeleteLoading());
      await Api.request(
        url: 'admin/categories/$id',
        body: {},
        token: User.token,
        methodType: MethodType.delete,
      ) as Map<String, dynamic>;


      // await Future.delayed(const Duration(seconds: 2));
      // List<Category> categories = AppData.categories;
      emit(CategoryDeleteSuccess());
    } on DioException catch (exception) {
      logger.e("Category Cubit Delete : \nNetwork Failure ");
      emit(CategoryDeleteNetworkFailure(
          errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Category Cubit Delete : \nFetch Failure ");
      emit(CategoryDeleteFailure(errorMessage: e.toString()));
    }
  }
}
