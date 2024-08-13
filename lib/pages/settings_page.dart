import 'package:flutter/material.dart';
import '../models/purchase_history_model.dart';
import '../services/purchase_history_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final PurchaseHistoryService _historyService = PurchaseHistoryService();
  List<PurchaseHistory> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    _history = await _historyService.getPurchaseHistory();
    setState(() {});
  }

  void _logout(BuildContext context) {
    // Navigate back to the login page
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _history.isNotEmpty
                  ? ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        final purchase = _history[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                                'Purchase #${index + 1} - ${purchase.dateTime.toLocal().toString().split(' ')[0]}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...purchase.items.asMap().entries.map((entry) {
                                  final item = entry.value;
                                  final quantity =
                                      purchase.quantities[entry.key];
                                  return Text(
                                      '${item.name}: $quantity x \$${item.price.toStringAsFixed(2)}');
                                }).toList(),
                                Text(
                                    'Total: \$${purchase.totalPrice.toStringAsFixed(2)}'),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No transactions recorded yet.')),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
