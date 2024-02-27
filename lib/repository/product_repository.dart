import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ecomerce_app_bloc/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {

  List<ProductModel> _myProductList = [];

  List<ProductModel> get myDataList => _myProductList;

  Future<List<ProductModel>> productFetched() async {
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'));
    var data = jsonDecode(response.body.toString());
    // print(data);
    if (response.statusCode == 200) {
      // _myProductList.clear();
      for (Map<String, dynamic> i in data) {
        _myProductList.add(ProductModel.fromJson(i));
      }
      return _myProductList;
    } else {
      return _myProductList;
    }
  }

}
