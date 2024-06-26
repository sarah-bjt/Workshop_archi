import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Jejxav-mahrag-0kivko",
    database="PancakeLearning"
)
mycursor = mydb.cursor()

def compte_par_id(email):
    mycursor.execute("SELECT * FROM t_compte_cpt WHERE cpt_identifiant=%(id)s;", {'id': email})
    return mycursor.fetchone()

def profil_par_id(user_id):
    mycursor.execute("SELECT * FROM t_profil_pfl WHERE cpt_identifiant=%(id)s;", {'id': user_id})
    return mycursor.fetchone()

def modifier_profil(user_id, nom, prenom, age, classe):
    mycursor.execute("UPDATE t_profil_pfl SET pfl_nom=%(nnom)s, pfl_prenom=%(nprenom)s, pfl_age=%(nage)s, pfl_classe=%(nclasse)s WHERE cpt_identifiant=%(id)s;", {'nnom': nom, 'nprenom': prenom, 'nage': age, 'nclasse': classe, 'id': user_id})
    mydb.commit()

def supprimer_profil(user_id):
    mycursor.execute("DELETE FROM t_profil_pfl WHERE cpt_identifiant=%(id)s;", {'id': user_id})
    mydb.commit()
    mycursor.execute("DELETE FROM t_compte_cpt WHERE cpt_identifiant=%(id)s;", {'id': user_id})
    mydb.commit()

def recuperation_etudiants():
    mycursor.execute("SELECT * FROM t_profil_pfl WHERE pfl_statut='ETUDIANT';")
    return mycursor.fetchall()

def recapitulatif_cours_temps(user_id):
    mycursor.execute("SELECT crs_nom, crs_semestre, SUM(rps_tps_passe) FROM t_reponse_rps AS RPS JOIN t_exercice_exo AS EXO ON RPS.exo_id=EXO.exo_id JOIN t_cours_crs AS CRS ON EXO.crs_id=CRS.crs_id JOIN t_education_educ AS EDUC ON CRS.crs_id=EDUC.crs_id JOIN t_compte_cpt AS CPT ON EDUC.cpt_identifiant=CPT.cpt_identifiant JOIN  t_profil_pfl AS PLF ON CPT.cpt_identifiant=PLF.cpt_identifiant WHERE CPT.cpt_identifiant=%(id)s GROUP BY CRS.crs_id ;", {'id': user_id})
    return mycursor.fetchall()

def temps_total(user_id):
    mycursor.execute("SELECT SUM(rps_tps_passe) FROM t_reponse_rps AS RPS JOIN t_exercice_exo AS EXO ON RPS.exo_id=EXO.exo_id JOIN t_cours_crs AS CRS ON EXO.crs_id=CRS.crs_id JOIN t_education_educ AS EDUC ON CRS.crs_id=EDUC.crs_id JOIN t_compte_cpt AS CPT ON EDUC.cpt_identifiant=CPT.cpt_identifiant JOIN t_profil_pfl AS PLF ON CPT.cpt_identifiant=PLF.cpt_identifiant WHERE CPT.cpt_identifiant=%(id)s;", {'id': user_id})
    return mycursor.fetchone()

def recuperation_exercices():
    mycursor.execute("SELECT * FROM t_exercice_exo;")
    return mycursor.fetchall()

def creation_compte_profil(email, password, name, surname):
    mycursor.execute("INSERT INTO t_compte_cpt VALUES (%(em)s, %(pa)s)", {'em': email, 'pa': password})
    mydb.commit()
    mycursor.execute("INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_statut, cpt_identifiant) VALUES (%(na)s, %(su)s, 'ETUDIANT', %(em)s)", {'na': name, 'su': surname, 'em': email})
    mydb.commit()
