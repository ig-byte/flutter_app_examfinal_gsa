import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/providers/providers.dart';
import 'package:flutter_app_examfinal_gsa/services/services.dart';
import 'package:flutter_app_examfinal_gsa/ui/ui.dart';
import 'package:provider/provider.dart';

class EditProveedorScreen extends StatelessWidget {
  const EditProveedorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProviderService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProveedorFormProvider(proveedorService.SelectProv!),
        child: _ProvScreenBody(
          proveedorService: proveedorService,
        ));
  }
}

class _ProvScreenBody extends StatelessWidget {
  const _ProvScreenBody({
    Key? key,
    required this.proveedorService,
  }) : super(key: key);

  final ProviderService proveedorService;
  @override
  Widget build(BuildContext context) {
    final proveedorForm = Provider.of<ProveedorFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedor'),
        elevation: 1,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          _ProvForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              await proveedorService.deleteProv(
                  proveedorForm.proveedor, context);
              print("asdasdsadsadsadsa");
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              await proveedorService.editOrCreateProv(
                  proveedorForm.proveedor, context);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _ProvForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provForm = Provider.of<ProveedorFormProvider>(context);
    final prov = provForm.proveedor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: provForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: prov.ProveedorName,
                onChanged: (value) => prov.ProveedorName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Nombre del proveedor',
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                initialValue: prov.ProveedorLastName,
                onChanged: (value) => prov.ProveedorLastName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el apellido es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Apellido del proveedor',
                  labelText: 'Apellido',
                ),
              ),
              TextFormField(
                initialValue: prov.ProveedorCorreo,
                onChanged: (value) => prov.ProveedorCorreo = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'el correo es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Correo del proveedor',
                  labelText: 'Correo',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.orange,
                title: const Text('Activo'),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() =>
      const BoxDecoration(color: Colors.white, boxShadow: []);
}
