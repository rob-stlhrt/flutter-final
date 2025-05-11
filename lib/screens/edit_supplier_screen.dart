import 'package:evaluacion_final/providers/supplier_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:evaluacion_final/services/supplier_service.dart';
import 'package:evaluacion_final/ui/input_decorations.dart';
import 'package:evaluacion_final/providers/providers.dart';
import 'package:provider/provider.dart';


class EditSupplierScreen extends StatelessWidget {
  const EditSupplierScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final supplierService = Provider.of<SupplierService>(context);
    return ChangeNotifierProvider(
      create: (_) => SupplierFormProvider(supplierService.SelectSupplier!),
      child: _SupplierScreenBody(
        supplierService: supplierService,
      ),
    );
  }
}

class _SupplierScreenBody extends StatelessWidget {
  final SupplierService supplierService;

  const _SupplierScreenBody({
    Key? key,
    required this.supplierService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final supplierForm = Provider.of<SupplierFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child:
        Column(children: [
          Stack(
            children: [
              Text(supplierService.SelectSupplier!.providerName),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 40,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
          _SupplierForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!supplierForm.isValidForm()) return;
              await supplierService.deleteSupplier(supplierForm.supplier, context);
              Navigator.pushNamed(context, 'suppliers');
            },
            heroTag: null,
          ),
          FloatingActionButton(
            child: const Icon(Icons.data_saver_on_sharp),
            onPressed: () async {
              if (!supplierForm.isValidForm()) return;
              await supplierService.editOrCreateSupplier(supplierForm.supplier);
              Navigator.pushNamed(context, 'suppliers');
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _SupplierForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final supplierForm = Provider.of<SupplierFormProvider>(context);
    final supplier = supplierForm.supplier;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: supplierForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                initialValue: supplier.providerName,
                onChanged: (value) => supplier.providerName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el nombre es obligatorio';
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Nombre de la proveedor',
                  labelText: 'Nombre Proveedor',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: supplier.providerLastName,
                onChanged: (value) => supplier.providerLastName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el apellido es obligatorio';
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Apellido de la proveedor',
                  labelText: 'Apellido Proveedor',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: supplier.providerMail,
                onChanged: (value) => supplier.providerMail = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el correo es obligatorio';
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Correo del proveedor',
                  labelText: 'Correo Proveedor',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: supplier.providerState,
                onChanged: (value) => supplier.providerState = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el estado es obligatorio';
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'activa o inactiva',
                  labelText: 'Estado',
                ),
              ),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
