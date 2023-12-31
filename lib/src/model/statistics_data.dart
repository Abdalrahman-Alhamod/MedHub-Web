class StatisticsData {
  int usersCount;
  int ordersCount;
  int soldMedicinesCount;
  int inStockMedicines;
  int inStockMedicinesQuantity;
  int totalIncome;
  int inPreparationOrders;
  int gettingDeliveredOrders;
  int deliveredOrders;
  int refusedOrders;
  Map<String, dynamic> purchasedCategoriesPercentages;
  Map<String, dynamic> inStockCategoriesPercentages;
  Map<String, dynamic>? monthCharts;
  Map<String, dynamic>? yearCharts;
  StatisticsData(
      {required this.usersCount,
      required this.ordersCount,
      required this.soldMedicinesCount,
      required this.inStockMedicines,
      required this.inStockMedicinesQuantity,
      required this.totalIncome,
      required this.refusedOrders,
      required this.inPreparationOrders,
      required this.deliveredOrders,
      required this.gettingDeliveredOrders,
      required this.purchasedCategoriesPercentages,
      required this.inStockCategoriesPercentages});
  factory StatisticsData.fromJson(jsonData) {
    return StatisticsData(
      usersCount: jsonData["users count"],
      ordersCount: jsonData["orders count"],
      soldMedicinesCount: jsonData["sold medicines count"],
      inStockMedicines: jsonData["in stock medicines"],
      inStockMedicinesQuantity: jsonData["in stock medicines quantity"],
      totalIncome: jsonData["total income"],
      refusedOrders: jsonData['refused orders'],
      inPreparationOrders: jsonData['in preparation orders'],
      deliveredOrders: jsonData['delivered orders'],
      gettingDeliveredOrders: jsonData['getting delivered orders'],
      purchasedCategoriesPercentages:
          jsonData['categories percentages for sold medicines'],
      inStockCategoriesPercentages: jsonData['categories percentages in stock'],
    );
  }
  @override
  String toString() {
    return '''
    Statistics {
      refusedOrders: $refusedOrders,
      inPreparationOrders: $inPreparationOrders,
      deliveredOrders: $deliveredOrders,
      gettingDeliveredOrders: $gettingDeliveredOrders,
      categoriesPercentages: $purchasedCategoriesPercentages
    }
  ''';
  }
}
