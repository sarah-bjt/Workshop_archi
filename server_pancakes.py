from flask import Flask,render_template,request
import random

app = Flask(__name__)


@app.route("/")
def accueil():
    return render_template('accueil.html')