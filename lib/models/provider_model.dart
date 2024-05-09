import 'dart:convert';

class ProviderModel {
  ProviderModel({
    required this.listado,
  });

  List<List_provider> listado;

  factory ProviderModel.fromJson(String str) =>
      ProviderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProviderModel.fromMap(Map<String, dynamic> json) => ProviderModel(
        listado: List<List_provider>.from(
            json["Proveedores Listado"].map((x) => List_provider.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Proveedores Listado":
            List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class List_provider {
  List_provider({
    required this.ProveedorId,
    required this.ProveedorName,
    required this.ProveedorLastName,
    required this.ProveedorCorreo,
    required this.ProveedorState,
  });

  int ProveedorId;
  String ProveedorName;
  String ProveedorLastName;
  String ProveedorCorreo;
  String ProveedorState;

  factory List_provider.fromJson(String str) =>
      List_provider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory List_provider.fromMap(Map<String, dynamic> json) => List_provider(
        ProveedorId: json["providerid"],
        ProveedorName: json["provider_name"],
        ProveedorLastName: json["provider_last_name"],
        ProveedorCorreo: json["provider_mail"],
        ProveedorState: json["provider_state"],
      );

  Map<String, dynamic> toMap() => {
        "providerid": ProveedorId,
        "provider_name": ProveedorName,
        "provider_last_name": ProveedorLastName,
        "provider_mail": ProveedorCorreo,
        "provider_state": ProveedorState,
      };

  List_provider copy() => List_provider(
        ProveedorId: ProveedorId,
        ProveedorName: ProveedorName,
        ProveedorLastName: ProveedorLastName,
        ProveedorCorreo: ProveedorCorreo,
        ProveedorState: ProveedorState,
      );
}
