import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_web/src/model/warehouse_product.dart';

import '../../../main.dart';
import '../../model/category.dart';
import '../../model/product.dart';
import '../../model/user.dart';
import '../../services/api.dart';
part 'products_state.dart';

class SearchConstraints {
  const SearchConstraints._();
  static const String name = 'name';
  static const String scientificName = 'scientificName';
  static const String description = 'description';
  static const String brand = 'brand';
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  String searchBarContent = "";
  Category choosenCategory = Category(id: 0, name: "All".tr);
  String searchByConstraints = SearchConstraints.name;

  Future<void> search() async {
    logger.i(
        "Product Cubit Search : \nChooosen category name : ${choosenCategory.name} \nSearch bar content : $searchBarContent \nSearch By constraints : $searchByConstraints");
    try {
      emit(ProductsFetchLoading());

      String endpoint = '';
      bool isAllChoosen = (choosenCategory.name.toString() == "All" ||
          choosenCategory.name.toString() == "الكل");

      if (searchBarContent == "" && isAllChoosen) {
        endpoint = 'api/medicines';
      } else if (searchBarContent == "" && !isAllChoosen) {
        endpoint = 'api/categories/${choosenCategory.id}';
      } else if (searchBarContent != "" && isAllChoosen) {
        endpoint = 'api/search/$searchBarContent/$searchByConstraints';
      } else if (searchBarContent != "" && !isAllChoosen) {
        endpoint =
            'api/search/${choosenCategory.id}/$searchBarContent/$searchByConstraints';
      }

      // Fetch Searched Products from API
      Map<String, dynamic> productsJsonData = await Api.request(
          url: endpoint,
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      List<Product> products = Product.fromListJson(productsJsonData);

      // await Future.delayed(const Duration(seconds: 2));
      // List<Product> products = AppData.filteredProducts[choosenCategory.id];
      if (products.isEmpty) {
        emit(ProductsNotFound());
        logger.e("Product Cubit Search : \nProduct Not Found");
      } else {
        emit(ProductsFetchSuccess(products: products));
      }
    } on DioException catch (exception) {
      logger.e("Product Cubit Search : \nNetwork Failure");
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Search : \nFetch Failure");
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getFavourites() async {
    try {
      emit(ProductsFetchLoading());

      // Fetch Favourite Products from API
      Map<String, dynamic> favouriteJsonData = await Api.request(
          url: 'api/user/favorites',
          body: {},
          token: User.token,
          methodType: MethodType.get) as Map<String, dynamic>;
      List<Product> favouriteProducts = Product.fromListJson(favouriteJsonData);

      // await Future.delayed(const Duration(seconds: 2));
      // List<Product> favouriteProducts = AppData.products;
      if (favouriteProducts.isEmpty) {
        emit(ProductsNotFound());
        logger.e("Product Cubit Favourite : \nProduct Not Found");
      } else {
        emit(ProductsFetchSuccess(products: favouriteProducts));
      }
    } on DioException catch (exception) {
      logger.e("Product Cubit Favourite : \nNetwork Failure ");
      emit(ProductNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Favourite : \nFetch Failure ");
      emit(ProductsFetchFailure(errorMessage: e.toString()));
    }
  }

  Future<void> addProduct(
      {required WarehouseProduct warehouseProduct, int? id}) async {
    try {
      emit(ProductAddLoading());
      String endpoint = "";
      if (id != null) {
        endpoint = id.toString();
      }
      await Api.request(
        url: 'admin/medicines/$endpoint',
        body: warehouseProduct.toJson(),
        token: User.token,
        methodType: MethodType.post,
        image: warehouseProduct.product.image,
      ) as Map<String, dynamic>;

      emit(ProductAddSuccess());
    } on DioException catch (exception) {
      logger.e("Product Cubit Add Warehouse Product : \nNetwork Failure ");
      emit(
          ProductAddNetworkFailure(errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Add Warehouse Product : \nAdd Failure ");
      emit(ProductAddFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteProduct({required int productId}) async {
    try {
      emit(ProductDeleteLoading());

      await Api.request(
        url: 'admin/medicines/$productId',
        body: {},
        token: User.token,
        methodType: MethodType.delete,
      ) as Map<String, dynamic>;

      emit(ProductDeleteSuccess());
    } on DioException catch (exception) {
      logger.e("Product Cubit Delete Method : \nNetwork Failure ");
      emit(ProductDeleteNetworkFailure(
          errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Delete Method : \nDelete Failure ");
      emit(ProductDeleteFailure(errorMessage: e.toString()));
    }
  }

  void getWarehouseProduct({required int id}) async {
    try {
      emit(WarehouseProductsFetchLoading());
      Map<String, dynamic> warehouseProductJsonData = await Api.request(
        url: 'admin/medicines/$id',
        body: {},
        token: User.token,
        methodType: MethodType.get,
      ) as Map<String, dynamic>;
      WarehouseProduct warehouseProduct =
          WarehouseProduct.fromJson(warehouseProductJsonData['medicine']);

      emit(WarehouseProductsFetchSuccess(warehouseProduct: warehouseProduct));
    } on DioException catch (exception) {
      logger.e(
          "Product Cubit Fetch Warehouse Product : \nNetwork Failure \n${exception.message}");
      emit(WarehouseProductFetchNetworkFailure(
          errorMessage: exception.message.toString()));
    } catch (e) {
      logger.e("Product Cubit Fetch Warehouse Product : \nFetch Failure \n$e");
      emit(WarehouseProductsFetchFailure(errorMessage: e.toString()));
    }
  }
}
