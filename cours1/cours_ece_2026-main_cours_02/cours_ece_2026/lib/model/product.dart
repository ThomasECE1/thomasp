import 'package:flutter/foundation.dart';

class Product {
  final String barcode;
  final String? name;
  final String? picture;
  final String? quantity;
  final List<String>? brands;
  final ProductNutriScore? nutriScore;

  Product({
    required this.barcode,
    this.name,
    this.picture,
    this.quantity,
    this.brands,
    this.nutriScore,
  });
}

class ProductResponse {
  final ProductData? data;

  ProductResponse.fromJson(Map<String, dynamic> json)
      : data = json['response'] != null ? ProductData.fromJson(json['response']) : null;

  Product toEntity() {
    return Product(
      barcode: data?.barcode ?? '',
      name: data?.name,
      picture: data?.pictures?['product'],
      quantity: data?.quantity,
      brands: data?.brands,
      nutriScore: _parseNutriScore(data?.nutriScore),
    );
  }

  static ProductNutriScore _parseNutriScore(String? score) {
    return switch (score?.toLowerCase()) {
      'a' => ProductNutriScore.A,
      'b' => ProductNutriScore.B,
      'c' => ProductNutriScore.C,
      'd' => ProductNutriScore.D,
      'e' => ProductNutriScore.E,
      _ => ProductNutriScore.unknown,
    };
  }
}

class ProductData {
  final String? barcode;
  final String? name;
  final String? quantity;
  final Map<String, dynamic>? pictures;
  final List<String>? brands;
  final String? nutriScore;

  ProductData.fromJson(Map<String, dynamic> json)
      : barcode = json['barcode']?.toString(),
        name = json['name'],
        quantity = json['quantity'],
        pictures = json['pictures'],
        nutriScore = json['nutriScore'],
        brands = json['brands'] != null ? List<String>.from(json['brands']) : null;
}

enum ProductNutriScore { A, B, C, D, E, unknown }