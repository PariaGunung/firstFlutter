import '../models/receipt_model.dart';

class ReceiptService {
  final List<Receipt> _receipts = [];

  Future<void> addReceipt(Receipt receipt) async {
    _receipts.add(receipt);
  }

  Future<List<Receipt>> getReceipts() async {
    return _receipts;
  }
}
