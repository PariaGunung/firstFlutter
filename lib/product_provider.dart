import 'package:flutter/material.dart';
import 'models.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  void loadProducts() {
    // Memuat produk dari sumber data (misalnya API atau database)
  }
}
