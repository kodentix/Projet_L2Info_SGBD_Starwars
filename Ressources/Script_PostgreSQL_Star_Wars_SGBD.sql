-- ============================================
-- Projet base de données : Univers Star Wars
-- Groupe : G04
-- SGBD : PostgreSQL
-- ============================================

-- Suppression des tables si elles existent
DROP TABLE IF EXISTS G04_Joue_serie;
DROP TABLE IF EXISTS G04_Joue_film;
DROP TABLE IF EXISTS G04_Personnages;
DROP TABLE IF EXISTS G04_Series;
DROP TABLE IF EXISTS G04_Films;

-- ============================================
-- Création des tables
-- ============================================

-- Table Films
CREATE TABLE G04_Films (
    film_id SERIAL PRIMARY KEY,
    film_titre VARCHAR(200) NOT NULL,
    film_duree INT CHECK (film_duree > 0),
    film_annee INT NOT NULL CHECK (film_annee >= 1977),
    cycle VARCHAR(100),
    chronologie VARCHAR(20)
);

-- Table Series
CREATE TABLE G04_Series (
    serie_id SERIAL PRIMARY KEY,
    serie_nom VARCHAR(200) NOT NULL,
    serie_duree INT CHECK (serie_duree > 0),
    serie_annee INT NOT NULL CHECK (serie_annee >= 1977),
    serie_saison INT CHECK (serie_saison > 0),
    cycle VARCHAR(100),
    chronologie VARCHAR(20)
);

-- Table Personnages
CREATE TABLE G04_Personnages (
    pers_id SERIAL PRIMARY KEY,
    pers_nom VARCHAR(100) NOT NULL,
    pers_espece VARCHAR(50),
    pers_camp VARCHAR(50)
);

-- Table Joue_film (association n:m)
CREATE TABLE G04_Joue_film (
    film_id INT NOT NULL,
    pers_id INT NOT NULL,
    importance VARCHAR(10) NOT NULL CHECK (importance IN ('Principal', 'Secondaire')),
    acteur VARCHAR(100),
    PRIMARY KEY (film_id, pers_id),
    FOREIGN KEY (film_id) REFERENCES G04_Films(film_id),
    FOREIGN KEY (pers_id) REFERENCES G04_Personnages(pers_id)
);

-- Table Joue_serie (association n:m)
CREATE TABLE G04_Joue_serie (
    serie_id INT NOT NULL,
    pers_id INT NOT NULL,
    importance VARCHAR(10) NOT NULL CHECK (importance IN ('Principal', 'Secondaire')),
    acteur VARCHAR(100),
    PRIMARY KEY (serie_id, pers_id),
    FOREIGN KEY (serie_id) REFERENCES G04_Series(serie_id),
    FOREIGN KEY (pers_id) REFERENCES G04_Personnages(pers_id)
);

-- ============================================
-- Insertion des données
-- ============================================

-- Films
INSERT INTO G04_Films (film_titre, film_duree, film_annee, cycle, chronologie) VALUES
('La Menace fantôme', 136, 1999, 'Prélogie', '32 BBY'),
('L''Attaque des clones', 142, 2002, 'Prélogie', '22 BBY'),
('La Revanche des Sith', 140, 2005, 'Prélogie', '19 BBY'),
('Un Nouvel Espoir', 121, 1977, 'Trilogie Originale', '0 ABY'),
('L''Empire contre-attaque', 124, 1980, 'Trilogie Originale', '3 ABY'),
('Le Retour du Jedi', 131, 1983, 'Trilogie Originale', '4 ABY'),
('Le Réveil de la Force', 138, 2015, 'Postlogie', '34 ABY'),
('Les Derniers Jedi', 152, 2017, 'Postlogie', '34 ABY'),
('L''Ascension de Skywalker', 142, 2019, 'Postlogie', '35 ABY'),
('Rogue One', 133, 2016, 'Anthologie', '0 BBY'),
('Solo', 135, 2018, 'Anthologie', '10 BBY');

-- Series
INSERT INTO G04_Series (serie_nom, serie_duree, serie_annee, serie_saison, cycle, chronologie) VALUES
('The Clone Wars', 25, 2008, 7, 'Prélogie', '22-19 BBY'),
('Rebels', 22, 2014, 4, 'Âge de la Rébellion', '5-0 BBY'),
('The Mandalorian', 40, 2019, 3, 'Nouvelle République', '9 ABY'),
('Le livre de Boba Fett', 45, 2021, 1, 'Nouvelle République', '9 ABY'),
('Obi-Wan Kenobi', 50, 2022, 1, 'Règne de l''Empire', '9 BBY'),
('Andor', 45, 2022, 1, 'Âge de la Rébellion', '5 BBY'),
('Ahsoka', 45, 2023, 1, 'Nouvelle République', '9 ABY'),
('The Bad Batch', 25, 2021, 3, 'Règne de l''Empire', '19-18 BBY');

-- Personnages
INSERT INTO G04_Personnages (pers_nom, pers_espece, pers_camp) VALUES
('Luke Skywalker', 'Humain', 'Jedi'),
('Leia Organa', 'Humain', 'Rebelle'),
('Han Solo', 'Humain', 'Rebelle'),
('Dark Vador', 'Humain', 'Sith'),
('Obi-Wan Kenobi', 'Humain', 'Jedi'),
('Yoda', 'Yoda', 'Jedi'),
('Chewbacca', 'Wookiee', 'Rebelle'),
('C-3PO', 'Droïde', 'Neutre'),
('R2-D2', 'Droïde', 'Neutre'),
('Anakin Skywalker', 'Humain', 'Jedi'),
('Qui-Gon Jinn', 'Humain', 'Jedi'),
('Palpatine', 'Humain', 'Sith'),
('Rey', 'Humain', 'Jedi'),
('Finn', 'Humain', 'Résistance'),
('Kylo Ren', 'Humain', 'Premier Ordre'),
('Din Djarin', 'Humain', 'Mandalorien'),
('Grogu', 'Yoda', 'Neutre'),
('Ahsoka Tano', 'Togruta', 'Jedi'),
('Boba Fett', 'Humain', 'Chasseur de primes'),
('Cassian Andor', 'Humain', 'Rebelle');

-- ============================================
-- Apparitions dans les films
-- ============================================

-- Episode I : La Menace fantôme
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'La Menace fantôme'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Anakin Skywalker'),
    'Principal', 'Jake Lloyd'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'La Menace fantôme'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Qui-Gon Jinn'),
    'Principal', 'Liam Neeson'
);

-- Episode II : L'Attaque des clones
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'L''Attaque des clones'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Anakin Skywalker'),
    'Principal', 'Hayden Christensen'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'L''Attaque des clones'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Obi-Wan Kenobi'),
    'Principal', 'Ewan McGregor'
);

-- Episode III : La Revanche des Sith
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'La Revanche des Sith'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Anakin Skywalker'),
    'Principal', 'Hayden Christensen'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'La Revanche des Sith'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Obi-Wan Kenobi'),
    'Principal', 'Ewan McGregor'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'La Revanche des Sith'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Palpatine'),
    'Secondaire', 'Ian McDiarmid'
);
-- Episode IV : Un Nouvel Espoir
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Un Nouvel Espoir'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Luke Skywalker'),
    'Principal', 'Mark Hamill'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Un Nouvel Espoir'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Leia Organa'),
    'Principal', 'Carrie Fisher'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Un Nouvel Espoir'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Dark Vador'),
    'Secondaire', 'David Prowse'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Un Nouvel Espoir'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'C-3PO'),
    'Secondaire', 'Anthony Daniels'
);

-- Episode V : L'Empire contre-attaque
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'L''Empire contre-attaque'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Luke Skywalker'),
    'Principal', 'Mark Hamill'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'L''Empire contre-attaque'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Han Solo'),
    'Principal', 'Harrison Ford'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'L''Empire contre-attaque'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Yoda'),
    'Secondaire', 'Frank Oz'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'L''Empire contre-attaque'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'R2-D2'),
    'Secondaire', 'Kenny Baker'
);

-- Episode VI : Le Retour du Jedi
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Le Retour du Jedi'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Luke Skywalker'),
    'Principal', 'Mark Hamill'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Le Retour du Jedi'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Dark Vador'),
    'Secondaire', 'David Prowse'
);

-- Episode VII : Le Réveil de la Force
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Le Réveil de la Force'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Rey'),
    'Principal', 'Daisy Ridley'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Le Réveil de la Force'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Finn'),
    'Principal', 'John Boyega'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Le Réveil de la Force'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Kylo Ren'),
    'Secondaire', 'Adam Driver'
);

-- Episode VIII : Les Derniers Jedi
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Les Derniers Jedi'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Rey'),
    'Principal', 'Daisy Ridley'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Les Derniers Jedi'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Luke Skywalker'),
    'Secondaire', 'Mark Hamill'
);

-- Episode IX : L'Ascension de Skywalker
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'L''Ascension de Skywalker'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Rey'),
    'Principal', 'Daisy Ridley'
);

-- Rogue One
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Rogue One'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Dark Vador'),
    'Secondaire', 'Spencer Wilding'
);

-- Solo
INSERT INTO G04_Joue_film (film_id, pers_id, importance, acteur) VALUES
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Solo'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Han Solo'),
    'Principal', 'Alden Ehrenreich'
),
(
    (SELECT film_id FROM G04_Films WHERE film_titre = 'Solo'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Chewbacca'),
    'Principal', 'Joonas Suotamo'
);

-- ============================================
-- Apparitions dans les séries
-- ============================================

-- The Clone Wars
INSERT INTO G04_Joue_serie (serie_id, pers_id, importance, acteur) VALUES
(
    (SELECT serie_id FROM G04_Series WHERE serie_nom = 'The Clone Wars'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Ahsoka Tano'),
    'Principal', 'Ashley Eckstein (voix)'
);

-- Rebels
INSERT INTO G04_Joue_serie (serie_id, pers_id, importance, acteur) VALUES
(
    (SELECT serie_id FROM G04_Series WHERE serie_nom = 'Rebels'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Ahsoka Tano'),
    'Principal', 'Ashley Eckstein (voix)'
);

-- The Mandalorian
INSERT INTO G04_Joue_serie (serie_id, pers_id, importance, acteur) VALUES
(
    (SELECT serie_id FROM G04_Series WHERE serie_nom = 'The Mandalorian'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Din Djarin'),
    'Principal', 'Pedro Pascal'
),
(
    (SELECT serie_id FROM G04_Series WHERE serie_nom = 'The Mandalorian'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Grogu'),
    'Principal', 'Grogu (animatronique)'
);

-- Le livre de Boba Fett
INSERT INTO G04_Joue_serie (serie_id, pers_id, importance, acteur) VALUES
(
    (SELECT serie_id FROM G04_Series WHERE serie_nom = 'Le livre de Boba Fett'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Boba Fett'),
    'Principal', 'Temuera Morrison'
);

-- Obi-Wan Kenobi
INSERT INTO G04_Joue_serie (serie_id, pers_id, importance, acteur) VALUES
(
    (SELECT serie_id FROM G04_Series WHERE serie_nom = 'Obi-Wan Kenobi'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Obi-Wan Kenobi'),
    'Principal', 'Ewan McGregor'
);

-- Andor
INSERT INTO G04_Joue_serie (serie_id, pers_id, importance, acteur) VALUES
(
    (SELECT serie_id FROM G04_Series WHERE serie_nom = 'Andor'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Cassian Andor'),
    'Principal', 'Diego Luna'
);

-- Ahsoka
INSERT INTO G04_Joue_serie (serie_id, pers_id, importance, acteur) VALUES
(
    (SELECT serie_id FROM G04_Series WHERE serie_nom = 'Ahsoka'),
    (SELECT pers_id FROM G04_Personnages WHERE pers_nom = 'Ahsoka Tano'),
    'Principal', 'Rosario Dawson'
);



-- ============================================
-- Affichage des tables
-- ============================================

SELECT * FROM G04_Films;
SELECT * FROM G04_Series;
SELECT * FROM G04_Personnages;
SELECT * FROM G04_Joue_film;
SELECT * FROM G04_Joue_serie;

-- ============================================
-- Fin du script
-- ============================================
