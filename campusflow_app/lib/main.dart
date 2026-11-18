import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/accueil/ecran_titre.dart';

void main() => runApp(const CampusFlowApp());

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
