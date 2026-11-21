import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Coquille du ShellRoute : la NavigationBar autour de l'onglet actif.
/// L'onglet sélectionné se déduit de l'adresse courante.
class EcranPrincipal extends StatelessWidget {
  const EcranPrincipal({super.key, required this.child});

  final Widget child; // l'écran de l'onglet actif, fourni par go_router

  static const _adresses = ['/taches', '/cours', '/profil'];

  int _ongletActif(String adresse) {
    if (adresse.startsWith('/cours')) return 1;
    if (adresse.startsWith('/profil')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final adresse = GoRouterState.of(context).uri.path;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _ongletActif(adresse),
        onDestinationSelected: (i) => context.go(_adresses[i]),
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
