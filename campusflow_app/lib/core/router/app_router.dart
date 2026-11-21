import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/accueil/ecran_principal.dart';
import '../../features/accueil/ecran_titre.dart';
import '../../features/cours/ecran_cours.dart';
import '../../features/profil/ecran_profil.dart';
import '../../features/taches/ecran_detail.dart';
import '../../features/taches/ecran_echeances.dart';
import '../../features/taches/ecran_formulaire.dart';

/// Les adresses de CampusFlow :
///
/// | Adresse            | Écran                                   |
/// |--------------------|-----------------------------------------|
/// | /login             | écran d'entrée (connexion en séance 7)  |
/// | /taches            | liste des échéances  ┐                  |
/// | /cours             | liste des cours      ├ dans le ShellRoute |
/// | /profil            | profil               ┘ (NavigationBar)   |
/// | /taches/nouvelle   | formulaire (plein écran)                |
/// | /taches/:id        | détail d'une tâche (plein écran)        |
GoRouter creerRouteur({String initialLocation = '/login'}) {
  // Navigateur racine : le détail et le formulaire s'affichent par-dessus
  // la barre de navigation, comme dans les wireframes.
  final racine = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: racine,
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: '/', redirect: (context, state) => '/login'),
      GoRoute(path: '/login', builder: (context, state) => const EcranTitre()),
      ShellRoute(
        // La NavigationBar est construite une seule fois, autour de l'onglet actif.
        builder: (context, state, child) => EcranPrincipal(child: child),
        routes: [
          GoRoute(
            path: '/taches',
            builder: (context, state) => const EcranEcheances(),
            routes: [
              // « nouvelle » AVANT « :id », sinon « nouvelle » serait pris pour un id.
              GoRoute(
                path: 'nouvelle',
                parentNavigatorKey: racine,
                builder: (context, state) => const EcranFormulaire(),
              ),
              GoRoute(
                path: ':id',
                parentNavigatorKey: racine,
                // Lecture du paramètre d'adresse :id
                builder: (context, state) =>
                    EcranDetail(id: state.pathParameters['id'] ?? ''),
              ),
            ],
          ),
          GoRoute(path: '/cours', builder: (context, state) => const EcranCours()),
          GoRoute(path: '/profil', builder: (context, state) => const EcranProfil()),
        ],
      ),
    ],
  );
}

/// Le routeur est fourni par Riverpod : chaque ProviderScope (l'appli,
/// chaque test) a son propre routeur, qui repart de /login.
final routeurProvider = Provider<GoRouter>((ref) => creerRouteur());

/// Retour en arrière sûr : si on est arrivé directement par l'adresse
/// (rien à dépiler), on retourne à la liste.
void retourOuListe(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go('/taches');
  }
}
