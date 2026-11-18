import 'package:campusflow/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('fr_FR');
  });

  testWidgets('l\'écran de titre affiche le logo, le nom et utilise le thème', (tester) async {
    await tester.pumpWidget(const CampusFlowApp());

    expect(find.text('CampusFlow'), findsOneWidget);
    expect(find.text('Commencer'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    final context = tester.element(find.text('CampusFlow'));
    expect(Theme.of(context).colorScheme.primary, const Color(0xFF1D4ED8));
  });
}
