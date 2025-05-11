import 'dart:convert';

class CategoryResponse {
  CategoryResponse({
    required this.listado,
  });

  List<CategoryList> listado;

  factory CategoryResponse.fromJson(String str) =>
      CategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponse.fromMap(Map<String, dynamic> json) =>
      CategoryResponse(
        listado: List<CategoryList>.from(
            json["Listado Categorias"].map((x) => CategoryList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Listado Categorias": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class CategoryList {
  CategoryList({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  int categoryId;
  String categoryName;
  String categoryState;

  factory CategoryList.fromJson(String str) =>
      CategoryList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryList.fromMap(Map<String, dynamic> json) => CategoryList(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryState: json["category_state"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_state": categoryState,
      };

  CategoryList copy() => CategoryList(
        categoryId: categoryId,
        categoryName: categoryName,
        categoryState: categoryState,
      );
}
