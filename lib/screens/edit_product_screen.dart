import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/providers/providers.dart';
import 'package:flutter_app_examfinal_gsa/services/services.dart';
import 'package:flutter_app_examfinal_gsa/ui/ui.dart';
import 'package:flutter_app_examfinal_gsa/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.SelectProduct!),
        child: _ProductScreenBody(
          productService: productService,
        ));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto'),
        elevation: 1,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              ProductImage(
                url: productService.SelectProduct!.productImage,
              ),
            ],
          ),
          _ProductForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.deleteProduct(productForm.product, context);
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.editOrCreateProduct(
                  productForm.product, context);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue:
                    product.productImage.isEmpty ? '' : product.productImage,
                onChanged: (value) => product.productImage = value,
                // Resto del código...
              ),
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Nombre del producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: '-----',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SwitchListTile.adaptive(
                    value: product.productState == 'Activa' ? true : false,
                    onChanged: (value) {
                      setState(() {
                        if (value) {
                          print(product.productState);
                          product.productState = 'Activa';
                        } else {
                          print(product.productState);
                          product.productState = 'Inactiva';
                        }
                      });
                    },
                    activeColor: Colors.orange,
                    title: Text(product.productState),
                  );
                },
              ),
            ],
          ), // Add closing parenthesis here
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
