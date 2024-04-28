import 'package:automarket/Model/Tools/JsonParse/product_parse.dart';
import 'package:automarket/ViewModel/Home/HomeDataSource/home_source.dart';

class HomeRepository implements HomeDataSource {
  final HomeDataSource dataSource;

  HomeRepository({required this.dataSource});
  @override
  Future<List<ProductEntity>> getProducts() => dataSource.getProducts();

  @override
  Future<List<ProductEntity>> getProductsWithKeyWord(
          {required String keyWord}) =>
      dataSource.getProductsWithKeyWord(keyWord: keyWord);
}
