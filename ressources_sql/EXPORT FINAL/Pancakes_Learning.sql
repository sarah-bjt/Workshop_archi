/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.18-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: PANCAKE_L
-- ------------------------------------------------------
-- Server version	10.6.18-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_compte_cpt` (
  `cpt_identifiant` varchar(80) NOT NULL,
  `cpt_mdp` char(32) DEFAULT NULL,
  PRIMARY KEY (`cpt_identifiant`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_compte_cpt`
--

LOCK TABLES `t_compte_cpt` WRITE;
/*!40000 ALTER TABLE `t_compte_cpt` DISABLE KEYS */;
INSERT INTO `t_compte_cpt` VALUES ('agathe@mail.fr','666'),('cherrier@mail.fr','tartiflette'),('christian@mail.fr','miam'),('lison@mail.fr','buck'),('sarah@mail.fr','bts'),('sousada@mail.fr','garfield'),('theo@mail.fr','noel');
/*!40000 ALTER TABLE `t_compte_cpt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_cours_crs`
--

DROP TABLE IF EXISTS `t_cours_crs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_cours_crs` (
  `crs_id` int(11) NOT NULL AUTO_INCREMENT,
  `crs_nom` varchar(80) DEFAULT NULL,
  `crs_semestre` int(11) DEFAULT NULL,
  `crs_date_creation` date DEFAULT NULL,
  `crs_descriptif` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`crs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_cours_crs`
--

LOCK TABLES `t_cours_crs` WRITE;
/*!40000 ALTER TABLE `t_cours_crs` DISABLE KEYS */;
INSERT INTO `t_cours_crs` VALUES (1,'PROGRAMATION WEB',1,NULL,NULL),(2,'ARCHITECTURE ALGO',2,NULL,NULL),(3,'MODELISATION 3D',2,'2024-06-26','utilisation de blender 3d'),(4,'TRAITEMENT DU SIGNAL 2',1,'2024-06-26','suite des signaux de Fourriers'),(5,'SOUND DESIGN',1,'2024-06-26',NULL);
/*!40000 ALTER TABLE `t_cours_crs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_education_educ`
--

DROP TABLE IF EXISTS `t_education_educ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_education_educ` (
  `cpt_identifiant` varchar(80) NOT NULL,
  `crs_id` int(11) NOT NULL,
  PRIMARY KEY (`cpt_identifiant`,`crs_id`),
  KEY `fk_education_cours` (`crs_id`),
  CONSTRAINT `fk_education_compte` FOREIGN KEY (`cpt_identifiant`) REFERENCES `t_compte_cpt` (`cpt_identifiant`),
  CONSTRAINT `fk_education_cours` FOREIGN KEY (`crs_id`) REFERENCES `t_cours_crs` (`crs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_education_educ`
--

LOCK TABLES `t_education_educ` WRITE;
/*!40000 ALTER TABLE `t_education_educ` DISABLE KEYS */;
INSERT INTO `t_education_educ` VALUES ('agathe@mail.fr',1),('agathe@mail.fr',2),('christian@mail.fr',3),('christian@mail.fr',4),('lison@mail.fr',1),('lison@mail.fr',2),('sarah@mail.fr',1),('sarah@mail.fr',2),('sousada@mail.fr',5),('theo@mail.fr',5);
/*!40000 ALTER TABLE `t_education_educ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_exercice_exo`
--

DROP TABLE IF EXISTS `t_exercice_exo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_exercice_exo` (
  `exo_id` int(11) NOT NULL AUTO_INCREMENT,
  `exo_nom` varchar(80) DEFAULT NULL,
  `exo_niveau` int(11) DEFAULT NULL,
  `exo_enonce` varchar(500) DEFAULT NULL,
  `crs_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`exo_id`),
  KEY `fk_exercice_cours` (`crs_id`),
  CONSTRAINT `fk_exercice_cours` FOREIGN KEY (`crs_id`) REFERENCES `t_cours_crs` (`crs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_exercice_exo`
--

LOCK TABLES `t_exercice_exo` WRITE;
/*!40000 ALTER TABLE `t_exercice_exo` DISABLE KEYS */;
INSERT INTO `t_exercice_exo` VALUES (1,'EXO 1',1,'met en gras avec la balise <b>',1),(2,'EXO 2',1,'met en italique avec la balise <i>',1),(3,'EXO 1',1,'Liste des profs qui dont le prénom est Pascale. Liste des prénoms. Liste des prénoms triés. Comment n’avoir qu’une seule fois chaque prénom ?',2),(4,'EXO 6',3,'Modeliser un animal de votre choix',3),(5,'EXO 7',1,'Utiliser l outil sélectionner',3),(6,'EXO 2',4,'Faire la démonstration du cours',4),(7,'EXO 4',6,'Designer le hurlement d un dragon',5),(8,'EXO 1',2,'Utiliser la programmation midi pour faire un rythme court',5);
/*!40000 ALTER TABLE `t_exercice_exo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_profil_pfl`
--

DROP TABLE IF EXISTS `t_profil_pfl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_profil_pfl` (
  `pfl_id` int(11) NOT NULL AUTO_INCREMENT,
  `pfl_nom` varchar(30) DEFAULT NULL,
  `pfl_prenom` varchar(30) DEFAULT NULL,
  `pfl_age` int(11) DEFAULT NULL,
  `pfl_classe` enum('IMAC1','IMAC2','IMAC3') DEFAULT NULL,
  `pfl_statut` enum('PROFESSEUR','ETUDIANT') DEFAULT NULL,
  `pfl_date_creation` date DEFAULT NULL,
  `cpt_identifiant` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`pfl_id`),
  KEY `fk_profil_compte` (`cpt_identifiant`),
  CONSTRAINT `fk_profil_compte` FOREIGN KEY (`cpt_identifiant`) REFERENCES `t_compte_cpt` (`cpt_identifiant`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_profil_pfl`
--

LOCK TABLES `t_profil_pfl` WRITE;
/*!40000 ALTER TABLE `t_profil_pfl` DISABLE KEYS */;
INSERT INTO `t_profil_pfl` VALUES (1,'JAN','Agathe',21,'IMAC1','ETUDIANT','2024-06-26','agathe@mail.fr'),(2,'BEAUJAULT','Sarah',21,'IMAC1','ETUDIANT','2024-06-26','sarah@mail.fr'),(3,'FORTIN','Lison',21,'IMAC1','ETUDIANT','2024-06-26','lison@mail.fr'),(4,'CHERRIER','Sylvain',NULL,NULL,'PROFESSEUR','2024-06-26','cherrier@mail.fr'),(5,'AANTON','Christian',21,'IMAC2','ETUDIANT','2024-06-26','christian@mail.fr'),(6,'BONNOT','Theo',23,'IMAC3','ETUDIANT','2024-06-26','theo@mail.fr'),(7,'BOUALAPHA','Sousada',12,'IMAC3','ETUDIANT','2024-06-26','sousada@mail.fr');
/*!40000 ALTER TABLE `t_profil_pfl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_reponse_rps`
--

DROP TABLE IF EXISTS `t_reponse_rps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_reponse_rps` (
  `rps_id` int(11) NOT NULL AUTO_INCREMENT,
  `rps_tps_passe` int(11) DEFAULT NULL,
  `rps_correction` enum('PAS CORRIGE','VRAI','FAUX') DEFAULT NULL,
  `rps_commentaire` varchar(300) DEFAULT NULL,
  `rps_date` date DEFAULT NULL,
  `exo_id` int(11) DEFAULT NULL,
  `cpt_identifiant` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`rps_id`),
  KEY `fk_reponse_exercice` (`exo_id`),
  KEY `fk_reponse_compte` (`cpt_identifiant`),
  CONSTRAINT `fk_reponse_compte` FOREIGN KEY (`cpt_identifiant`) REFERENCES `t_compte_cpt` (`cpt_identifiant`),
  CONSTRAINT `fk_reponse_exercice` FOREIGN KEY (`exo_id`) REFERENCES `t_exercice_exo` (`exo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_reponse_rps`
--

LOCK TABLES `t_reponse_rps` WRITE;
/*!40000 ALTER TABLE `t_reponse_rps` DISABLE KEYS */;
INSERT INTO `t_reponse_rps` VALUES (4,2,'PAS CORRIGE','hyper facile','2024-06-26',1,'agathe@mail.fr'),(5,1,'PAS CORRIGE','un poil plus compliqué','2024-06-26',2,'agathe@mail.fr'),(7,13,'PAS CORRIGE',NULL,'2024-06-26',3,'lison@mail.fr'),(8,63,'VRAI','super bien mais un peu long','2024-06-26',3,'sarah@mail.fr'),(9,289,'PAS CORRIGE',NULL,'2024-06-26',4,'christian@mail.fr'),(10,853,'VRAI','c etait du gateau','2024-06-26',7,'sousada@mail.fr'),(11,726,'FAUX','je me suis bien amuse','2024-06-26',8,'theo@mail.fr'),(12,566,'FAUX',NULL,'2024-06-26',8,'sousada@mail.fr'),(13,20,'PAS CORRIGE','bibip bop bop','2024-06-27',8,'sousada@mail.fr'),(14,1,'PAS CORRIGE','simple','2024-06-27',2,'lison@mail.fr'),(15,78,'PAS CORRIGE','j\'ai fini l\'exercice','2024-06-27',3,'lison@mail.fr'),(16,1,'PAS CORRIGE','youpi','2024-06-27',1,'lison@mail.fr'),(17,2,'PAS CORRIGE','juste un essai','2024-06-27',2,'lison@mail.fr'),(18,6,'PAS CORRIGE','genial','2024-06-27',1,'sarah@mail.fr'),(19,100,'PAS CORRIGE','un peu long','2024-06-27',1,'sarah@mail.fr');
/*!40000 ALTER TABLE `t_reponse_rps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ressource_rsc`
--

DROP TABLE IF EXISTS `t_ressource_rsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ressource_rsc` (
  `rsc_id` int(11) NOT NULL AUTO_INCREMENT,
  `rsc_nom` varchar(80) DEFAULT NULL,
  `rsc_lien` varchar(80) DEFAULT NULL,
  `rsc_type` enum('IMAGE','PDF','VIDEO') DEFAULT NULL,
  `crs_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`rsc_id`),
  KEY `fk_ressource_cours` (`crs_id`),
  CONSTRAINT `fk_ressource_cours` FOREIGN KEY (`crs_id`) REFERENCES `t_cours_crs` (`crs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ressource_rsc`
--

LOCK TABLES `t_ressource_rsc` WRITE;
/*!40000 ALTER TABLE `t_ressource_rsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ressource_rsc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-28  9:44:56
