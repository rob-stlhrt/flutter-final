import 'package:evaluacion_final/screens/edit_product_screen.dart';
import 'package:evaluacion_final/screens/product_list_screen.dart';
import 'package:evaluacion_final/screens/category_list_screen.dart';
import 'package:evaluacion_final/screens/edit_category_screen.dart';
import 'package:evaluacion_final/screens/edit_supplier_screen.dart';
import 'package:evaluacion_final/screens/home_screen.dart';
import 'package:evaluacion_final/screens/supplier_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:evaluacion_final/screens/login_screen.dart';
import 'package:evaluacion_final/screens/error_screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) =>  LoginScreen(),
    'home': (BuildContext context) =>  HomeScreen(),
    'categories': (BuildContext context) =>  CategoryListScreen(),
    'edit_category': (BuildContext context) =>  EditCategoryScreen(),
    'suppliers': (BuildContext context) =>  SupplierListScreen(),
    'edit_supplier': (BuildContext context) =>  EditSupplierScreen(),
    'products': (BuildContext context) =>  ProductListScreen(),
    'edit_product': (BuildContext context) =>  EditProductScreen(),

  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
