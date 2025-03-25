import 'dart:developer';
import 'package:http/http.dart';
import 'package:shopping_cart/model/category_list_model.dart';
import 'package:shopping_cart/model/data_model.dart';

class ApiService {
  final Client _client = Client();

  Future<CategoryListModel?> getCategoryList() async{
    try{
      final Uri url = Uri(
        scheme: 'https',
        host: 'dummyjson.com',
        path: '/products/category-list',
      );
      final Response response = await _client.get(url);
      if(response.statusCode == 200){
        return CategoryListModel.fromMap(response.body);
      }
      log('Some Error occured..');
    }catch(e){
      log(e.toString());
    }
    return null;
  } 

  Future<DataModel?> getProductsByCategory(String category, {int limit = 5, int skip = 0}) async {
  try {
    final Uri url = Uri(
      scheme: 'https',
      host: 'dummyjson.com',
      path: '/products/category/$category',
      queryParameters: {
        'limit': limit.toString(),
        'skip': skip.toString(),
      }
    );
    final Response response = await _client.get(url);
    if (response.statusCode == 200) {
      return DataModel.fromJson(response.body);
    } else {
      log('Something went wrong.. Status code: ${response.statusCode}');
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}

  Future<DataModel?> getProducts(String section) async {
    try {
      final Uri url = Uri(
        scheme: 'https',
        host : 'dummyjson.com',
        path: '/products/category/$section',
        queryParameters: {
          'limit' : '100'
        }
      );
      final Response response = await _client.get(url);
      if (response.statusCode == 200) {
        return DataModel.fromJson(response.body);
      } else {
        log('Something went wrong..');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
