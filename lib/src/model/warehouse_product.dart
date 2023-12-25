import 'product.dart';

class WarehouseProduct {
  Product product;
  String arName;
  String arScientificName;
  String arDescription;
  String arBrand;
  int profit;
  WarehouseProduct(
      {required this.product,
      required this.arName,
      required this.arScientificName,
      required this.arDescription,
      required this.arBrand,
      required this.profit});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {};
    temp.addAll(product.toJson());
    temp.addAll({
      'ar_name': arName,
      'ar_scientificName': arScientificName,
      'ar_description': arDescription,
      'ar_brand': arBrand,
      'profit': profit,
    });
    return temp;
  }

  @override
  String toString() {
    return '''
    WarehouseProduct {
      product: ${product.toString()},
      arName: $arName,
      arScientificName: $arScientificName,
      arDescription: $arDescription,
      arBrand: $arBrand,
      profit: $profit,
    }
  ''';
  }
}
