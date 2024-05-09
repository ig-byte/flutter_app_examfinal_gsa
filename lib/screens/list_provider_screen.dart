import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/models/models.dart';
<<<<<<< HEAD
import 'package:flutter_app_examfinal_gsa/models/provider_model.dart';
import 'package:flutter_app_examfinal_gsa/screens/loading_screen.dart';
=======
import 'package:flutter_app_examfinal_gsa/screens/screens.dart';
>>>>>>> 412a86c (actualizacion de librerias)
import 'package:flutter_app_examfinal_gsa/services/services.dart';
import 'package:flutter_app_examfinal_gsa/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ListProveedoresScreen extends StatelessWidget {
  const ListProveedoresScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProviderService>(context);
    if (proveedorService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Listado de proveedor'),
      ),
      body: ListView.builder(
        itemCount: proveedorService.provider.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            proveedorService.SelectProv =
                proveedorService.provider[index].copy();
            Navigator.pushNamed(context, 'edit_proveedor');
          },
          child: ProveedoresCard(proveedor: proveedorService.provider[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          proveedorService.SelectProv = List_provider(
              ProveedorId: 0,
              ProveedorName: '',
              ProveedorLastName: '',
              ProveedorCorreo: '',
              ProveedorState: 'Activo');
          Navigator.pushNamed(context, 'edit_proveedor');
        },
      ),
    );
  }
}
