import 'package:evaluacion_final/models/category.dart';
import 'package:evaluacion_final/services/category_service.dart';
import 'package:evaluacion_final/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:evaluacion_final/models/item_lista.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  static List<ItemLista> options = [
    const ItemLista(name: 'Proveedores', value: 'suppliers'),
    const ItemLista(name: 'Categorias', value: 'categories'),
    const ItemLista(name: 'Productos', value: 'products'),
    const ItemLista(name: 'Salir', value: 'login'),
  ];

  void _menuNavSelect(BuildContext context, String value) {
    Navigator.pushNamed(context, value);
  }

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _menuNavSelect(context, value),
            itemBuilder: (BuildContext context) {
              return options.map((ItemLista opt) {
                return PopupMenuItem<String>(
                  value: opt.value,
                  child: Text(opt.name),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: categoryService.categories.length,
          itemBuilder: (BuildContext context, index) {
            final category = categoryService.categories[index];
            return GestureDetector(
              onTap: () {
                  categoryService.SelectCategory = category.copy();
                  Navigator.pushNamed(context, 'edit_category');
                },
                child: CategoryCard(
                  categoryId: category.categoryId,
                  categoryName: category.categoryName,
                  categoryState: category.categoryState,
                ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoryService.SelectCategory = CategoryList(
              categoryId: 0,
              categoryName: '',
              categoryState: '');
          Navigator.pushNamed(context, 'edit_category');
        }),
    );
  }
}