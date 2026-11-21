import 'package:campusflow_models/campusflow_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'ecran_detail.dart';
import 'taches_provider.dart';
import 'widgets/tache_tile.dart';

/// Seuil Material 3 de la classe « étendue » : liste + détail côte à côte.
const double seuilTablette = 840;

/// Écran Échéances (/taches) : AppBar, ListView.builder, bouton flottant.
/// Les données viennent de l'état partagé (Riverpod).
class EcranEcheances extends ConsumerStatefulWidget {
  const EcranEcheances({super.key});

  @override
  ConsumerState<EcranEcheances> createState() => _EcranEcheancesState();
}

class _EcranEcheancesState extends ConsumerState<EcranEcheances> {
  // Seul état LOCAL restant : la tâche sélectionnée en mode tablette.
  // C'est un détail d'affichage, il n'a pas à être partagé.
  String? _idSelectionne;

  @override
  Widget build(BuildContext context) {
    // ref.watch dans build : on se reconstruit à chaque changement.
    final toutes = ref.watch(tachesProvider);
    // Tri : la plus proche échéance en premier (nouvelle liste, l'état n'est pas modifié).
    final taches = [...toutes]..sort((a, b) => a.echeance.compareTo(b.echeance));

    void cocher(Task t, bool faite) =>
        ref.read(tachesProvider.notifier).cocher(t.id, faite); // ref.read : action

    return Scaffold(
      appBar: AppBar(title: const Text('Mes échéances')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/taches/nouvelle'),
        tooltip: 'Nouvelle tâche',
        child: const Icon(Icons.add),
      ),
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
                context.push('/taches/${t.id}'); // adresse avec :id
              }
            },
            onCocher: cocher,
          );

          if (!large) return liste; // téléphone : la liste seule

          // Tablette : liste (2/5) et détail (3/5) côte à côte.
          final id = _idSelectionne;
          final selection = toutes.where((t) => t.id == id).firstOrNull;
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
                        onMarquerFait: () => cocher(selection, true),
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
