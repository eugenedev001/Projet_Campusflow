import 'package:campusflow/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Lance l'application et passe l'écran de titre.
Future<void> ouvrirEcheances(WidgetTester tester) async {
  await tester.pumpWidget(const CampusFlowApp());
  await tester.tap(find.text('Commencer'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('fr_FR');
  });

  testWidgets('l\'écran de titre affiche le logo et mène aux échéances', (tester) async {
    await tester.pumpWidget(const CampusFlowApp());
    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();

    expect(find.text('Mes échéances'), findsOneWidget);
    expect(find.text('Rendu TP Dart'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
