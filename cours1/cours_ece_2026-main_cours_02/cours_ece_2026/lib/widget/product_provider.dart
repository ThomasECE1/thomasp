import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductProvider extends InheritedWidget {
  final Product product;

  const ProductProvider({
    super.key,
    required this.product,
    required super.child,
  });

  static ProductProvider of(BuildContext context) {
    final ProductProvider? result = context.dependOnInheritedWidgetOfExactType<ProductProvider>();
    assert(result != null, 'Aucun ProductProvider trouvé dans le contexte');
    return result!;
  }

  @override
  bool updateShouldNotify(ProductProvider oldWidget) {
    return product != oldWidget.product;
  }
}