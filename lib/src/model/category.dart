class Category {
  int id;
  String name;
  String arName;
  Category({
    required this.id,
    required this.name,
    this.arName = "",
  });
  
  @override
  String toString() {
    return '''
    Category {
        id: $id,
        name: $name,
        arName: $arName
      }
    ''';
  }

  // JSON encoder
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'ar_name': arName};
  }

  static Map<String, dynamic> toListJson(List<Category> categories) {
    return {'data': categories.map((product) => product.toJson()).toList()};
  }

  static List<Category> fromListJson(Map<String, dynamic> jsonData) {
    List<dynamic> jsonList = jsonData['data'];
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }

  // JSON decoder
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      arName: json['ar_name'] ?? "",
    );
  }
}
