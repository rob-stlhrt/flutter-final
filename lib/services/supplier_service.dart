import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:evaluacion_final/models/supplier.dart';

class SupplierService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<SupplierList> suppliers = [];
  SupplierList? SelectSupplier;
  bool isLoading = true;
  bool isEditCreate = true;

  SupplierService() {
    loadSuppliers();
  }

  Future loadSuppliers() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, 'ejemplos/provider_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.get(url, headers: {'authorization': basicAuth});
    final suppliersMap = SupplierResponse.fromJson(response.body);
    print(response.body);
    suppliers = suppliersMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateSupplier(SupplierList supplier) async {
    isEditCreate = true;
 
    notifyListeners();
    if (supplier.providerId == 0) {
      await createSupplier(supplier);
    } else {
      await updateSupplier(supplier);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateSupplier(SupplierList supplier) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    Map<String, dynamic> supplierJson = {
      "provider_id": supplier.providerId,
      "provider_name": supplier.providerName,
      "provider_lastName": supplier.providerLastName,
      "provider_mail": supplier.providerMail,
      "provider_state": supplier.providerState,
    };
    
    final response = await http.post(
      url,
      body: json.encode(supplierJson),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final decodeResp = response.body;
    print(decodeResp);

    final index = suppliers.indexWhere((e) => e.providerId == supplier.providerId);
    suppliers[index] = supplier;

    return '';
  }

  Future createSupplier(SupplierList supplier) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    Map<String, dynamic> supplierJson = {
      "provider_id": supplier.providerId,
      "provider_name": supplier.providerName,
      "provider_lastName": supplier.providerLastName,
      "provider_mail": supplier.providerMail,
      "provider_state": supplier.providerState,
    };

    final response = await http.post(
      url,
      body: json.encode(supplierJson),
      headers: {
        'authorization': basicAuth,
        'Content-type': 'application/json; charset=UTF-8',
      },
    );
    final decodeResp = response.body;
    print(decodeResp);
    this.suppliers.add(supplier);
    return '';
  }

  Future deleteSupplier(SupplierList supplier, BuildContext context) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));


    Map<String, dynamic> supplierJson = { "provider_id": supplier.providerId}; // hay un tema entre el provider_id y el providerid

    final response = await http.post(
      url,
      body: json.encode(supplierJson),
      headers: {
        'authorization': basicAuth,
        'Content-type': 'application/json; charset=UTF-8',
      },
    );
    final decodeResp = response.body;
    print(decodeResp);
    suppliers.clear();
    loadSuppliers();
    Navigator.of(context).pushNamed('suppliers');
    return '';
  }
}
