import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Jejxav-mahrag-0kivko",
    database="PANCAKE_L"
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
    mycursor.execute("SELECT crs_nom, crs_semestre, SUM(RPS.rps_tps_passe) FROM t_reponse_rps AS RPS JOIN t_exercice_exo AS EXO ON RPS.exo_id=EXO.exo_id JOIN t_cours_crs AS CRS ON EXO.crs_id=CRS.crs_id WHERE RPS.cpt_identifiant=%(id)s GROUP BY CRS.crs_id ;", {'id': user_id})
    return mycursor.fetchall()

def temps_total(user_id):
    mycursor.execute("SELECT SUM(RPS.rps_tps_passe) FROM t_reponse_rps AS RPS WHERE RPS.cpt_identifiant=%(id)s;", {'id': user_id})
    temps = mycursor.fetchone()[0]/60
    return round(temps, 1)

def temps_journalier(user_id):
    mycursor.execute("SELECT RPS.rps_date, SUM(RPS.rps_tps_passe) FROM t_exercice_exo AS EXO JOIN t_reponse_rps AS RPS ON EXO.exo_id = RPS.exo_id JOIN t_compte_cpt AS CPT ON RPS.cpt_identifiant = CPT.cpt_identifiant WHERE CPT.cpt_identifiant = %(id)s GROUP BY RPS.rps_date ORDER BY RPS.rps_date ASC;", {'id': user_id})
    return mycursor.fetchall()

def temps_par_exo(user_id) :
  mycursor.execute("SELECT exo_nom, crs_nom, rps_tps_passe FROM t_cours_crs AS CRS JOIN t_exercice_exo AS EXO ON CRS.crs_id=EXO.crs_id JOIN t_reponse_rps AS RPS ON EXO.exo_id = RPS.exo_id JOIN t_compte_cpt AS CPT ON RPS.cpt_identifiant = CPT.cpt_identifiant WHERE CPT.cpt_identifiant=%(id)s ORDER BY exo_nom ASC;", {'id': user_id})
  return mycursor.fetchall()

def recuperation_exercices(util_id):
    mycursor.execute("SELECT * FROM t_exercice_exo AS EXO JOIN t_cours_crs AS CRS ON EXO.crs_id=CRS.crs_id JOIN t_education_educ AS EDUC ON CRS.crs_id= EDUC.crs_id WHERE EDUC.cpt_identifiant = %(id)s;", {'id':util_id})
    return mycursor.fetchall()

def creation_compte_profil(email, password, name, surname):
    mycursor.execute("INSERT INTO t_compte_cpt VALUES (%(em)s, %(pa)s)", {'em': email, 'pa': password})
    mydb.commit()
    mycursor.execute("INSERT INTO t_profil_pfl (pfl_nom, pfl_prenom, pfl_statut, pfl_date, cpt_identifiant) VALUES (%(na)s, %(su)s, 'ETUDIANT', CURDATE(), %(em)s)", {'na': name, 'su': surname, 'em': email})
    mydb.commit()


def info_exo(exo_id):
    mycursor.execute("SELECT * FROM t_exercice_exo WHERE exo_id = %(exo)s", {'exo':exo_id})
    return mycursor.fetchone()

def repondre(temps,commentaire,correction,exo_id, util_id):
    if correction == '0' :
        mycursor.execute("INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, rps_date, exo_id, cpt_identifiant) VALUES (%(tps)s, 'PAS CORRIGE', %(comm)s, CURDATE(), %(ex)s, %(id)s);", {'tps': temps, 'comm': commentaire, 'ex': exo_id, 'id':util_id})
    elif correction == '1' :
        mycursor.execute("INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, rps_date, exo_id, cpt_identifiant) VALUES (%(tps)s, 'VRAI', %(comm)s, CURDATE(), %(ex)s, %(id)s);", {'tps': temps, 'comm': commentaire, 'ex': exo_id, 'id':util_id})
    elif correction == '2' :
        mycursor.execute("INSERT INTO t_reponse_rps (rps_tps_passe, rps_correction, rps_commentaire, rps_date, exo_id, cpt_identifiant) VALUES (%(tps)s, 'FAUX', %(comm)s, CURDATE(), %(ex)s, %(id)s);", {'tps': temps, 'comm': commentaire, 'ex': exo_id, 'id':util_id})
    mydb.commit()

def toutes_les_reps(exo_id, util_id):
    mycursor.execute("SELECT * FROM t_reponse_rps WHERE cpt_identifiant = %(id)s AND exo_id = %(exo)s;", {'id':util_id, 'exo':exo_id })
    return mycursor.fetchall()

def modifier_correction(util_id, reponse_id, correction):
    if correction=='0' :
        mycursor.execute("UPDATE t_reponse_rps SET rps_correction= 'PAS CORRIGE' WHERE rps_id=%(repon_id)s AND cpt_identifiant=%(id)s;", {'repon_id': reponse_id, 'id': util_id})
    elif correction=='1' :
        mycursor.execute("UPDATE t_reponse_rps SET rps_correction= 'VRAI' WHERE rps_id=%(repon_id)s AND cpt_identifiant=%(id)s;", {'repon_id': reponse_id, 'id': util_id})
    elif correction=='2' :
        mycursor.execute("UPDATE t_reponse_rps SET rps_correction= 'FAUX' WHERE rps_id=%(repon_id)s AND cpt_identifiant=%(id)s;", {'repon_id': reponse_id, 'id': util_id})
    mydb.commit()
