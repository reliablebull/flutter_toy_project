import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/Product.dart';
import 'package:eat_project/repository/product_repository.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  ProductRepository _productRepository = ProductRepository();

  List<Product> _products = [];
  List<Product> get product => _products;

  loadProducts(Movie movie) async {
    List<Product> listProduct = await _productRepository.loadProducts(movie);

    if (listProduct != []) _products = listProduct;
    //_movieRepository.test();
    notifyListeners();
  }
}
