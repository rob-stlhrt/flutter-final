import 'package:evaluacion_final/models/category.dart';
import 'package:evaluacion_final/models/productos.dart';
import 'package:evaluacion_final/screens/loading_screen.dart';
import 'package:evaluacion_final/services/category_service.dart';
import 'package:evaluacion_final/services/product_service.dart';
import 'package:evaluacion_final/widgets/category_card.dart';
import 'package:evaluacion_final/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:evaluacion_final/models/item_lista.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

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
    final productService = Provider.of<ProductService>(context);

    if (productService.isLoading) return const LoadingScreen();


    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
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
          itemCount: productService.products.length,
          itemBuilder: (BuildContext context, index) {
            final product = productService.products[index];
            return GestureDetector(
                onTap: () {
                  productService.SelectProduct = product.copy();
                  Navigator.pushNamed(context, 'edit_product');
                },
                child: ProductCard(
                  product: product
                ));
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productService.SelectProduct = Listado(
                productId: 0,
                productName: '',
                productPrice: 0,
                productImage:
                    'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png',
                productState: '');
          Navigator.pushNamed(context, 'edit_product');
        }),
    );
  }
}