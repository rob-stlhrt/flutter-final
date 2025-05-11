import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:evaluacion_final/models/category.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<CategoryList> categories = [];
  CategoryList? SelectCategory;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoryService() {
    loadCategories();
  }
  Future loadCategories() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final categoriesMap = CategoryResponse.fromJson(response.body);
    print(response.body);
    categories = categoriesMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateCategory(CategoryList category) async {
    isEditCreate = true;
    notifyListeners();
    if (category.categoryId == 0) {
      await this.createCategory(category);
    } else {
      await this.updateCategory(category);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateCategory(CategoryList category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //actualizamos el listado
    final index = categories
        .indexWhere((element) => element.categoryId == category.categoryId);
    categories[index] = category;

    return '';
  }

  Future createCategory(CategoryList category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.categories.add(category);
    return '';
  }

  Future deleteCategory(CategoryList category, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.categories.clear(); //borra todo el listado
    loadCategories();
    Navigator.of(context).pushNamed('list');
    return '';
  }
}
