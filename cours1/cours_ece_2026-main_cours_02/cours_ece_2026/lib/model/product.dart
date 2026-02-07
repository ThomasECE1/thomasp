import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String barcode;
  final String? name;
  final String? picture;
  final String? quantity;
  final List<String>? brands;
  @JsonKey(name: 'manufacturing_countries')
  final List<String>? manufacturingCountries;
  @JsonKey(name: 'nutriscore')
  final ProductNutriScore? nutriScore;
  @JsonKey(name: 'novascore')
  final ProductNovaScore? novaScore;

  Product({
    required this.barcode,
    this.name,
    this.picture,
    this.quantity,
    this.brands,
    this.manufacturingCountries,
    this.nutriScore,
    this.novaScore,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json.containsKey('response') 
        ? json['response'] as Map<String, dynamic> 
        : json;
    return _$ProductFromJson(data);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

enum ProductNutriScore { A, B, C, D, E, unknown }

enum ProductNovaScore { 
  @JsonValue('group1') group1, 
  @JsonValue('group2') group2, 
  @JsonValue('group3') group3, 
  @JsonValue('group4') group4, 
  unknown 
}