from flask import Flask,render_template,request,redirect,url_for
import random
import mysql.connector

app = Flask(__name__)

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Jejxav-mahrag-0kivko",
    database="PANCAKES_LEARNING"
)
mycursor = mydb.cursor()


@app.route("/")
def accueil():
    return render_template('accueil.html')

@app.route("/connexion", methods=["GET","POST"])
def connexion():
    if request.method == "POST" :
        identifiant = request.form['email']
        password = request.form['password']
        mycursor.execute("SELECT * FROM t_compte_cpt WHERE cpt_identifiant=%(id)s;", {'id':identifiant})
        result = mycursor.fetchone()
        if result and password == result[1] :
            return redirect(url_for('profil', util_id=identifiant))
    return render_template('connexion.html')

@app.route("/profil/<util_id>", methods=["GET","POST"])
def profil(util_id):
    mycursor.execute("SELECT * FROM t_profil_pfl WHERE cpt_identifiant=%(id)s;", {'id':util_id})
    result = mycursor.fetchone()
    if request.method == "POST" :
        nouveau_age = request.form['age']
        nouveau_classe = request.form['classe']
        nouveau_nom = request.form['nom']
        nouveau_prenom = request.form['prenom']
        mycursor.execute("UPDATE t_profil_pfl SET pfl_nom=%(nnom)s,pfl_prenom=%(nprenom)s,pfl_age=%(nage)s,pfl_classe=%(nclasse)s WHERE cpt_identifiant=%(id)s;", {'nnom':nouveau_nom, 'nprenom':nouveau_prenom, 'nage':nouveau_age, 'nclasse':nouveau_classe, 'id':util_id})
        mydb.commit()
        mycursor.execute("SELECT * FROM t_profil_pfl WHERE cpt_identifiant=%(id)s;", {'id': util_id})
        result = mycursor.fetchone()
    if result[5] == 'PROFESSEUR' :
        mycursor.execute("SELECT * FROM t_profil_pfl WHERE pfl_statut='ETUDIANT';", {'id':util_id})
        result2 = mycursor.fetchall()
        return render_template('profil_prof.html', professeur=result, etudiants=result2, util_id=util_id)
    else :
        return render_template('profil.html', etudiants=result, util_id=util_id)

@app.route("/suivi", methods=["GET", "POST", "PUT", "DELETE"])
def suivi():
    mycursor.execute("SELECT crs_nom, crs_semestre, SUM(rps_tps_passe) FROM t_cours_crs AS CRS JOIN t_exercice_exo AS EXO ON EXO.crs_id=CRS.crs_id JOIN t_reponse_rps AS RPS ON RPS.exo_id=EXO.exo_id GROUP BY CRS.crs_id ;")
    result = mycursor.fetchall()
    mycursor.execute("SELECT SUM(rps_tps_passe) FROM t_cours_crs AS CRS JOIN t_exercice_exo AS EXO ON EXO.crs_id=CRS.crs_id JOIN t_reponse_rps AS RPS ON RPS.exo_id=EXO.exo_id;")
    temps_total = mycursor.fetchone()
    mycursor.execute("SELECT rps_date, SUM(rps_tps_passe) AS total_tps_passe FROM t_reponse_rps GROUP BY rps_date ORDER BY total_tps_passe DESC;")
    temps_max = mycursor.fetchone()
    return render_template('suivi.html', recapitulatif=result, temps_total=temps_total, temps_max=temps_max)


@app.route("/devoir", methods=["GET"])
def devoir():
    mycursor.execute("SELECT * FROM t_exercice_exo;")
    result = mycursor.fetchall()
    return render_template('devoir.html',exos=result)

@app.route("/deconnexion", methods=['GET', 'POST'])
def déconnexion():
  if request.method == 'GET' :
    return render_template('deconnexion.html')
  elif request.method == 'POST' :
    return redirect(url_for('accueil'))
