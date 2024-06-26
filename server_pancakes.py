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
        result = model.get_user_by_email(identifiant)
        if result and password == result[1]:
            return redirect(url_for('profil', util_id=identifiant))
    return render_template('connexion.html')

@app.route("/profil/<util_id>", methods=["GET", "POST"])
def profil(util_id):
    result = model.get_profile_by_id(util_id)
    if request.method == "POST":
        form_type = request.form['form_type']
        if form_type == "modifier":
            nouveau_age = request.form['age']
            nouveau_classe = request.form['classe']
            nouveau_nom = request.form['nom']
            nouveau_prenom = request.form['prenom']
            model.update_profile(util_id, nouveau_nom, nouveau_prenom, nouveau_age, nouveau_classe)
            result = model.get_profile_by_id(util_id)
        elif form_type == "supprimer":
            model.delete_profile(util_id)
            return redirect(url_for('accueil'))
    if result[5] == 'PROFESSEUR':
        result2 = model.get_students()
        return render_template('profil_prof.html', professeur=result, etudiants=result2, util_id=util_id)
    else:
        return render_template('profil.html', etudiants=result, util_id=util_id)

@app.route("/suivi/<util_id>", methods=["GET", "POST", "PUT", "DELETE"])
def suivi(util_id):
    result = model.get_course_summary()
    temps_total = model.get_total_time()
    return render_template('suivi.html', recapitulatif=result, temps_total=temps_total, util_id=util_id)

@app.route("/suivi_prof/<etud_id>/<prof_id>", methods=["GET", "POST", "PUT", "DELETE"])
def suivi_prof(etud_id, prof_id):
    result = model.get_course_summary()
    temps_total = model.get_total_time()
    return render_template('suivi_prof.html', recapitulatif=result, temps_total=temps_total, util_id=prof_id)

@app.route("/devoir", methods=["GET"])
def devoir():
    result = model.get_exercises()
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
        model.create_account(email, password, name, surname)
        return redirect(url_for('profil', util_id=email))
    return render_template('creation.html')
