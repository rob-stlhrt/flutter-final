import 'package:evaluacion_final/providers/category_form_provider.dart';
import 'package:evaluacion_final/services/category_service.dart';
import 'package:evaluacion_final/services/product_service.dart';
import 'package:evaluacion_final/services/supplier_service.dart';
import 'package:flutter/material.dart';
import 'package:evaluacion_final/services/auth_service.dart';

import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'theme/theme.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => SupplierService()),
        ChangeNotifierProvider(create: (_) => ProductService())
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: MyTheme.myTheme,
    );
  }
}
