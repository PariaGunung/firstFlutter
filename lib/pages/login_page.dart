import 'package:flutter/material.dart';
import 'admin_page.dart';
import 'cashier_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginAsAdmin() {
    // Replace this with actual authentication logic
    if (_idController.text == 'admin' && _passwordController.text == 'admin') {
      Navigator.pushNamed(context, '/admin');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid ID or Password')),
      );
    }
  }

  void _loginAsCashier() {
    Navigator.pushNamed(context, '/cashier');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log-in')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'Admin ID'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginAsAdmin,
                child: Text('Login as Admin'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginAsCashier,
                child: Text('Login as Cashier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
