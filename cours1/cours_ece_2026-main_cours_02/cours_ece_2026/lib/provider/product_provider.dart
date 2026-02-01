import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../model/product.dart';

class ProductChangeNotifier extends ChangeNotifier {
  Product? _product;
  Product? get product => _product;

  ProductChangeNotifier() {
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.formation-flutter.fr/v2/getProduct?barcode=5000159484695',
      );

      if (response.statusCode == 200) {
        _product = Product.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }
}