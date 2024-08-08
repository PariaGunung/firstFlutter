import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productData = prefs.getString('products') ?? '[]';
    final List<dynamic> productList = json.decode(productData);
    _products = productList.map((item) => Product(name: item['name'], price: item['price'])).toList();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    _products.add(product);
    notifyListeners();
    await saveProducts();
  }

  Future<void> saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productData = json.encode(_products.map((p) => {'name': p.name, 'price': p.price}).toList());
    await prefs.setString('products', productData);
  }
}
