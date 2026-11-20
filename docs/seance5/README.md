# Séance 5 — Widgets, layout, responsive

Le code se trouve dans `campusflow_app/lib/features/`. Les données viennent du package `campusflow_models` de la séance 3, branché en dépendance locale avec `flutter pub add campusflow_models --path ../campusflow_models`.

| TP | Écran | Fichier | Widgets demandés |
|---|---|---|---|
| 1 | Échéances | `taches/ecran_echeances.dart` + `accueil/ecran_principal.dart` | `Scaffold`, `AppBar`, `ListView.builder` de `ListTile` (dans `widgets/tache_tile.dart`), `FloatingActionButton`, `NavigationBar` |
| 2 | Détail | `taches/ecran_detail.dart` | `Column`, `Card`, `FilledButton` « Marquer comme fait » |
| 3 | Formulaire | `taches/ecran_formulaire.dart` | `Form`, `TextFormField` avec un `validator` qui refuse un titre vide, `SnackBar` de confirmation, `SingleChildScrollView` pour le clavier |
| 4 | Tablette | `taches/ecran_echeances.dart` | `LayoutBuilder` avec un seuil à 840 dp : la liste seule en dessous, `Row` avec `Expanded(flex: 2)` pour la liste et `Expanded(flex: 3)` pour le détail au-dessus |

## Choix et règle des contraintes

- **Immuabilité dès maintenant.** Cocher une tâche crée une copie (`copyWith`) et une nouvelle liste. C'est la préparation du `TachesNotifier` de la séance 6.
- **`RenderFlex overflowed`.** Dans une `Row`, un `Text` long déborde parce que la `Row` ne limite pas la largeur de ses enfants. Correction : l'envelopper dans un `Expanded` (voir `_Ligne` dans `ecran_detail.dart`), ou utiliser `maxLines` avec `overflow: TextOverflow.ellipsis` (voir `TacheTile`).
- **Hauteur non bornée.** Un `ListView` placé dans une `Column` n'a pas de hauteur maximale. Ici, la liste est directement le `body` du `Scaffold`, et en mode tablette elle est dans un `Expanded`.
- **Détail réutilisé.** Le contenu du détail (`DetailTache`) sert à la fois pour l'écran plein du téléphone et pour la colonne de droite de la tablette.
- **Aucune couleur en dur.** Le badge « En retard / Faite / Demain » lit ses couleurs dans le thème (`colorScheme` et `StatutColors`).

## Captures

| Fichier | Contenu |
|---|---|
| `echeances.png` | Liste des échéances (fenêtre étroite) |
| `detail.png` | Détail d'une tâche |
| `formulaire-erreur.png` | Formulaire avec le message « Le titre est obligatoire » |
| `tablette.png` | Fenêtre de plus de 840 dp : liste et détail côte à côte |
