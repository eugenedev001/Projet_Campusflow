import 'package:campusflow_models/campusflow_models.dart';
import 'package:flutter/material.dart';

import 'donnees_exemple.dart';
import 'ecran_detail.dart';
import 'ecran_formulaire.dart';
import 'widgets/tache_tile.dart';

/// Seuil Material 3 de la classe « étendue » : liste + détail côte à côte.
const double seuilTablette = 840;

/// Écran Échéances : AppBar, ListView.builder de ListTile, bouton flottant.
/// (La NavigationBar est dans EcranPrincipal, partagée par les 3 onglets.)
class EcranEcheances extends StatefulWidget {
  const EcranEcheances({super.key});

  @override
  State<EcranEcheances> createState() => _EcranEcheancesState();
}

class _EcranEcheancesState extends State<EcranEcheances> {
  List<Task> _taches = tachesExemple();
  String? _idSelectionne; // tâche affichée à droite en mode tablette

  /// Remplace une tâche par sa nouvelle version.
  /// Immuable : on construit une NOUVELLE liste, on ne modifie pas l'ancienne.
  void _remplacer(Task nouvelle) {
    setState(() {
      _taches = [for (final t in _taches) t.id == nouvelle.id ? nouvelle : t];
    });
  }

  void _cocher(Task tache, bool faite) => _remplacer(tache.copyWith(terminee: faite));

  Future<void> _ouvrirFormulaire() async {
    final nouvelle = await Navigator.of(context).push<Task>(
      MaterialPageRoute(builder: (_) => const EcranFormulaire()),
    );
    if (nouvelle == null) return; // l'utilisateur a fait « retour »
    setState(() => _taches = [..._taches, nouvelle]);
  }

  void _ouvrirDetail(Task tache) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EcranDetail(tache: tache, onMarquerFait: _remplacer),
      ),
    );
  }

  Task? get _selection {
    for (final t in _taches) {
      if (t.id == _idSelectionne) return t;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Tri : la plus proche échéance en premier.
    final taches = [..._taches]..sort((a, b) => a.echeance.compareTo(b.echeance));

    return Scaffold(
      appBar: AppBar(title: const Text('Mes échéances')),
      floatingActionButton: FloatingActionButton(
        onPressed: _ouvrirFormulaire,
        tooltip: 'Nouvelle tâche',
        child: const Icon(Icons.add),
      ),
      // LayoutBuilder : on regarde la place donnée par le parent.
      body: LayoutBuilder(
        builder: (context, constraints) {
          final large = constraints.maxWidth >= seuilTablette;

          final liste = _ListeTaches(
            taches: taches,
            idSelectionne: large ? _idSelectionne : null,
            onTap: (t) {
              if (large) {
                setState(() => _idSelectionne = t.id);
              } else {
                _ouvrirDetail(t);
              }
            },
            onCocher: _cocher,
          );

          if (!large) return liste; // téléphone : la liste seule

          // Tablette : liste (2/5) et détail (3/5) côte à côte.
          final selection = _selection;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 2, child: liste),
              const VerticalDivider(width: 1),
              Expanded(
                flex: 3,
                child: selection == null
                    ? const _AucuneSelection()
                    : DetailTache(
                        tache: selection,
                        onMarquerFait: () => _cocher(selection, true),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ListeTaches extends StatelessWidget {
  const _ListeTaches({
    required this.taches,
    required this.idSelectionne,
    required this.onTap,
    required this.onCocher,
  });

  final List<Task> taches;
  final String? idSelectionne;
  final ValueChanged<Task> onTap;
  final void Function(Task, bool) onCocher;

  @override
  Widget build(BuildContext context) {
    if (taches.isEmpty) {
      return const Center(child: Text('Aucune tâche. Appuie sur + pour en ajouter une.'));
    }
    return ListView.builder(
      // marge du bas : le bouton flottant ne cache pas la dernière ligne
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      itemCount: taches.length,
      itemBuilder: (context, i) {
        final t = taches[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TacheTile(
            tache: t,
            selectionnee: t.id == idSelectionne,
            onTap: () => onTap(t),
            onCocher: (faite) => onCocher(t, faite),
          ),
        );
      },
    );
  }
}

class _AucuneSelection extends StatelessWidget {
  const _AucuneSelection();

  @override
  Widget build(BuildContext context) {
    final couleurs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.touch_app_outlined, size: 48, color: couleurs.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(
            'Sélectionne une tâche pour voir son détail',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: couleurs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
