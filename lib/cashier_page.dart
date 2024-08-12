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

  void _addToCart(Product product) {
    setState(() {
      if (_cart.containsKey(product)) {
        _cart[product] = _cart[product]! + 1;
      } else {
        _cart[product] = 1;
      }
    });
  }

  double _calculateTotal() {
    double total = 0.0;
    _cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  void _completePayment() {
    final totalAmount = _calculateTotal();
    // Logika untuk menyimpan atau mencetak rekap pembayaran
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rekap Pembayaran'),
          content: Text('Total Pembayaran: Rp. $totalAmount'),
          actions: [
            TextButton(
              onPressed: () {
                // Logika untuk menyimpan atau mencetak
                Navigator.of(context).pop();
                setState(() {
                  _cart.clear(); // Kosongkan keranjang setelah pembayaran
                });
              },
              child: Text('Selesai'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kasir Page'),
      ),
      body: Column(
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
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total: Rp. ${_calculateTotal()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _completePayment,
                  child: Text('Bayar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
