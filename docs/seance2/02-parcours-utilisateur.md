# Séance 2 · TP 2 — Parcours « suivre mes échéances »

Persona : **Fatimata** (voir `01-persona-job-stories.md`). Le parcours décrit sa situation **avant** CampusFlow, puis ce que l'application peut changer.

| Étape | 1. Planifier | 2. Consulter | 3. Ajouter | 4. Être rappelée | 5. Rendre |
|---|---|---|---|---|---|
| **Action** | Note les dates annoncées en cours dans un cahier ou dans ses notes de téléphone | Fait défiler le groupe WhatsApp, la plateforme de l'université et ses e-mails pour retrouver une date | Recopie à la main une consigne reçue sur WhatsApp | Compte sur sa mémoire ou sur un camarade qui relance dans le groupe | Dépose son travail sur la plateforme ou l'envoie par e-mail |
| **Friction** | Dates dans 3 à 4 endroits différents. Le cahier reste à la maison. | Trois applications à ouvrir, il faut du réseau, des centaines de messages à parcourir | Oublis, doublons, cours non précisé | Découvre l'échéance la veille. Aucun rappel fiable. | Stress de dernière minute, réseau saturé le soir du rendu, aucune trace de ce qui est rendu |
| **Émotion** | 😐 Confiante mais désorganisée | 😟 Perd du temps | 😐 Pénible | 😰 Panique | 😓 Soulagée mais épuisée |
| **Opportunité CampusFlow** | **Une seule liste** d'échéances, liée aux cours | Vue **« Cette semaine »** triée par date, **lisible hors ligne** | **Ajout en 3 appuis** : bouton +, titre, date | **Rappel planifié** avant l'échéance (notification locale) et filtre **« En retard »** | Bouton **« Marquer comme fait »** et filtre **« Faites »**, pour garder une trace de ce qui est rendu |

## Moment critique

L'étape 4 (**être rappelée**) est celle où l'émotion est la pire et où le coût d'un échec est le plus élevé : un rendu manqué. C'est la priorité de la conception :
- les échéances en retard sont **mises en évidence** (filtre dédié et badge de couleur) ;
- le rappel est proposé **directement dans le formulaire** de création, avec la valeur par défaut « 2 h avant ».

## Lien avec les écrans

| Étape | Écran (wireframe) | Route prévue (séance 6) |
|---|---|---|
| Planifier, Consulter | 2 · Échéances | `/taches` |
| Ajouter | 4 · Nouvelle tâche | `/taches/nouvelle` |
| Être rappelée | 4 · Nouvelle tâche (champ Rappel) et filtre « En retard » | `/taches` |
| Rendre | 3 · Détail | `/taches/:id` |
