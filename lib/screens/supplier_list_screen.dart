import 'package:evaluacion_final/models/supplier.dart';
import 'package:evaluacion_final/services/supplier_service.dart';
import 'package:evaluacion_final/widgets/provider_card.dart';
import 'package:flutter/material.dart';
import 'package:evaluacion_final/models/item_lista.dart';
import 'package:provider/provider.dart';

class SupplierListScreen extends StatelessWidget {
  const SupplierListScreen({super.key});

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
    final supplierService = Provider.of<SupplierService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedores'),
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
          itemCount: supplierService.suppliers.length,
          itemBuilder: (BuildContext context, index) {
            final supplier = supplierService.suppliers[index];
            return GestureDetector(
              onTap: () {
                  supplierService.SelectSupplier = supplier.copy();
                  Navigator.pushNamed(context, 'edit_supplier');
                },
                child: SupplierCard(
                  providerId: supplier.providerId,
                  providerName: supplier.providerName,
                  providerLastName: supplier.providerLastName,
                  providerMail: supplier.providerMail,
                  providerState: supplier.providerState,
                ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          supplierService.SelectSupplier = SupplierList(
              providerId: 0,
              providerName: '',
              providerLastName: '',
              providerMail: '',
              providerState: '',
              );
          Navigator.pushNamed(context, 'edit_supplier');
        }),
    );
  }
}