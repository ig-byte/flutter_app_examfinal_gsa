import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/models/provider_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProviderService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<List_provider> provider = [];
  List_provider? SelectProv;
  bool isLoading = true;
  bool isEditCreate = true;

  ProviderService() {
    loadProvs();
  }

  Future loadProvs() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final provsMap = Provider.fromJson(response.body);
    print(response.body);
    provider = provsMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProv(List_provider provider, BuildContext context) async {
    isEditCreate = true;
    notifyListeners();
    if (provider.ProveedorId == 0) {
      await this.createProv(provider);
    } else {
      await this.updateProv(provider);
    }

    isEditCreate = false;
    notifyListeners();
    loadProvs();
  }

  Future<String> updateProv(List_provider prov) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: prov.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //actualizamos el listado
    final index = provider
        .indexWhere((element) => element.ProveedorId == prov.ProveedorId);
    provider[index] = prov;

    return '';
  }

  Future createProv(List_provider provider) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: provider.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.provider.add(provider);
    return '';
  }

  Future deleteProv(List_provider provider, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: provider.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    this.provider.clear(); //borra todo el listado
    loadProvs();

    return '';
  }
}
