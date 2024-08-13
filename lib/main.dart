import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/admin_page.dart';
import 'pages/cashier_page.dart';
import 'pages/settings_page.dart';
import 'pages/payment_recap_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cashier System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/admin': (context) => AdminPage(),
        '/cashier': (context) => CashierPage(),
        '/settings': (context) => SettingsPage(),
        '/payment_recap': (context) => PaymentRecapPage(),
      },
    );
  }
}
