import 'package:campusflow/core/router/app_router.dart';
import 'package:campusflow/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Lance l'application (avec son ProviderScope) et passe l'écran d'entrée.
Future<void> ouvrirEcheances(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: CampusFlowApp()));
  await tester.tap(find.text('Commencer'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('fr_FR');
  });

  testWidgets('l\'écran d\'entrée (/login) mène aux échéances (/taches)', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CampusFlowApp()));
    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();

    expect(find.text('Mes échéances'), findsOneWidget);
    expect(find.text('Rendu TP Dart'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('chaque écran est atteignable par son adresse : /taches/:id', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [routeurProvider.overrideWithValue(creerRouteur(initialLocation: '/taches/2'))],
      child: const CampusFlowApp(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Détail'), findsOneWidget);
    expect(find.text('Exposé hallucinations des LLM'), findsOneWidget);
  });

  testWidgets('la NavigationBar du ShellRoute change d\'onglet', (tester) async {
    await ouvrirEcheances(tester);

    await tester.tap(find.text('Cours'));
    await tester.pumpAndSettle();
    expect(find.text('Mes cours'), findsOneWidget);
    expect(find.text('Programmation mobile'), findsOneWidget);
  });

  testWidgets('le formulaire (/taches/nouvelle) ajoute une tâche à la liste',
      (tester) async {
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

  testWidgets('à 840 dp et plus, la liste et le détail sont côte à côte', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await ouvrirEcheances(tester);
    expect(find.text('Sélectionne une tâche pour voir son détail'), findsOneWidget);

    await tester.tap(find.text('Rendu TP Dart'));
    await tester.pumpAndSettle();

    expect(find.text('Marquer comme fait'), findsOneWidget);
    expect(find.text('Détail'), findsNothing); // même page, pas de nouvel écran
  });
}
