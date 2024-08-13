import 'package:flutter/material.dart';
import '../models/receipt_model.dart';
import '../services/receipt_service.dart';

class PaymentRecapPage extends StatefulWidget {
  @override
  _PaymentRecapPageState createState() => _PaymentRecapPageState();
}

class _PaymentRecapPageState extends State<PaymentRecapPage> {
  final ReceiptService _receiptService = ReceiptService();
  List<Receipt> _receipts = [];

  @override
  void initState() {
    super.initState();
    _loadReceipts();
  }

  void _loadReceipts() async {
    _receipts = await _receiptService.getReceipts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Recap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _receipts.length,
          itemBuilder: (context, index) {
            final receipt = _receipts[index];
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Receipt #${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 10),
                    ...receipt.items.map((item) {
                      final quantity = receipt.quantities[receipt.items.indexOf(item)];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.name),
                          Text('Qty: $quantity'),
                          Text('\$${(item.price * quantity).toStringAsFixed(2)}'),
                        ],
                      );
                    }).toList(),
                    Divider(),
                    Text('Total: \$${receipt.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
