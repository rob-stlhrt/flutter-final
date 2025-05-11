import 'dart:convert';

class SupplierResponse {
  SupplierResponse({
    required this.listado,
  });

  List<SupplierList> listado;

  factory SupplierResponse.fromJson(String str) =>
      SupplierResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SupplierResponse.fromMap(Map<String, dynamic> json) =>
      SupplierResponse(
        listado: List<SupplierList>.from(
            json["Proveedores Listado"].map((x) => SupplierList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Proveedores Listado": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class SupplierList {
  SupplierList({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  });

  int providerId;
  String providerName;
  String providerLastName;
  String providerMail;
  String providerState;

  factory SupplierList.fromJson(String str) =>
      SupplierList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SupplierList.fromMap(Map<String, dynamic> json) => SupplierList(
        providerId: json["providerid"],
        providerName: json["provider_name"],
        providerLastName: json["provider_last_name"],
        providerMail: json["provider_mail"],
        providerState: json["provider_state"],
      );

  Map<String, dynamic> toMap() => {
        "providerid": providerId,
        "provider_name": providerName,
        "provider_last_name": providerLastName,
        "provider_mail": providerMail,
        "provider_state": providerState,
      };

  SupplierList copy() => SupplierList(
        providerId: providerId,
        providerName: providerName,
        providerLastName: providerLastName,
        providerMail: providerMail,
        providerState: providerState,
      );
}
