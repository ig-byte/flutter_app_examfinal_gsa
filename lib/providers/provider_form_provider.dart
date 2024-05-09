import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/models/models.dart';

class ProveedorFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  List_provider proveedor;
  ProveedorFormProvider(this.proveedor);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
