import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/providers/providers.dart';
import 'package:flutter_app_examfinal_gsa/services/services.dart';
import 'package:flutter_app_examfinal_gsa/ui/ui.dart';
import 'package:provider/provider.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return ChangeNotifierProvider(
        create: (_) => CategoryFormProvider(categoryService.SelectCategoria!),
        child: _CategoriaScreenBody(
          categoryService: categoryService,
        ));
  }
}

class _CategoriaScreenBody extends StatelessWidget {
  const _CategoriaScreenBody({
    Key? key,
    required this.categoryService,
  }) : super(key: key);

  final CategoryService categoryService;
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Categoria'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          _CategoriaForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.deleteCategoria(
                  categoryForm.categoria, context);
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.editOrCreateCategoria(
                  categoryForm.categoria, context);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _CategoriaForm extends StatelessWidget {
  @override
  void setState(VoidCallback fn) {}

  Widget build(BuildContext context) {
    final categoriaForm = Provider.of<CategoryFormProvider>(context);
    final categoria = categoriaForm.categoria;
    bool _isActive = true;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: categoriaForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: categoria.CategoryName,
                onChanged: (value) => categoria.CategoryName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Campo obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Indica la categoria',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SwitchListTile.adaptive(
                    value: categoria.CategoryState == 'Activa' ? true : false,
                    onChanged: (value) {
                      setState(() {
                        if (value) {
                          print(categoria.CategoryState);
                          categoria.CategoryState = 'Activa';
                        } else {
                          print(categoria.CategoryState);
                          categoria.CategoryState = 'Inactiva';
                        }
                      });
                    },
                    activeColor: Colors.orange,
                    title: const Text('Activa'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      );
}
