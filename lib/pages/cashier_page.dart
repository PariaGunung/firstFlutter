import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/item_model.dart';
import '../models/purchase_history_model.dart';
import '../services/item_service.dart';
import '../services/purchase_history_service.dart';


class CashierPage extends StatefulWidget {
  @override
  _CashierPageState createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  final ItemService _itemService = ItemService();
  final PurchaseHistoryService _historyService = PurchaseHistoryService();
  List<Item> _items = [];
  Map<Item, int> _selectedItems = {};
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    _items = await _itemService.getItems();
    setState(() {});
  }

  void _updateQuantity(Item item, int quantity) {
    if (quantity > 0) {
      _selectedItems[item] = quantity;
    } else {
      _selectedItems.remove(item);
    }
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    _totalPrice = _selectedItems.entries
        .map((entry) => entry.key.price * entry.value)
        .fold(0.0, (sum, current) => sum + current);
    setState(() {});
  }

  void _generateReceipt() async {
    final uuid = Uuid();
    final purchase = PurchaseHistory(
      id: uuid.v4(),
      items: _selectedItems.keys.toList(),
      quantities: _selectedItems.values.toList(),
      totalPrice: _totalPrice,
      dateTime: DateTime.now(),
    );

    await _historyService.addPurchase(purchase);

    _selectedItems.clear();
    _totalPrice = 0.0;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment processed!')));
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
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                    trailing: SizedBox(
                      width: 120,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              int currentQty = _selectedItems[item] ?? 0;
                              if (currentQty > 0) {
                                _updateQuantity(item, currentQty - 1);
                              }
                            },
                          ),
                          Text('${_selectedItems[item] ?? 0}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              int currentQty = _selectedItems[item] ?? 0;
                              _updateQuantity(item, currentQty + 1);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text('Total: \$${_totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedItems.isEmpty ? null : _generateReceipt,
              child: Text('Process Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
