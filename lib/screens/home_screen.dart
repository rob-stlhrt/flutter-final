import 'package:flutter/material.dart';
import 'package:evaluacion_final/models/item_lista.dart';

class HomeScreen extends StatelessWidget {

  final List<ItemLista> options = [
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Mobile'),
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
      body: Center(
        child: Text('Bienvenido a la tiendita!'),
      ),
    );
  }
}