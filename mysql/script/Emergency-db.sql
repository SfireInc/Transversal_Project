-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : db
-- Généré le : sam. 27 fév. 2021 à 14:52
-- Version du serveur :  8.0.22
-- Version de PHP : 7.4.14

CREATE DATABASE `Emergency-db`;

USE `Emergency-db`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `Emergency-db`
--

-- --------------------------------------------------------

--
-- Structure de la table `Fire`
--

CREATE TABLE `Fire` (
  `idFire` int NOT NULL,
  `coordX` int NOT NULL,
  `coordY` int NOT NULL,
  `intensity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Fireman`
--

CREATE TABLE `Fireman` (
  `idFireman` varchar(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  `surname` varchar(20) NOT NULL,
  `idTruck` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Fireman`
--

INSERT INTO `Fireman` (`idFireman`, `name`, `surname`, `idTruck`) VALUES
('antgon', 'Anthony', 'Gonnet', 582),
('antpou', 'Antonin', 'Poulard', 252),
('bearol', 'Béatrice', 'Rollet', 252),
('chagau', 'Charlotte', 'Gauthier', 581),
('flacha', 'Flavian', 'Chapuis', 251),
('lormer', 'Loris', 'Mercier', 581),
('maxris', 'Maxime', 'Riss', 251),
('rapfou', 'Raphaël', 'Fourel', 252),
('thenot', 'Théo', 'Notin', 581),
('thobea', 'Thomas', 'Beaumont', 582),
('thooud', 'Thomas', 'Oudard', 251);

-- --------------------------------------------------------

--
-- Structure de la table `FireStation`
--

CREATE TABLE `FireStation` (
  `idFireStation` int NOT NULL,
  `nameFireStation` varchar(11) NOT NULL,
  `coordX` int NOT NULL,
  `coordY` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `FireStation`
--

INSERT INTO `FireStation` (`idFireStation`, `nameFireStation`, `coordX`, `coordY`) VALUES
(25, 'Charpennes', 2, 5),
(58, 'Gratte Ciel', 5, 8);

-- --------------------------------------------------------

--
-- Structure de la table `Statement`
--

CREATE TABLE `Statement` (
  `idStatement` int NOT NULL,
  `nameStatement` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Statement`
--

INSERT INTO `Statement` (`idStatement`, `nameStatement`) VALUES
(1, 'ATHOME'),
(2, 'INOPERATION');

-- --------------------------------------------------------

--
-- Structure de la table `Truck`
--

CREATE TABLE `Truck` (
  `idTruck` int NOT NULL,
  `idFireStation` int NOT NULL,
  `idFire` int DEFAULT NULL,
  `statement` int NOT NULL,
  `coordX` int NOT NULL,
  `coordY` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Truck`
--

INSERT INTO `Truck` (`idTruck`, `idFireStation`, `idFire`, `statement`, `coordX`, `coordY`) VALUES
(251, 25, NULL, 1, 2, 5),
(252, 25, NULL, 1, 2, 5),
(581, 58, NULL, 1, 5, 8),
(582, 58, NULL, 1, 5, 8);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Fire`
--
ALTER TABLE `Fire`
  ADD PRIMARY KEY (`idFire`);

--
-- Index pour la table `Fireman`
--
ALTER TABLE `Fireman`
  ADD PRIMARY KEY (`idFireman`),
  ADD KEY `FiremanBelongsToATruck` (`idTruck`);

--
-- Index pour la table `FireStation`
--
ALTER TABLE `FireStation`
  ADD PRIMARY KEY (`idFireStation`);

--
-- Index pour la table `Statement`
--
ALTER TABLE `Statement`
  ADD PRIMARY KEY (`idStatement`);

--
-- Index pour la table `Truck`
--
ALTER TABLE `Truck`
  ADD PRIMARY KEY (`idTruck`),
  ADD KEY `TruckBelongsToAFireStation` (`idFireStation`),
  ADD KEY `TruckIsAffectedToAFire` (`idFire`),
  ADD KEY `TruckAsAStatement` (`statement`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Fireman`
--
ALTER TABLE `Fireman`
  ADD CONSTRAINT `FiremanBelongsToATruck` FOREIGN KEY (`idTruck`) REFERENCES `Truck` (`idTruck`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `Truck`
--
ALTER TABLE `Truck`
  ADD CONSTRAINT `TruckAsAStatement` FOREIGN KEY (`statement`) REFERENCES `Statement` (`idStatement`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `TruckBelongsToAFireStation` FOREIGN KEY (`idFireStation`) REFERENCES `FireStation` (`idFireStation`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `TruckIsAffectedToAFire` FOREIGN KEY (`idFire`) REFERENCES `Fire` (`idFire`) ON DELETE SET NULL ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
