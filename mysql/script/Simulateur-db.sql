-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : db
-- Généré le : sam. 27 fév. 2021 à 14:52
-- Version du serveur :  8.0.22
-- Version de PHP : 7.4.14

CREATE DATABASE `Simulateur-db`;

USE `Simulateur-db`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `Simulateur-db`
--

-- --------------------------------------------------------

--
-- Structure de la table `Sensor`
--

CREATE TABLE `Sensor` (
  `idSensor` int NOT NULL,
  `statusSensor` int NOT NULL,
  `coordX` int NOT NULL,
  `coordY` int NOT NULL,
  `intensity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Sensor`
--

INSERT INTO `Sensor` (`idSensor`, `statusSensor`, `coordX`, `coordY`, `intensity`) VALUES
(0, 2, 0, 0, 0),
(1, 2, 0, 1, 0),
(2, 2, 0, 2, 0),
(3, 2, 0, 3, 0),
(4, 2, 0, 4, 0),
(5, 2, 0, 5, 0),
(10, 2, 1, 0, 0),
(11, 2, 1, 1, 0),
(12, 2, 1, 2, 0),
(13, 2, 1, 3, 0),
(14, 2, 1, 4, 0),
(15, 2, 1, 5, 0),
(20, 2, 2, 0, 0),
(21, 2, 2, 1, 0),
(22, 2, 2, 2, 0),
(23, 2, 2, 3, 0),
(24, 2, 2, 4, 0),
(25, 2, 2, 5, 0),
(30, 2, 3, 0, 0),
(31, 2, 3, 1, 0),
(32, 2, 3, 2, 0),
(33, 2, 3, 3, 0),
(34, 2, 3, 4, 0),
(35, 2, 3, 5, 0),
(40, 2, 4, 0, 0),
(41, 2, 4, 1, 0),
(42, 2, 4, 2, 0),
(43, 2, 4, 3, 0),
(44, 2, 4, 4, 0),
(45, 2, 4, 5, 0),
(50, 2, 5, 0, 0),
(51, 2, 5, 1, 0),
(52, 2, 5, 2, 0),
(53, 2, 5, 3, 0),
(54, 2, 5, 4, 0),
(55, 2, 5, 5, 0),
(60, 2, 6, 0, 0),
(61, 2, 6, 1, 0),
(62, 2, 6, 2, 0),
(63, 2, 6, 3, 0),
(64, 2, 6, 4, 0),
(65, 2, 6, 5, 0),
(70, 2, 7, 0, 0),
(71, 2, 7, 1, 0),
(72, 2, 7, 2, 0),
(73, 2, 7, 3, 0),
(74, 2, 7, 4, 0),
(75, 2, 7, 5, 0),
(80, 2, 8, 0, 0),
(81, 2, 8, 1, 0),
(82, 2, 8, 2, 0),
(83, 2, 8, 3, 0),
(84, 2, 8, 4, 0),
(85, 2, 8, 5, 0),
(90, 2, 9, 0, 0),
(91, 2, 9, 1, 0),
(92, 2, 9, 2, 0),
(93, 2, 9, 3, 0),
(94, 2, 9, 4, 0),
(95, 2, 9, 5, 0);

-- --------------------------------------------------------

--
-- Structure de la table `Status`
--

CREATE TABLE `Status` (
  `idStatus` int NOT NULL,
  `nameStatus` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Status`
--

INSERT INTO `Status` (`idStatus`, `nameStatus`) VALUES
(1, 'INPROGRESS'),
(2, 'NOALERT');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Sensor`
--
ALTER TABLE `Sensor`
  ADD PRIMARY KEY (`idSensor`),
  ADD KEY `FireAtAStatus` (`statusSensor`);

--
-- Index pour la table `Status`
--
ALTER TABLE `Status`
  ADD PRIMARY KEY (`idStatus`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Sensor`
--
ALTER TABLE `Sensor`
  ADD CONSTRAINT `FireAtAStatus` FOREIGN KEY (`statusSensor`) REFERENCES `Status` (`idStatus`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
