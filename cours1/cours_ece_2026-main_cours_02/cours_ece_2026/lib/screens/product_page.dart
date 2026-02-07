import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../model/product.dart';
import '../model/product_api.dart';

class ProductViewModel extends ChangeNotifier {
  Product? _product;
  bool _isLoading = true;
  final ProductApiClient _apiClient = ProductApiClient(Dio());

  ProductViewModel() {
    loadProduct('5000159484695');
  }

  Product? get product => _product;
  bool get isLoading => _isLoading;

  void loadProduct(String barcode) async {
    _isLoading = true;
    notifyListeners();
    try {
      _product = await _apiClient.getProduct(barcode);
    } catch (e) {
      debugPrint('Erreur : $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ProductViewModel(),
        child: Consumer<ProductViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.product == null) {
              return const Center(child: Text('Erreur de chargement'));
            }
            return _ProductContentView(product: viewModel.product!);
          },
        ),
      ),
    );
  }
}

class _ProductContentView extends StatelessWidget {
  final Product product;
  const _ProductContentView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (product.picture != null) 
          Image.network(product.picture!, height: 300, fit: BoxFit.cover),
        Text(product.name ?? 'Nom inconnu', style: const TextStyle(fontSize: 24)),
        Text(product.brands?.join(', ') ?? ''),
        Text('Quantité : ${product.quantity ?? 'N/A'}'),
      ],
    );
  }
}