from flask import Flask, render_template, request, redirect, url_for, jsonify
import model, json

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
    result = model.recapitulatif_cours_temps(util_id)
    temps_total = model.temps_total(util_id)
    suivi_journalier = model.temps_journalier(util_id)
    suivi_exo = model.temps_par_exo(util_id)
    return render_template('suivi.html', recapitulatif=result, temps_total=temps_total, suivi_journalier=suivi_journalier, suivi_exo=suivi_exo, util_id=util_id)

@app.route("/suivi_prof/<etud_id>/<prof_id>", methods=["GET", "POST", "PUT", "DELETE"])
def suivi_prof(etud_id, prof_id):
    result = model.recapitulatif_cours_temps(etud_id)
    temps_total = model.temps_total(etud_id)
    suivi_journalier = model.temps_journalier(etud_id)
    suivi_exo = model.temps_par_exo(etud_id)
    etudiant = model.profil_par_id(etud_id)
    return render_template('suivi_prof.html', recapitulatif=result, temps_total=temps_total, suivi_journalier=suivi_journalier, suivi_exo=suivi_exo, etudiant=etudiant, util_id=prof_id)

@app.route("/devoir/<util_id>", methods=["GET"])
def devoir(util_id):
    result = model.recuperation_exercices(util_id)
    return render_template('devoir.html', util_id=util_id, exos=result)

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
    
@app.route("/repondre/<util_id>/<exo_id>", methods=['GET', 'POST'])
def repondre_exo(util_id,exo_id):
    info_ex = model.info_exo(exo_id)
    reponses = model.toutes_les_reps(exo_id,util_id)
    if request.method == "POST":
        form_type = request.form['form_type']
        if form_type == "repondre":
            temps = request.form['temps']
            commentaire = request.form['commentaire']
            correction = request.form['correction']
            model.repondre(temps,commentaire,correction,exo_id, util_id)
            reponses = model.toutes_les_reps(exo_id,util_id)
        elif form_type == "corriger":
            reponse_id = request.form['reponse_id']
            correction = request.form['correction']
            model.modifier_correction(util_id, reponse_id, correction,) 
            reponses = model.toutes_les_reps(exo_id,util_id)
    return render_template('reponse.html', util_id=util_id, exo_id=exo_id, exo=info_ex, reponses=reponses)


@app.route("/recompense")
def recompense():
    return jsonify({"Récompenses Pancakes":[{"type":"mini", "temps minimum":"30min"},{"type":"normal", "temps minimum":"1h30min"},{"type":"mega", "temps minimum":"3h"}]})

@app.route("/bonus")
def bonus():
    return jsonify({"Bonus Toppings":[{"type":"sucre glace", "temps minimum":"3h30min"},{"type":"sirop d'erable", "temps minimum":"4h30min"},{"type":"eclats de chocolat", "temps minimum":"6h"}]})

@app.route("/reclamation_recompenses/<util_id>")
def reclamation(util_id):
    return render_template("recompense.html", util_id=util_id)