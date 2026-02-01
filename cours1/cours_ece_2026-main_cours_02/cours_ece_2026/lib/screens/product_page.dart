import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:formation_flutter/provider/product_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductChangeNotifier(),
      child: Scaffold(
        body: Consumer<ProductChangeNotifier>(
          builder: (context, notifier, child) {
            final product = notifier.product;

            if (product == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 300,
                  child: Image.network(
                    product.picture ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  top: 250,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _ProductDetails(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails();

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductChangeNotifier>().product;

    if (product == null) return const SizedBox();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              product.brands?.join(', ') ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _ProductBandeau(score: product.nutriScore?.name.toUpperCase()),
            const SizedBox(height: 20),
            MyDataRow(label: 'Quantité', value: product.quantity),
            MyDataRow(
              label: 'Vendu',
              value: product.manufacturingCountries?.join(', '),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductNutriscoreWidget extends StatelessWidget {
  final String score;

  const ProductNutriscoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    String imagePath;
    switch (score) {
      case 'A': imagePath = AppImages.nutriscoreA; break;
      case 'B': imagePath = AppImages.nutriscoreB; break;
      case 'C': imagePath = AppImages.nutriscoreC; break;
      case 'D': imagePath = AppImages.nutriscoreD; break;
      default: imagePath = AppImages.nutriscoreE;
    }

    return Image.asset(imagePath, fit: BoxFit.contain);
  }
}

class _ProductBandeau extends StatelessWidget {
  final String? score;

  const _ProductBandeau({this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 44,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ProductNutriscoreWidget(score: score ?? 'E'),
            ),
          ),
          const MySeparator(axis: Axis.vertical),
          Expanded(
            flex: 56,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Groupe Nova',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Aliments non transformés ou transformés minimalement',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDataRow extends StatelessWidget {
  final String label;
  final String? value;
  final bool showSeparator;

  const MyDataRow({
    super.key,
    required this.label,
    this.value,
    this.showSeparator = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(value ?? '', style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        if (showSeparator) const MySeparator(axis: Axis.horizontal),
      ],
    );
  }
}

class MySeparator extends StatelessWidget {
  final Axis axis;
  const MySeparator({super.key, required this.axis});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: axis == Axis.vertical ? 1.0 : double.infinity,
      height: axis == Axis.horizontal ? 1.0 : double.infinity,
      color: Colors.grey.shade300,
    );
  }
}

class AppImages {
  static const String nutriscoreA = 'res/drawables/nutriscore_a.png';
  static const String nutriscoreB = 'res/drawables/nutriscore_b.png';
  static const String nutriscoreC = 'res/drawables/nutriscore_c.png';
  static const String nutriscoreD = 'res/drawables/nutriscore_d.png';
  static const String nutriscoreE = 'res/drawables/nutriscore_e.png';
}