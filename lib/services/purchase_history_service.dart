import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/purchase_history_model.dart';

class PurchaseHistoryService extends ChangeNotifier {
  final List<PurchaseHistory> _history = [];

  Future<void> addPurchase(PurchaseHistory purchase) async {
    _history.add(purchase);
    notifyListeners(); // Notify listeners when the history is updated
  }

  Future<List<PurchaseHistory>> getPurchaseHistory() async {
    return _history;
  }
}
