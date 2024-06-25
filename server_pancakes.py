from flask import Flask,render_template,request,redirect,url_for
import random
import mysql.connector

app = Flask(__name__)

etudiants=[{"name":"Bonnot", "surname": "Théo", "temps":"35h"}, {"name":"Beaujault", "surname":"Sarah", "temps":"10h"}]
exo = [{"nom":"exo 2 chapitre 5", "niveau":2, "temps":0.5, "enonce":"divise pas 3 la liste suivante : 3, 23,30", "numero du cours : 5},{"nom":"exo 3 chapitre 5", "niveau":2, "temps":0.5, "enonce":"multiplie pas 3 la liste suivante : 3, 23,30", "numero du cours : 5}


@app.route("/")
def accueil():
    return render_template('accueil.html')

@app.route("/connexion", methods=["GET","POST"])
def connexion():
    if request.method == "POST" :
        identifiant = request.form['email']
        password = request.form['password']
        if identifiant == 'Bonnot.Theo@mail.com' and password == '666' :
            return redirect(url_for('profil', util_id=identifiant))
    return render_template('connexion.html')

@app.route("/profil/<util_id>", methods=["GET","POST"])
def profil(util_id):
    return render_template('profil.html', etudiants=etudiants, util_id=util_id)

@app.route("/suivi", methods=["GET", "POST", "PUT", "DELETE"])
def suivi():
    return render_template('suivi.html')

@app.route("/deconnexion", methods=['GET', 'POST'])
def déconnexion():
  if request.method == 'GET' :
    return render_template('deconnexion.html')
  elif request.method == 'POST' :
    return redirect(url_for('/'))
