import 'item_model.dart';

class PurchaseHistory {
  final String id;
  final List<Item> items;
  final List<int> quantities;
  final double totalPrice;
  final DateTime dateTime;

  PurchaseHistory({
    required this.id,
    required this.items,
    required this.quantities,
    required this.totalPrice,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'quantities': quantities,
      'totalPrice': totalPrice,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  static PurchaseHistory fromMap(Map<String, dynamic> map) {
    return PurchaseHistory(
      id: map['id'],
      items: List<Item>.from(map['items'].map((item) => Item.fromMap(item))),
      quantities: List<int>.from(map['quantities']),
      totalPrice: map['totalPrice'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}
