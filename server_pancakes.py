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

#exo = [{"nom":"exo 2 chapitre 5", "niveau":"2", "temps":"0.5", "enonce":"divise pas 3 la liste suivante : 3, 23,30", "numero du cours : "5"},{"nom":"exo 3 chapitre 5", "niveau":2, "temps":"0.5", "enonce":"multiplie pas 3 la liste suivante : 3, 23,30", "numero du cours : "5"}]


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
        nouveau_age = request.form('age')
        nouveau_classe = request.form('classe')
        nouveau_nom = request.form('nom')
        nouveau_prenom = request.form('prenom')
        
    if result[5] == 'PROFESSEUR' :
        mycursor.execute("SELECT * FROM t_profil_pfl WHERE pfl.statut='ETUDIANT';", {'id':util_id})
        result2 = mycursor.fetchall()
      return render_template('profil_prof.html', etudiants=result2, util_id=util_id)
    else :
      return render_template('profil.html', etudiants=result, util_id=util_id)

@app.route("/suivi", methods=["GET", "POST", "PUT", "DELETE"])
def suivi():
    return render_template('suivi.html')


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
