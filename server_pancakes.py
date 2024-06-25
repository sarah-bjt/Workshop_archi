from flask import Flask,render_template,request
import random
import mysql.connector

app = Flask(__name__)


@app.route("/")
def accueil():
    return render_template('accueil.html')

@app.route("/connexion", methods=["GET","POST"])
def connexion():
    return render_template('connexion.html')