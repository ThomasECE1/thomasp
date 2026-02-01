import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductChangeNotifier extends ChangeNotifier {
  Product? _product;

  Product? get product => _product;

  ProductChangeNotifier() {
    loadProduct();
  }

  void loadProduct() async {
    await Future.delayed(const Duration(seconds: 2));
    _product = generateProduct();
    notifyListeners();
  }
}