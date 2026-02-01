import 'package:flutter/foundation.dart';

class Product {
  final String barcode;
  final String? name;
  final String? altName;
  final String? picture;
  final String? quantity;
  final List<String>? brands;
  final List<String>? manufacturingCountries;
  final ProductNutriScore? nutriScore;
  final ProductNutriScoreLevels? nutriScoreLevels;
  final ProductNovaScore? novaScore;
  final ProductGreenScore? greenScore;
  final List<String>? ingredients;

  final String? ingredientsWithAllergens;
  final List<String>? traces;
  final List<String>? allergens;
  final Map<String, String>? additives;
  final NutrientLevels? nutrientLevels;
  final NutritionFacts? nutritionFacts;
  final bool? ingredientsFromPalmOil;
  final ProductAnalysis? containsPalmOil;
  final ProductAnalysis? isVegan;
  final ProductAnalysis? isVegetarian;

  Product({
    required this.barcode,
    this.name,
    this.altName,
    this.picture,
    this.quantity,
    this.brands,
    this.manufacturingCountries,
    this.nutriScore,
    this.nutriScoreLevels,
    this.novaScore,
    this.greenScore,
    this.ingredients,
    this.ingredientsWithAllergens,
    this.traces,
    this.allergens,
    this.additives,
    this.nutrientLevels,
    this.nutritionFacts,
    this.ingredientsFromPalmOil,
    this.containsPalmOil,
    this.isVegan,
    this.isVegetarian,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    final json = data['response'];
    return Product(
      barcode: json['barcode']?.toString() ?? '',
      name: json['name'],
      altName: json['altName'],
      picture: json['pictures']?['product'],
      quantity: json['quantity'],
      brands: json['brands'] != null ? List<String>.from(json['brands']) : null,
      manufacturingCountries: json['manufacturingCountries'] != null
          ? List<String>.from(json['manufacturingCountries'])
          : null,
      nutriScore: _parseNutriScore(json['nutriScore']),
      novaScore: _parseNovaScore(json['novaScore']),
      greenScore: _parseGreenScore(json['ecoScoreGrade']),
      ingredients: json['ingredients']?['list'] != null 
          ? List<String>.from(json['ingredients']['list']) 
          : null,
      ingredientsWithAllergens: json['ingredients']?['withAllergens'],
      traces: json['traces']?['list'] != null 
          ? List<String>.from(json['traces']['list']) 
          : null,
      allergens: json['allergens']?['list'] != null 
          ? List<String>.from(json['allergens']['list']) 
          : null,
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

  static ProductNovaScore _parseNovaScore(dynamic score) {
    return switch (score?.toString()) {
      '1' => ProductNovaScore.group1,
      '2' => ProductNovaScore.group2,
      '3' => ProductNovaScore.group3,
      '4' => ProductNovaScore.group4,
      _ => ProductNovaScore.unknown,
    };
  }

  static ProductGreenScore _parseGreenScore(String? score) {
    return switch (score?.toLowerCase()) {
      'a' => ProductGreenScore.A,
      'b' => ProductGreenScore.B,
      'c' => ProductGreenScore.C,
      'd' => ProductGreenScore.D,
      'e' => ProductGreenScore.E,
      _ => ProductGreenScore.unknown,
    };
  }
}

class NutritionFacts {
  final String servingSize;
  final Nutriment? calories;
  final Nutriment? fat;
  final Nutriment? saturatedFat;
  final Nutriment? carbohydrate;
  final Nutriment? sugar;
  final Nutriment? fiber;
  final Nutriment? proteins;
  final Nutriment? sodium;
  final Nutriment? salt;
  final Nutriment? energy;

  NutritionFacts({
    required this.servingSize,
    this.calories,
    this.fat,
    this.saturatedFat,
    this.carbohydrate,
    this.sugar,
    this.fiber,
    this.proteins,
    this.sodium,
    this.salt,
    this.energy,
  });
}

class Nutriment {
  final String unit;
  final dynamic perServing;
  final dynamic per100g;
  Nutriment({required this.unit, this.perServing, this.per100g});
}

class NutrientLevels {
  final String? salt;
  final String? saturatedFat;
  final String? sugars;
  final String? fat;
  NutrientLevels({this.salt, this.saturatedFat, this.sugars, this.fat});
}

class ProductNutriScoreLevels {
  final ProductNutriScoreLevel? energy;
  final ProductNutriScoreLevel? fiber;
  final ProductNutriScoreLevel? fruitsVegetablesLegumes;
  final ProductNutriScoreLevel? proteins;
  final ProductNutriScoreLevel? salt;
  final ProductNutriScoreLevel? saturatedFat;
  final ProductNutriScoreLevel? sugars;

  ProductNutriScoreLevels({
    required this.energy,
    required this.fiber,
    required this.fruitsVegetablesLegumes,
    required this.proteins,
    required this.salt,
    required this.saturatedFat,
    required this.sugars,
  });
}

class ProductNutriScoreLevel {
  final double points;
  final double maxPoints;
  final String unit;
  final double value;
  final ProductNutriScoreLevelType type;

  ProductNutriScoreLevel({
    required this.points,
    required this.maxPoints,
    required this.unit,
    required this.value,
    required this.type,
  });
}

enum ProductNutriScoreLevelType { positive, negative, unknown }
enum ProductNutriScore { A, B, C, D, E, unknown }
enum ProductNovaScore { group1, group2, group3, group4, unknown }
enum ProductGreenScore { A, APlus, B, C, D, E, F, unknown }

enum ProductAnalysis {
  yes,
  no,
  maybe;

  static ProductAnalysis fromString(String? analysis) {
    return switch (analysis) {
      'yes' => ProductAnalysis.yes,
      'no' => ProductAnalysis.no,
      'maybe' => ProductAnalysis.maybe,
      _ => ProductAnalysis.maybe,
    };
  }
}