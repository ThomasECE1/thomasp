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
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                Positioned(
                  top: 0, left: 0, right: 0, height: 300,
                  child: (product.picture != null && product.picture!.isNotEmpty)
                      ? Image.network(
                          product.picture!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image, size: 50),
                          ),
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.fastfood, size: 50),
                        ),
                ),
                const Positioned(
                  top: 250, left: 0, right: 0, bottom: 0,
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
            _ProductBandeau(score: product.nutriScore?.name),
            const SizedBox(height: 20),
            _MyDataRow(label: 'Quantité', value: product.quantity),
            // Correction ici : on utilise les données simplifiées
            _MyDataRow(label: 'Code-barres', value: product.barcode),
          ],
        ),
      ),
    );
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
              child: Text('Score: ${score ?? 'unknown'}'),
            ),
          ),
          const VerticalDivider(),
          const Expanded(
            flex: 56,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Groupe Nova\nAliments transformés'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyDataRow extends StatelessWidget {
  final String label;
  final String? value;
  const _MyDataRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value ?? '-', style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}