import 'package:sqflite/sqflite.dart';
import '../models/item_model.dart';
import '../helpers/database_helper.dart';

class ItemService {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Item>> getItems() async {
    final allRows = await dbHelper.queryAllRows();
    return allRows.map((row) => Item.fromMap(row)).toList();
  }

  Future<void> addItem(Item item) async {
    await dbHelper.insert(item.toMap());
  }

  Future<void> updateItem(Item item) async {
    await dbHelper.update(item.toMap());
  }

  Future<void> deleteItem(String id) async {
    await dbHelper.delete(id);
  }
}
