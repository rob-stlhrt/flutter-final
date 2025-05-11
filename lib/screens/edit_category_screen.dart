import 'package:flutter/material.dart';
import 'package:evaluacion_final/providers/category_form_provider.dart';
import 'package:evaluacion_final/services/category_service.dart';
import 'package:evaluacion_final/ui/input_decorations.dart';
import 'package:evaluacion_final/providers/providers.dart';
import 'package:provider/provider.dart';


class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return ChangeNotifierProvider(
      create: (_) => CategoryFormProvider(categoryService.SelectCategory!),
      child: _CategoryScreenBody(
        categoryService: categoryService,
      ), 
    );
  }
}

class _CategoryScreenBody extends StatelessWidget {
  final CategoryService categoryService;

  const _CategoryScreenBody({
    Key? key,
    required this.categoryService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child:
        Column(children: [
          Stack(
            children: [
              Text(categoryService.SelectCategory!.categoryName),
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
          _CategoryForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.deleteCategory(categoryForm.category, context);
              Navigator.pushNamed(context, 'categories');
            },
            heroTag: null,
          ),
          FloatingActionButton(
            child: const Icon(Icons.data_saver_on_sharp),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.editOrCreateCategory(categoryForm.category);
              Navigator.pushNamed(context, 'categories');
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _CategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryFrom = Provider.of<CategoryFormProvider>(context);
    final category = categoryFrom.category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: categoryFrom.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                initialValue: category.categoryName,
                onChanged: (value) => category.categoryName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el nombre es obligatorio';
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Nombre de la categoria',
                  labelText: 'Nombre Categoria',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: category.categoryState,
                onChanged: (value) => category.categoryState = value,
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
