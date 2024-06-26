INSERT INTO t_compte_cpt VALUES ('agathe@mail.fr', '666');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('JAN', 'Agathe', 21, 'IMAC1', 'ETUDIANT', CURDATE(),'agathe@mail.fr');

INSERT INTO t_compte_cpt VALUES ('sarah@mail.fr', 'bts');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('BEAUJAULT', 'Sarah', 21, 'IMAC1', 'ETUDIANT', CURDATE(),'sarah@mail.fr');

INSERT INTO t_compte_cpt VALUES ('lison@mail.fr', 'buck');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('FORTIN', 'Lison', 21, 'IMAC1', 'ETUDIANT', CURDATE(),'lison@mail.fr');

INSERT INTO t_compte_cpt VALUES ('cherrier@mail.fr', 'tartiflette');
INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_age, pfl_classe, pfl_statut, pfl_date_creation, cpt_identifiant) VALUES ('CHERRIER', 'Sylvain', NULL, NULL, 'PROFESSEUR', CURDATE(), 'cherrier@mail.fr');

INSERT INTO t_cours_crs (crs_nom) VALUE ('PROGRAMATION WEB');
UPDATE t_cours_crs SET crs_semestre=1 WHERE crs_nom='PROGRAMATION WEB';

INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 1', '1', 'met en gras avec la balise <b>','1');
INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 2', '1', 'met en italique avec la balise <i>','1');

INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, exo_id) VALUES ('2', 'PAS CORRIGE', 'hyper facile', '2');
INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, exo_id) VALUES ('1', 'PAS CORRIGE', 'un poil plus compliqué', '3');

INSERT INTO t_cours_crs (crs_nom,crs_semestre) VALUE ('ARCHITECTURE ALGO','2');
INSERT INTO t_exercice_exo (exo_nom, exo_niveau, exo_enonce, crs_id) VALUES ('EXO 1', '1', 'Liste des profs qui dont le prénom est Pascale. Liste des prénoms. Liste des prénoms triés. Comment n’avoir qu’une seule fois chaque prénom ?','2');
INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, exo_id) VALUES ('13', 'PAS CORRIGE', '4');
