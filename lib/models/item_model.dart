import 'package:uuid/uuid.dart';

class Item {
  String id;
  String name;
  double price;

  Item({String? id, required this.name, required this.price})
      : id = id ?? Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  static Item fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }
}
