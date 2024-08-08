import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'admin_page.dart';
import 'cashier_page.dart';
import 'product_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider()..loadProducts(),
      child: MaterialApp(
        title: 'Aplikasi Kasir',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => CashierPage(),
          '/login': (context) => LoginPage(),
          '/admin': (context) => AdminPage(),
        },
      ),
    );
  }
}
