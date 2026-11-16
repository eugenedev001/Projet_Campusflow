# Séance 1 · TP 2 — Autopsie d'un système : BlackBerry OS

## Repères chronologiques

| Date | Événement |
|---|---|
| 1999 | RIM lance le BlackBerry : l'e-mail mobile pour les professionnels |
| Juin 2007 | Sortie de l'iPhone : multitouch, navigateur web complet |
| Juillet 2008 | Ouverture de l'App Store. Octobre 2008 : premier téléphone Android |
| Fin 2008 | BlackBerry Storm, premier BlackBerry tactile, mal reçu (écran « à presser ») |
| 2009 | Ouverture de BlackBerry App World, avec un catalogue limité |
| 2011 | Tablette PlayBook, sur un nouveau système (QNX) incompatible avec les téléphones |
| Janvier 2013 | BlackBerry 10, système entièrement tactile basé sur QNX |
| Septembre 2016 | BlackBerry arrête de fabriquer ses propres téléphones et devient une entreprise de logiciels |
| 4 janvier 2022 | Arrêt des services : BlackBerry 7.1 et BlackBerry 10 cessent de fonctionner de façon fiable |

## Trois causes, classées par poids

### Cause n° 1 (la plus lourde) — Rupture d'interface : le pari du clavier physique

Le BlackBerry s'est construit sur le clavier physique et l'e-mail. L'iPhone a imposé le **multitouch plein écran**, puis le téléphone comme ordinateur de poche (web, médias, jeux, applications). Lazaridis, cofondateur de RIM, était hostile aux écrans tactiles et restait fidèle à la clientèle entreprise. Une enquête du *Globe and Mail* (2013), reprise par *The Register*, le confirme.

Quand RIM a enfin répondu avec le Storm (2008), l'écran demandait d'appuyer fortement, à l'opposé de la fluidité de l'iPhone. Cette première réponse ratée a abîmé l'image de la marque auprès du grand public.

**Pourquoi en premier :** c'est la cause racine. RIM a mal lu ce que voulait le marché, et tout le reste en découle.

### Cause n° 2 — Stratégie et timing : une réponse trop tardive

La vraie réponse, BlackBerry 10, n'arrive qu'en janvier 2013, plus de cinq ans après l'iPhone. Selon *The Register* (2013, d'après le *Globe and Mail*), les observateurs du marché, et une bonne partie des cadres de RIM eux-mêmes, jugeaient ces produits arrivés **deux ans trop tard**. Entre-temps, RIM avait dispersé ses forces avec la tablette PlayBook. Celle-ci tournait sur un système incompatible avec les téléphones, et une analyse de *Digitopoly* (2015) y voit du temps perdu.

**Pourquoi en deuxième :** BB10 était techniquement solide. Sorti plus tôt, il aurait pu sauver la plateforme. Le retard a rendu l'erreur n° 1 irréversible.

### Cause n° 3 — Écosystème d'applications : l'effet de réseau inversé

App World n'ouvre qu'en 2009, avec un catalogue maigre face à l'App Store et à Google Play. En 2013, Android et iOS concentraient déjà presque tout le marché. Comme le résume un développeur, Jason Eckert : pourquoi développer pour BlackBerry 10 quand 90 % du marché est sur Android et iOS ? C'est l'effet de réseau vu en cours : peu d'utilisateurs, donc peu d'applications, donc encore moins d'utilisateurs.

**Pourquoi en troisième :** c'est une **conséquence** des deux premières causes plus qu'une cause indépendante. Mais c'est elle qui a porté le coup de grâce : même un bon système ne survit pas sans applications.

## Leçon pour CampusFlow

Un système ne meurt pas de sa technique, mais de son écosystème et de son timing. Pour nous, cela veut dire :
1. **Partir de l'usage réel** des étudiants (smartphone tactile Android, données chères), pas de nos habitudes ou préférences techniques.
2. **Ne pas parier sur une plateforme minoritaire** : on construit pour les deux survivants, Android et iOS.
3. **Sortir vite une première version utile**, puis l'améliorer, plutôt qu'attendre la version parfaite.

## Sources

- *The Register*, « BlackBerry ripped itself apart wooing CIOs AND iPhone fanbois – insiders », 30 sept. 2013 (reprend l'enquête du *Globe and Mail*) : https://www.theregister.co.uk/2013/09/30/blackberry_bosses_bickered_while_rim_burned/
- *Silicon UK*, « Classic BlackBerry Smartphones Discontinued Today », 4 janv. 2022 : https://www.silicon.co.uk/mobility/smartphones/classic-blackberry-smartphones-discontinued-435053
- *BGR*, « BlackBerry Is Ending Support For All Of Its Old Devices Today », 4 janv. 2022 : https://bgr.com/tech/blackberry-is-ending-support-for-all-of-its-old-devices-this-week-heres-the-full-list/
- *Digitopoly*, « Did the iPhone kill BlackBerry? », 23 mai 2015 : https://digitopoly.org/2015/05/23/did-the-iphone-kill-blackberry/
- J. Eckert, « Why BlackBerry failed » : https://jasoneckert.github.io/myblog/why-blackberry-failed
- Pour aller plus loin : J. McNish et S. Silcoff, *Losing the Signal: The Untold Story Behind the Extraordinary Rise and Spectacular Fall of BlackBerry*, 2015.
