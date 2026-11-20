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

  testWidgets('le formulaire refuse un titre vide puis ajoute la tâche', (tester) async {
    await ouvrirEcheances(tester);

    await tester.tap(find.byTooltip('Nouvelle tâche'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Enregistrer'));
    await tester.pump();
    expect(find.text('Le titre est obligatoire'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'Mémoire');
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Mes échéances'), findsOneWidget);
    expect(find.text('Mémoire'), findsOneWidget);
  });

  testWidgets('le détail marque une tâche comme faite', (tester) async {
    await ouvrirEcheances(tester);

    await tester.tap(find.text('Rendu TP Dart'));
    await tester.pumpAndSettle();
    expect(find.text('Détail'), findsOneWidget);

    await tester.tap(find.text('Marquer comme fait'));
    await tester.pumpAndSettle();
    expect(find.text('Déjà faite'), findsOneWidget);
  });

  testWidgets('à 840 dp et plus, la liste et le détail sont côte à côte', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await ouvrirEcheances(tester);
    expect(find.text('Sélectionne une tâche pour voir son détail'), findsOneWidget);

    await tester.tap(find.text('Projet Spark'));
    await tester.pumpAndSettle();

    expect(find.text('Marquer comme fait'), findsOneWidget);
    expect(find.text('Détail'), findsNothing); // pas de nouvel écran : même page
  });
}
