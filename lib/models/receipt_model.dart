import 'item_model.dart';

class Receipt {
  List<Item> items;
  List<int> quantities;
  double totalPrice;

  Receipt({required this.items, required this.quantities, required this.totalPrice});

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()).toList(),
      'quantities': quantities,
      'totalPrice': totalPrice,
    };
  }

  static Receipt fromMap(Map<String, dynamic> map) {
    return Receipt(
      items: List<Item>.from(map['items'].map((item) => Item.fromMap(item))),
      quantities: List<int>.from(map['quantities']),
      totalPrice: map['totalPrice'],
    );
  }
}
