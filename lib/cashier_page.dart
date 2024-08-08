import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';
import 'models.dart';

class CashierPage extends StatefulWidget {
  @override
  _CashierPageState createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  final Map<Product, int> _cart = {};

  double get _totalPrice {
    return _cart.entries.fold(0.0, (total, entry) => total + entry.key.price * entry.value);
  }

  void _addToCart(Product product) {
    setState(() {
      if (_cart.containsKey(product)) {
        _cart[product] = _cart[product]! + 1;
      } else {
        _cart[product] = 1;
      }
    });
  }

  void _checkout() {
    setState(() {
      _cart.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaksi berhasil')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cashier Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      final product = provider.products[index];
                      return ListTile(
                        title: Text(product.name),
                        trailing: Text('Rp. ${product.price}'),
                        onTap: () => _addToCart(product),
                      );
                    },
                  );
                },
              ),
            ),
            Text(
              'Total: Rp. $_totalPrice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkout,
              child: Text('Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
