# Séance 6 — Navigation et état (Riverpod, go_router)

## TP 1 — Dépendances

```bash
flutter pub add flutter_riverpod go_router
```
`main.dart` enveloppe l'application dans un `ProviderScope`.

## TP 2 — Routes (`lib/core/router/app_router.dart`)

| Adresse | Écran | Remarque |
|---|---|---|
| `/login` | Écran d'entrée | Adresse de départ. La connexion réelle arrive en séance 7. |
| `/taches` | Échéances | Dans le `ShellRoute` |
| `/cours` | Cours | Dans le `ShellRoute` |
| `/profil` | Profil | Dans le `ShellRoute` |
| `/taches/nouvelle` | Formulaire | Plein écran, au-dessus de la barre. Déclarée **avant** `:id`. |
| `/taches/:id` | Détail | `state.pathParameters['id']` |

- La `NavigationBar` est construite une seule fois, dans le `ShellRoute` (`EcranPrincipal`). L'onglet actif se déduit de l'adresse.
- Sur le web, chaque écran s'ouvre par son adresse : `http://localhost:8080/#/taches/2`.
- Si l'on arrive directement sur une adresse, sans rien à dépiler, le retour mène à `/taches` (`retourOuListe`).

## TP 3 — État partagé (`lib/features/taches/taches_provider.dart`)

- `TachesNotifier` contient **la** liste des tâches, avec `ajouter()` et `cocher()`.
- **État immuable :** on écrit `state = [...state, tache]`, jamais `state.add(tache)`. Cocher une tâche crée une copie avec `copyWith` dans une nouvelle liste.
- **`ref.watch` dans `build`** (liste, détail) et **`ref.read` dans les actions** (bouton « Marquer comme fait », case à cocher, « Enregistrer » du formulaire).
- **Preuve :** une tâche cochée dans le détail apparaît cochée dans la liste au retour, et une tâche ajoutée dans le formulaire apparaît tout de suite dans la liste. C'est vérifié par les tests.

## TP 4 — Filtres

- `filtreProvider` stocke le filtre choisi (À faire, Faites ou En retard).
- `tachesParFiltreProvider` est un **fournisseur dérivé**. Il ne stocke rien : il calcule les trois listes à partir de `tachesProvider`, et une tâche cochée change de liste toute seule.
- `tachesVisiblesProvider` renvoie la liste du filtre choisi. L'écran affiche trois `ChoiceChip` avec leur compteur (« En retard · 1 »).

## Tests

7 tests de widgets :
- `/login` mène à `/taches` ;
- accès direct à `/taches/:id` ;
- changement d'onglet par le `ShellRoute` ;
- tâche cochée, partagée entre le détail et la liste ;
- tâche ajoutée, partagée entre le formulaire et la liste ;
- les trois filtres ;
- la version tablette.
