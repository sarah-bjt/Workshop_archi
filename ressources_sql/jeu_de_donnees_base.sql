INSERT INTO t_compte_cpt VALUES ('agathe@mail.fr', '666');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('JAN', 'Agathe', 21, 'IMAC1', 'ETUDIANT', CURDATE(),'agathe@mail.fr');

INSERT INTO t_compte_cpt VALUES ('sarah@mail.fr', 'bts');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('BEAUJAULT', 'Sarah', 21, 'IMAC1', 'ETUDIANT', CURDATE(),'sarah@mail.fr');

INSERT INTO t_compte_cpt VALUES ('lison@mail.fr', 'buck');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('FORTIN', 'Lison', 21, 'IMAC1', 'ETUDIANT', CURDATE(),'lison@mail.fr');

INSERT INTO t_compte_cpt VALUES ('cherrier@mail.fr', 'tartiflette');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('CHERRIER', 'Sylvain', NULL, NULL, 'PROFESSEUR', CURDATE(), 'cherrier@mail.fr');

INSERT INTO t_compte_cpt VALUES ('christian@mail.fr', 'miam');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('AANTON', 'Christian', '21', 'IMAC2', 'ETUDIANT', CURDATE(), 'christian@mail.fr');

INSERT INTO t_compte_cpt VALUES ('theo@mail.fr', 'noel');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('BONNOT', 'Theo', '23', 'IMAC3', 'ETUDIANT', CURDATE(), 'theo@mail.fr');

INSERT INTO t_compte_cpt VALUES ('sousada@mail.fr', 'garfield');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('BOUALAPHA', 'Sousada', '12', 'IMAC3', 'ETUDIANT', CURDATE(), 'sousada@mail.fr');


INSERT INTO t_cours_crs (crs_nom) VALUE ('PROGRAMATION WEB');
UPDATE t_cours_crs SET crs_semestre=1 WHERE crs_nom='PROGRAMATION WEB';

INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 1', '1', 'met en gras avec la balise <b>','1');
INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 2', '1', 'met en italique avec la balise <i>','1');

INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, exo_id) VALUES ('2', 'PAS CORRIGE', 'hyper facile', '2');
INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, exo_id) VALUES ('1', 'PAS CORRIGE', 'un poil plus compliqué', '3');
INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, rps_date, exo_id, cpt_identifiant) VALUES (63, 'PAS CORRIGE', 'super bien mais un peu long', CURDATE(), 3, 'sarah@mail.fr');


INSERT INTO t_cours_crs (crs_nom,crs_semestre) VALUE ('ARCHITECTURE ALGO','2');

INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 1', '1', 'Liste des profs qui dont le prénom est Pascale. Liste des prénoms. Liste des prénoms triés. Comment n’avoir qu’une seule fois chaque prénom ?','2');

INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, exo_id) VALUES ('13', 'PAS CORRIGE', '4');


INSERT INTO t_cours_crs (crs_nom, crs_semestre, crs_date_creation, crs_descriptif) VALUES ('MODELISATION 3D', 2, CURDATE(), 'utilisation de blender 3d');

INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 6', 3, 'Modeliser un animal de votre choix', 3);
INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 7', 1, 'Utiliser l outil sélectionner', 3);

INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, rps_date, exo_id, cpt_identifiant) VALUES (289, 'PAS CORRIGE', NULL, CURDATE(), 4, 'christian@mail.fr');


INSERT INTO t_cours_crs (crs_nom, crs_semestre, crs_date_creation, crs_descriptif) VALUES ('TRAITEMENT DU SIGNAL 2', 1, CURDATE(), 'suite des signaux de Fourriers');

INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 2', 4, 'Faire la démonstration du cours', 4);


INSERT INTO t_cours_crs (crs_nom, crs_semestre, crs_date_creation) VALUES ('SOUND DESIGN', 1, CURDATE());

INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 4', 6, 'Designer le hurlement d un dragon', 5);
INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 1', 2, 'Utiliser la programmation midi pour faire un rythme court', 5);

INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, rps_date, exo_id, cpt_identifiant) VALUES (853, 'VRAI', 'c etait du gateau', CURDATE(), 7, 'sousada@mail.fr');
INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, rps_date, exo_id, cpt_identifiant) VALUES (726, 'FAUX', 'je me suis bien amuse', CURDATE(), 8, 'theo@mail.fr');
INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, rps_date, exo_id, cpt_identifiant) VALUES (566, 'FAUX', NULL, CURDATE(), 8, 'sousada@mail.fr');


INSERT INTO t_education_educ VALUES ('agathe@mail.fr',1),('agathe@mail.fr',2),('sarah@mail.fr',1),('sarah@mail.fr',2),('lison@mail.fr',1),('lison@mail.fr',2);
INSERT INTO t_education_educ VALUES ('christian@mail.fr',3),('christian@mail.fr',4);
INSERT INTO t_education_educ VALUES ('sousada@mail.fr',5),('theo@mail.fr',5);