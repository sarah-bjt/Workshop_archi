CREATE TYPE CLASSES AS ENUM('IMAC1','IMAC2','IMAC3');
CREATE TYPE STATUTS AS ENUM('PROFESSEUR','ETUDIANT');
CREATE TYPE FICHIERS AS ENUM('IMAGE','PDF','VIDEO');

CREATE TABLE t_compte_cpt (
    cpt_identifiant VARCHAR(80),
    cpt_mdp CHAR(32),
    CONSTRAINT pk_compte PRIMARY KEY (cpt_identifiant)
);

CREATE TABLE t_profil_pfl (
    pfl_id INT AUTO INCREMENT,
    pfl_nom VARCHAR(30),
    pfl_prenom VARCHAR(30),
    pfl_age INT,
    pfl_classe classes,
    CONSTRAINT pk_compte PRIMARY KEY (cpt_identifiant)
);