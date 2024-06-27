async function fetchRecompensesPancakes() {
    try {
        const response = await fetch('/recompense');
        const data = await response.json();
        console.log(data); // Affiche les données dans la console pour vérification
        const recompensesPancakesDiv = document.getElementById('recompensesPancakes');
        recompensesPancakesDiv.innerHTML = '<h4>Récompenses Pancakes</h4>';
        data['Récompenses Pancakes'].forEach(recompense => {
            recompensesPancakesDiv.innerHTML += `<p>Type: ${recompense.type}, Temps minimum: ${recompense['temps minimum']}</p>`;
        });
    } catch (error) {
        console.error('Error fetching recompenses pancakes:', error);
    }
}

// Fonction pour récupérer les bonus pour les toppings depuis Flask
async function fetchBonusToppings() {
    try {
        const response = await fetch('/bonus');
        const data = await response.json();
        console.log(data); // Affiche les données dans la console pour vérification
        const bonusToppingsDiv = document.getElementById('bonusToppings');
        bonusToppingsDiv.innerHTML = '<h4>Bonus Toppings</h4>';
        data['Bonus Toppings'].forEach(bonus => {
            bonusToppingsDiv.innerHTML += `<p>Type: ${bonus.type}, Temps minimum: ${bonus['temps minimum']}</p>`;
        });
    } catch (error) {
        console.error('Error fetching bonus toppings:', error);
    }
}

// Appel des fonctions pour charger les données au chargement de la page
fetchRecompensesPancakes();
fetchBonusToppings();