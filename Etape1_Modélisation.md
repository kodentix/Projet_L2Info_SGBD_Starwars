**L2 Informatique**

---

---

## I. Introduction

### Contexte du projet

L'univers Star Wars est constitué de nombreux films et séries organisés en différents cycles et chronologies. On a donc chercher à proposer une modélisation de base de données permettant de représenter l'ensemble des productions de l'univers Star Wars ainsi que les personnages qui y apparaissent. 

- Avec la table **films**, on recense tous les films, leur **titre**, leur **durée**, leur **année** de sortie ainsi que le **cycle** dans lequel cela se déroule et la **chronologie** (année avant ou après la bataille de Yavin, notée BBY/ABY). Chaque film possède un identifiant unique (**film_id**).
- Avec la table **séries**, on recense toutes les séries, leur **titre**, la **durée** **moyenne** d’un épisode, leur **date de sortie** sur les plateformes de streaming, le **nombre de saisons** ainsi que le **cycle** dans lequel cela se déroule et la **chronologie** (année avant ou après la bataille de Yavin). Chaque série possède un identifiant unique (**serie_id**).
- Avec la table **personnages**, on recense tous les personnages qui gravitent dans l’écosystème Star Wars, leur **nom**, leur **espèce** (humain, droïde, etc…) et leur **camp**  dans le film (s’il se battent contre le mal comme les rebelles ou s’ils sont Sith par exemple). Chaque personnage possède un identifiant unique (**pers_id**)**.**

Et en liaison, les associations **joue_film** et **joue_serie** qui permettent de trouver dans quel film a joué quel personnage et inversement. Ils permettent aussi de pouvoir associer un **acteur** à un **personnage** en fonction du **film** ou de la **série** ainsi que l’**importance** du personnage dans la fiction.

**Précisions :**

- **BBY** = *Before the Battle of Yavin* → “Avant la bataille de Yavin”
- **ABY** = *After the Battle of Yavin* → “Après la bataille de Yavin”

---

### I.1 Exemple de données : Episode IV - Un Nouvel Espoir

**Table Films :**

| film_id | film_titre | film_duree | film_annee | cycle | chronologie |
| --- | --- | --- | --- | --- | --- |
| 1 | Un Nouvel Espoir | 121 | 1977 | Trilogie Originale | 0 ABY |

**Table Personnages :**

| pers_id | pers_nom | pers_espece | pers_camp |
| --- | --- | --- | --- |
| 101 | Luke Skywalker | Humain | Rebelle |
| 102 | Han Solo | Humain | Rebelle |
| 103 | Leia Organa | Humain | Rebelle |
| 104 | Dark Vador | Humain | Sith |

**Table Joue_film :**

| film_id | pers_id | importance | acteur |
| --- | --- | --- | --- |
| 1 | 101 | Principal | Mark Hamill |
| 1 | 102 | Principal | Harrison Ford |
| 1 | 103 | Principal | Carrie Fisher |
| 1 | 104 | Principal | David Prowse |

---

### I.2 Exemple : Personnage apparaissant dans films et séries

**Luke Skywalker (pers_id = 101) :**

Dans **Joue_film** :

- Episode IV (film_id = 1)
- Episode V (film_id = 2)
- Episode VI (film_id = 3)
- Episode VII (film_id = 7)
- Episode VIII (film_id = 8)
- Episode IX (film_id = 9)

Dans **Joue_serie** :

- Le livre de Boba Fett (serie_id = 2)
- The Mandalorian (serie_id = 1)

---

## II. Modèle Entité-Association

### II.1 Description des entités

Notre modèle repose sur **trois entités principales** :

### **Films**

Représente les films de l'univers Star Wars.

**Attributs :**

- `film_id` (clé primaire) : Identifiant unique du film (type : INT)
- `film_titre` : Titre du film (type : VARCHAR(200))
- `film_duree` : Durée du film en minutes (type : INT)
- `film_annee` : Année de sortie réelle du film (type : INT)
- `cycle` : Nom du cycle ou de l'ère (ex : "Trilogie Originale", "Prélogie") (type : VARCHAR(100))
- `chronologie` : Position chronologique dans l'univers Star Wars selon la timeline interne (ex : "0 ABY", "32 BBY") (type : VARCHAR(20))

**Justification :** La séparation des attributs `film_annee` (sortie réelle) et `chronologie` (timeline Star Wars) permet de distinguer la date de production de la position dans l'histoire de l'univers.

`chronologie` correspond donc à **la bataille de Yavin**, c’est-à-dire **la destruction de la première Étoile de la Mort** dans *Épisode IV – Un Nouvel Espoir*.

- **BBY** = *Before the Battle of Yavin* → “Avant la bataille de Yavin”
- **ABY** = *After the Battle of Yavin* → “Après la bataille de Yavin”

---

### **Series**

Représente les séries de l'univers Star Wars.

**Attributs :**

- `serie_id` (clé primaire) : Identifiant unique de la série (type : INT)
- `serie_nom` : Nom de la série (type : VARCHAR(200))
- `serie_duree` : Durée moyenne d'un épisode en minutes (type : INT)
- `serie_annee` : Année de première diffusion (type : INT)
- `serie_saison` : Nombre de saisons (type : INT)
- `cycle` : Nom du cycle ou de l'ère (type : VARCHAR(100))
- `chronologie` : Position chronologique dans l'univers Star Wars (type : VARCHAR(20))

**Justification :** Les séries possèdent des attributs spécifiques comme le nombre de saisons et la durée moyenne des épisodes ce qui entraine donc une entité différente des films.

`chronologie` correspond donc à **la bataille de Yavin**, c’est-à-dire **la destruction de la première Étoile de la Mort** dans *Épisode IV – Un Nouvel Espoir*.

- **BBY** = *Before the Battle of Yavin* → “Avant la bataille de Yavin”
- **ABY** = *After the Battle of Yavin* → “Après la bataille de Yavin”

---

### **Personnages**

Représente les personnages de l'univers Star Wars.

**Attributs :**

- `pers_id` (clé primaire) : Identifiant unique du personnage (type : INT)
- `pers_nom` : Nom complet du personnage (ex : "Luke Skywalker", "Dark Vador") (type : VARCHAR(100))
- `pers_espece` : Espèce du personnage (ex : "Humain",  "Droïde") (type : VARCHAR(50))
- `pers_camp` : Affiliation ou camp (ex : "Jedi", "Sith", "Rebelle") (type : VARCHAR(50))

**Justification :** Les personnages sont indépendants des productions dans lesquelles ils apparaissent. Un même personnage peut apparaître dans plusieurs films et/ou séries.

---

### II.2 Description des associations

Notre modèle comporte **deux associations de type n:m** :

### **Joue_film**

Associe les films aux personnages qui y apparaissent.

**Type :** Association n:m 

**Attributs dans l'association :**

- `importance` : Importance du rôle dans le film (type : VARCHAR(10) NOT NULL CHECK ( joue_film ('Principal', 'Secondaire', 'Mineur'))
- `acteur` : Nom de l'acteur qui interprète le personnage (type : VARCHAR(100))

**Justification :** Ces attributs dépendent du couple (film, personnage). Par exemple, Luke Skywalker est joué par Mark Hamill dans la trilogie originale et a un rôle principal dans ces films.

---

### **Joue_serie**

Associe les séries aux personnages qui y apparaissent.

**Type :** Association n:m

**Attributs dans l'association :**

- `importance` : Importance du rôle dans la série (type : VARCHAR(10) NOT NULL CHECK ( joue_serie ('Principal', 'Secondaire', 'Mineur'))
- `acteur` : Nom de l'acteur qui interprète le personnage (type : VARCHAR(100))

**Justification :** Structure similaire à Joue_film. La séparation en deux associations distinctes évite d'avoir des clés étrangères NULL.

---

### II.3 Justification des cardinalités

### **Films ↔ Joue_film ↔ Personnages**

**Films → Joue_film : (0,n)**

- Un film peut avoir **0 ou plusieurs** apparitions de personnages
- **Minimum 0** : Un film peut être enregistré dans la base sans que ses personnages soient encore saisis
- **Maximum n** : Un film contient généralement plusieurs personnages (exemple : " Episode IV : Un Nouvel Espoir" avec Luke, Dark Vador, etc.)

**Personnages → Joue_film : (1,n)**

- Un personnage doit apparaître dans **au moins un film** (minimum 1), sinon il n'a pas de raison d'être dans la base
- Un personnage peut apparaître dans **plusieurs films** (maximum n)
- Exemple : Luke Skywalker apparaît au moins dans les épisodes IV et V

---

### **Series ↔ Joue_serie ↔ Personnages**

**Series → Joue_serie : (0,n)**

- Une série peut avoir **0 ou plusieurs** apparitions de personnages
- **Minimum 0** : Une série peut être enregistrée sans que ses personnages soient encore saisis
- **Maximum n** : Une série contient généralement plusieurs personnages

**Personnages → Joue_serie : (0,n)**

- Un personnage peut apparaître dans **0 ou plusieurs** séries
- **Minimum 0** : Certains personnages n'apparaissent que dans les films (exemple : personnages exclusifs à la trilogie originale)
- **Maximum n** : Un personnage peut apparaître dans plusieurs séries (exemple : Ahsoka Tano dans "The Clone Wars" et "Ahsoka")

---

### II.4 Schéma Entité-Association

**Avec attributs :**

![Starwars EA avec attributs](Shémas/StarWars_E_A_avec_attributs.drawio.svg)

**Légende :**

- Rectangles = Entités
- Losanges = Associations
- Cercles = Attributs
- (x,y) = Cardinalités (minimum, maximum)

---

**Sans attributs :**

![Starwars EA avec attributs](Shémas/StarWars_E_A_avec_attributs.drawio.svg)

**Légende :**

- Rectangles = Entités
- Losanges = Associations
- (x,y) = Cardinalités (minimum, maximum)

---

---

---
