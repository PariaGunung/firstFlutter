import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/item_service.dart';
import '../widgets/item_card.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ItemService _itemService = ItemService();
  List<Item> _items = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  Item? _editingItem;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    _items = await _itemService.getItems();
    setState(() {});
  }

  void _addItem() {
    if (_nameController.text.isNotEmpty && _priceController.text.isNotEmpty) {
      final item = Item(
        name: _nameController.text,
        price: double.parse(_priceController.text),
      );
      _itemService.addItem(item);
      _loadItems();
      _nameController.clear();
      _priceController.clear();
    }
  }

  void _editItem(Item item) {
    setState(() {
      _editingItem = item;
      _nameController.text = item.name;
      _priceController.text = item.price.toString();
    });
  }

  void _updateItem() {
    if (_editingItem != null) {
      _editingItem!.name = _nameController.text;
      _editingItem!.price = double.parse(_priceController.text);
      _itemService.updateItem(_editingItem!);
      _loadItems();
      _nameController.clear();
      _priceController.clear();
      setState(() {
        _editingItem = null;
      });
    }
  }

  void _deleteItem(Item item) {
    _itemService.deleteItem(item.id);
    _loadItems();
  }

  void _goToSettings() {
    Navigator.pushNamed(context, '/settings');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the default back button behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,  // This removes the back button
          title: Text('Admin Page'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: _goToSettings,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Item Price'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _editingItem == null ? _addItem : _updateItem,
                    child: Text(_editingItem == null ? 'Add Item' : 'Update Item'),
                  ),
                  if (_editingItem != null)
                    SizedBox(width: 10),
                  if (_editingItem != null)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _editingItem = null;
                          _nameController.clear();
                          _priceController.clear();
                        });
                      },
                      child: Text('Cancel'),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return ItemCard(
                      item: item,
                      onEdit: () => _editItem(item),
                      onDelete: () => _deleteItem(item),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
