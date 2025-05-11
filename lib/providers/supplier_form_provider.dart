import 'package:flutter/material.dart';
import '../models/supplier.dart';

class SupplierFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  SupplierList supplier;
  SupplierFormProvider(this.supplier);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
