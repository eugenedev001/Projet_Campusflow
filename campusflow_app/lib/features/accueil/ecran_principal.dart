import 'package:flutter/material.dart';

import '../cours/ecran_cours.dart';
import '../profil/ecran_profil.dart';
import '../taches/ecran_echeances.dart';

/// Coquille commune aux trois onglets, avec la NavigationBar.
/// En séance 6, elle deviendra le ShellRoute de go_router.
class EcranPrincipal extends StatefulWidget {
  const EcranPrincipal({super.key});

  @override
  State<EcranPrincipal> createState() => _EcranPrincipalState();
}

class _EcranPrincipalState extends State<EcranPrincipal> {
  int _onglet = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack garde l'état de chaque onglet quand on change d'onglet.
      body: IndexedStack(
        index: _onglet,
        children: const [EcranEcheances(), EcranCours(), EcranProfil()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _onglet,
        onDestinationSelected: (i) => setState(() => _onglet = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Échéances',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Cours',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
