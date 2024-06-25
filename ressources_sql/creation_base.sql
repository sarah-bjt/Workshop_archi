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
    pfl_classe CLASSES,
    pfl_statut STATUTS,
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
    rsc_type FICHIERS,
    crs_id INT,
    CONSTRAINT pk_ressource PRIMARY KEY (rsc_id),
    CONSTRAINT fk_ressource_cours FOREIGN KEY (crs_id) REFERENCES t_cours_crs(crs_id)
);

CREATE TABLE t_exercice_exo (
    exo_id INT AUTO_INCREMENT,
    exo_nom VARCHAR(80),
    exo_niveau INT,
    exo_tps_passe INT,
    exo_enonce VARCHAR(80),
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
