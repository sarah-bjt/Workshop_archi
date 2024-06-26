CREATE TYPE CLASSES AS ENUM('IMAC1','IMAC2','IMAC3');
CREATE TYPE STATUTS AS ENUM('PROFESSEUR','ETUDIANT');
CREATE TYPE FICHIERS AS ENUM('IMAGE','PDF','VIDEO');

CREATE TABLE t_compte_cpt (
    cpt_identifiant VARCHAR(80),
    cpt_mdp CHAR(32),
    CONSTRAINT pk_compte PRIMARY KEY (cpt_identifiant)
);

CREATE TABLE t_profil_pfl (
    pfl_id INT AUTO_INCREMENT,
    pfl_nom VARCHAR(30),
    pfl_prenom VARCHAR(30),
    pfl_age INT,
    pfl_classe ENUM('IMAC1','IMAC2','IMAC3'),
    pfl_statut ENUM('PROFESSEUR','ETUDIANT'),
    pfl_date_creation DATE,
    cpt_identifiant VARCHAR(80),
    CONSTRAINT pk_profil PRIMARY KEY (pfl_id),
    CONSTRAINT fk_profil_compte FOREIGN KEY (cpt_identifiant) REFERENCES t_compte_cpt(cpt_identifiant)
);

CREATE TABLE t_cours_crs (
    crs_id INT AUTO_INCREMENT,
    crs_nom VARCHAR(80),
    crs_semestre INT,
    crs_date_creation DATE,
    crs_descriptif VARCHAR(300),
    CONSTRAINT pk_cours PRIMARY KEY (crs_id)
);

CREATE TABLE t_ressource_rsc (
    rsc_id INT AUTO_INCREMENT,
    rsc_nom VARCHAR(80),
    rsc_lien VARCHAR(80),
    rsc_type ENUM('IMAGE','PDF','VIDEO'),
    crs_id INT,
    CONSTRAINT pk_ressource PRIMARY KEY (rsc_id),
    CONSTRAINT fk_ressource_cours FOREIGN KEY (crs_id) REFERENCES t_cours_crs(crs_id)
);

CREATE TABLE t_exercice_exo (
    exo_id INT AUTO_INCREMENT,
    exo_nom VARCHAR(80),
    exo_niveau INT,
    exo_enonce VARCHAR(500),
    crs_id INT,
    CONSTRAINT pk_exercice PRIMARY KEY (exo_id),
    CONSTRAINT fk_exercice_cours FOREIGN KEY (crs_id) REFERENCES t_cours_crs(crs_id)
);

CREATE TABLE t_education_educ (
    cpt_identifiant VARCHAR(80),
    crs_id INT,
    CONSTRAINT pk_education PRIMARY KEY (cpt_identifiant,crs_id),
    CONSTRAINT fk_education_compte FOREIGN KEY (cpt_identifiant) REFERENCES t_compte_cpt(cpt_identifiant),
    CONSTRAINT fk_education_cours FOREIGN KEY (crs_id) REFERENCES t_cours_crs(crs_id)
);

CREATE TABLE t_reponse_rps (
    rps_id INT AUTO_INCREMENT,
    rps_tps_passe INT,
    rps_correction ENUM('PAS CORRIGE','VRAI','FAUX'),
    rps_commentaire VARCHAR(300),
    rps_date DATE,
    exo_id INT,
    cpt_identifiant VARCHAR(80),
    CONSTRAINT pk_reponse PRIMARY KEY (rps_id),
    CONSTRAINT fk_reponse_exercice FOREIGN KEY (exo_id) REFERENCES t_exercice_exo(exo_id),
    CONSTRAINT fk_reponse_compte FOREIGN KEY (cpt_identifiant) REFERENCES t_compte_cpt(cpt_identifiant)
);

ALTER TABLE t_reponse_rps ADD COLUMN cpt_identifiant VARCHAR(80);

ALTER TABLE t_reponse_rps
ADD CONSTRAINT fk_cpt_identifiant
FOREIGN KEY (cpt_identifiant)
REFERENCES t_compte_cp(cpt_identifiant);