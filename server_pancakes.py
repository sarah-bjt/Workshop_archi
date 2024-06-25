from flask import Flask,render_template,request,redirect,url_for
import random
import mysql.connector

app = Flask(__name__)


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
def profil():
    return render_template('profil.html')

@app.route("/deconnexion", methods=['GET', 'POST'])
def déconnexion():
  if request.method == 'GET' :
    return render_template('deconnexion.html')
  elif request.method == 'POST' :
    return redirect(url_for(''))
