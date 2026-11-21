import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/theme/app_theme.dart';
import 'features/accueil/ecran_titre.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR'); // noms des jours et des mois en français
  // ProviderScope : la racine qui stocke l'état de tous les providers.
  runApp(const ProviderScope(child: CampusFlowApp()));
}

class CampusFlowApp extends StatelessWidget {
  const CampusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.clair, // le thème centralisé
      home: const EcranTitre(),
    );
  }
}
