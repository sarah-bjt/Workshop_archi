-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: pancakelearning
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_compte_cpt`
--

DROP TABLE IF EXISTS `t_compte_cpt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_compte_cpt` (
  `cpt_identifiant` varchar(80) NOT NULL,
  `cpt_mdp` char(32) DEFAULT NULL,
  PRIMARY KEY (`cpt_identifiant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_compte_cpt`
--

/*!40000 ALTER TABLE `t_compte_cpt` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_compte_cpt` ENABLE KEYS */;

--
-- Table structure for table `t_cours_crs`
--

DROP TABLE IF EXISTS `t_cours_crs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_cours_crs` (
  `crs_id` int NOT NULL AUTO_INCREMENT,
  `crs_nom` varchar(80) DEFAULT NULL,
  `crs_semestre` int DEFAULT NULL,
  `crs_date_creation` date DEFAULT NULL,
  `crs_descriptif` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`crs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_cours_crs`
--

/*!40000 ALTER TABLE `t_cours_crs` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_cours_crs` ENABLE KEYS */;

--
-- Table structure for table `t_education_educ`
--

DROP TABLE IF EXISTS `t_education_educ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_education_educ` (
  `cpt_identifiant` varchar(80) NOT NULL,
  `crs_id` int NOT NULL,
  PRIMARY KEY (`cpt_identifiant`,`crs_id`),
  KEY `fk_education_cours` (`crs_id`),
  CONSTRAINT `fk_education_compte` FOREIGN KEY (`cpt_identifiant`) REFERENCES `t_compte_cpt` (`cpt_identifiant`),
  CONSTRAINT `fk_education_cours` FOREIGN KEY (`crs_id`) REFERENCES `t_cours_crs` (`crs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_education_educ`
--

/*!40000 ALTER TABLE `t_education_educ` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_education_educ` ENABLE KEYS */;

--
-- Table structure for table `t_exercice_exo`
--

DROP TABLE IF EXISTS `t_exercice_exo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_exercice_exo` (
  `exo_id` int NOT NULL AUTO_INCREMENT,
  `exo_nom` varchar(80) DEFAULT NULL,
  `exo_niveau` int DEFAULT NULL,
  `exo_enonce` varchar(80) DEFAULT NULL,
  `crs_id` int DEFAULT NULL,
  PRIMARY KEY (`exo_id`),
  KEY `fk_exercice_cours` (`crs_id`),
  CONSTRAINT `fk_exercice_cours` FOREIGN KEY (`crs_id`) REFERENCES `t_cours_crs` (`crs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_exercice_exo`
--

/*!40000 ALTER TABLE `t_exercice_exo` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_exercice_exo` ENABLE KEYS */;

--
-- Table structure for table `t_profil_pfl`
--

DROP TABLE IF EXISTS `t_profil_pfl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_profil_pfl` (
  `pfl_id` int NOT NULL AUTO_INCREMENT,
  `pfl_nom` varchar(30) DEFAULT NULL,
  `pfl_prenom` varchar(30) DEFAULT NULL,
  `pfl_age` int DEFAULT NULL,
  `pfl_classe` enum('IMAC1','IMAC2','IMAC3') DEFAULT NULL,
  `pfl_statut` enum('PROFESSEUR','ETUDIANT') DEFAULT NULL,
  `pfl_date_creation` date DEFAULT NULL,
  `cpt_identifiant` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`pfl_id`),
  KEY `fk_profil_compte` (`cpt_identifiant`),
  CONSTRAINT `fk_profil_compte` FOREIGN KEY (`cpt_identifiant`) REFERENCES `t_compte_cpt` (`cpt_identifiant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_profil_pfl`
--

/*!40000 ALTER TABLE `t_profil_pfl` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_profil_pfl` ENABLE KEYS */;

--
-- Table structure for table `t_reponse_rps`
--

DROP TABLE IF EXISTS `t_reponse_rps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_reponse_rps` (
  `rps_id` int NOT NULL AUTO_INCREMENT,
  `rps_tps_passe` int DEFAULT NULL,
  `rps_correction` enum('PAS CORRIGE','VRAI','FAUX') DEFAULT NULL,
  `rps_commentaire` varchar(300) DEFAULT NULL,
  `rps_date` date DEFAULT NULL,
  `exo_id` int DEFAULT NULL,
  PRIMARY KEY (`rps_id`),
  KEY `fk_reponse_exercice` (`exo_id`),
  CONSTRAINT `fk_reponse_exercice` FOREIGN KEY (`exo_id`) REFERENCES `t_exercice_exo` (`exo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_reponse_rps`
--

/*!40000 ALTER TABLE `t_reponse_rps` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_reponse_rps` ENABLE KEYS */;

--
-- Table structure for table `t_ressource_rsc`
--

DROP TABLE IF EXISTS `t_ressource_rsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_ressource_rsc` (
  `rsc_id` int NOT NULL AUTO_INCREMENT,
  `rsc_nom` varchar(80) DEFAULT NULL,
  `rsc_lien` varchar(80) DEFAULT NULL,
  `rsc_type` enum('IMAGE','PDF','VIDEO') DEFAULT NULL,
  `crs_id` int DEFAULT NULL,
  PRIMARY KEY (`rsc_id`),
  KEY `fk_ressource_cours` (`crs_id`),
  CONSTRAINT `fk_ressource_cours` FOREIGN KEY (`crs_id`) REFERENCES `t_cours_crs` (`crs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ressource_rsc`
--

/*!40000 ALTER TABLE `t_ressource_rsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ressource_rsc` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-26 10:49:38
