import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'product.dart';

part 'product_api.g.dart';

@RestApi(baseUrl: "https://api.formation-flutter.fr/v2/")
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String baseUrl}) = _ProductApiClient;

  @GET("getProduct")
  Future<Product> getProduct(@Query("barcode") String barcode);
}