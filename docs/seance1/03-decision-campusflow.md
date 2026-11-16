# Séance 1 · TP 3 — Décision de plateforme pour CampusFlow

## Décision

CampusFlow cible les **étudiants de l'enseignement supérieur d'Afrique francophone**, à commencer par le Burkina Faso. Le persona type utilise un smartphone **Android** d'entrée ou de milieu de gamme, avec une connexion mobile chère et instable.

D'après StatCounter, Android représente environ 90 % de l'usage web mobile au Burkina Faso (juin 2026) et 81 % en Afrique (août 2026). La première version vise donc **Android en priorité**. **iOS** est prévu dès la conception, car sa part monte nettement dans d'autres pays de la région.

Nous retenons une approche **cross-platform avec Flutter**, pour quatre raisons :
- **Une seule base de code en Dart** couvre les deux plateformes. Une petite équipe étudiante ne pourrait pas maintenir deux applications natives en Kotlin et en Swift.
- **Développement et tests sur PC** Windows ou Linux pour Android. La version iOS sera compilée plus tard, sur un Mac, à partir du même code.
- **Rendu identique** sur tous les téléphones : le moteur Flutter dessine lui-même l'interface. C'est un vrai atout face à la forte fragmentation d'Android observée localement.
- **Code compilé en natif (AOT)**, donc des performances correctes même sur des appareils modestes.

L'autopsie de BlackBerry nous apprend qu'une plateforme se perd faute de suivre l'usage réel et l'écosystème. Nous partons donc des contraintes du terrain :
- application **légère** ;
- **consultation hors ligne** des échéances en cache ;
- **rappels par notifications planifiées**, pas par un service en arrière-plan que les surcouches tueraient ;
- interface **en français**, conforme à Material 3.

Nous acceptons en contrepartie un APK un peu plus lourd qu'en natif et une dépendance aux plugins pour les fonctions natives (notifications, stockage sécurisé).

## Résumé

| Question | Réponse |
|---|---|
| Cible | Étudiants d'Afrique francophone, d'abord au Burkina Faso |
| Plateformes | Android en priorité (≈ 90 % au BF), iOS en second |
| Approche | Cross-platform : Flutter (Dart), Material 3 |
| Compromis accepté | Taille de l'APK, dépendance aux plugins |
| Contraintes structurantes | Appareil modeste, données chères, hors ligne, français |
