import 'dart:convert';
import 'package:shopping_cart/model/products_model.dart';

class DataModel {
  final List<ProductsModel> products;
  final int total;
  final int skip;
  final int limit;

  DataModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory DataModel.fromJson(String body) {
    final Map<String, dynamic> map = json.decode(body);
    return DataModel(
      products: (map['products'] as List)
          .map((product) => ProductsModel.fromMap(product))
          .toList(),
      total: map['total'] ?? 0,
      skip: map['skip'] ?? 0,
      limit: map['limit'] ?? 0,
    );
  }
  
  bool get hasMore => (skip + limit) < total;

  DataModel merge(DataModel other) {
    return DataModel(
      products: [...products, ...other.products],
      total: total,
      skip: other.skip,
      limit: other.limit,
    );
  }
}