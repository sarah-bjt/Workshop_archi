from flask import Flask, render_template, request, redirect, url_for
import model

app = Flask(__name__)

@app.route("/")
def accueil():
    return render_template('accueil.html')

@app.route("/connexion", methods=["GET", "POST"])
def connexion():
    if request.method == "POST":
        identifiant = request.form['email']
        password = request.form['password']
        result = model.compte_par_id(identifiant)
        if result and password == result[1]:
            return redirect(url_for('profil', util_id=identifiant))
    return render_template('connexion.html')

@app.route("/profil/<util_id>", methods=["GET", "POST"])
def profil(util_id):
    result = model.profil_par_id(util_id)
    if request.method == "POST":
        form_type = request.form['form_type']
        if form_type == "modifier":
            nouveau_age = request.form['age']
            nouveau_classe = request.form['classe']
            nouveau_nom = request.form['nom']
            nouveau_prenom = request.form['prenom']
            model.modifier_profil(util_id, nouveau_nom, nouveau_prenom, nouveau_age, nouveau_classe)
            result = model.profil_par_id(util_id)
        elif form_type == "supprimer":
            model.supprimer_profil(util_id)
            return redirect(url_for('accueil'))
    if result[5] == 'PROFESSEUR':
        result2 = model.recuperation_etudiants()
        return render_template('profil_prof.html', professeur=result, etudiants=result2, util_id=util_id)
    else:
        return render_template('profil.html', etudiants=result, util_id=util_id)

@app.route("/suivi/<util_id>", methods=["GET", "POST", "PUT", "DELETE"])
def suivi(util_id):
    result = model.recapitulatif_cours_temps()
    temps_total = model.temps_total()
    return render_template('suivi.html', recapitulatif=result, temps_total=temps_total, util_id=util_id)

@app.route("/suivi_prof/<etud_id>/<prof_id>", methods=["GET", "POST", "PUT", "DELETE"])
def suivi_prof(etud_id, prof_id):
    result = model.recapitulatif_cours_temps()
    temps_total = model.temps_total()
    return render_template('suivi_prof.html', recapitulatif=result, temps_total=temps_total, util_id=prof_id)

@app.route("/devoir", methods=["GET"])
def devoir():
    result = model.recuperation_exercices()
    return render_template('devoir.html', exos=result)

@app.route("/deconnexion", methods=['GET', 'POST'])
def déconnexion():
    if request.method == 'GET':
        return render_template('deconnexion.html')
    elif request.method == 'POST':
        return redirect(url_for('accueil'))

@app.route("/creation", methods=['GET', 'POST'])
def creation_compte():
    if request.method == "POST":
        email = request.form['email']
        name = request.form['name']
        surname = request.form['surname']
        password = request.form['password']
        model.creation_compte_profil(email, password, name, surname)
        return redirect(url_for('profil', util_id=email))
    return render_template('creation.html')