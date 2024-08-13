import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';  // Ensure this import is present
import 'package:myapp/pages/admin_page.dart';
import 'package:myapp/pages/settings_page.dart';
import 'package:myapp/services/purchase_history_service.dart';
import 'package:myapp/models/purchase_history_model.dart';

void main() {
  group('AdminPage Widget Tests', () {
    testWidgets('AdminPage should render the title and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AdminPage()));

      expect(find.text('Admin Page'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Add Item'), findsOneWidget);
    });

    testWidgets('AdminPage should render the settings icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AdminPage()));

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });

  group('SettingsPage Widget Tests', () {
    final purchaseHistoryService = PurchaseHistoryService();

    testWidgets('SettingsPage should render the transaction history and logout button',
        (WidgetTester tester) async {
      // Simulate adding a purchase to the history
      final purchase = PurchaseHistory(
        id: '1',
        items: [],
        quantities: [],
        totalPrice: 100.0,
        dateTime: DateTime.now(),
      );
      await purchaseHistoryService.addPurchase(purchase);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => purchaseHistoryService,
            child: SettingsPage(),
          ),
        ),
      );

      expect(find.text('Transaction History'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
      expect(find.text('Total: \$100.00'), findsOneWidget);
    });

    testWidgets('SettingsPage should show a message when there is no history',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SettingsPage()));

      expect(find.text('No transactions recorded yet.'), findsOneWidget);
    });
  });
}
