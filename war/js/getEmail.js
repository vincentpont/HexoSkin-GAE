  
  /*====================================
	**
	** File jsp that get the email from the account Google.
	** Not used but possibility to use in futur.
	**
	====================================
	*/


  /*
   * Déclenché lorsque l'utilisateur accepte la connexion, annule ou ferme la
   * boîte de dialogue d'autorisation.
   */
  function loginFinishedCallback(authResult) {
    if (authResult) {
      if (authResult['error'] == undefined){
        gapi.auth.setToken(authResult); // Stocker le jeton renvoyé.
        toggleElement('signin-button'); // Masquer le bouton de connexion lorsque l'ouverture de session réussit.
        getEmail();                     // Déclencher une requête pour obtenir l'adresse e-mail.
      } else {
        console.log('An error occurred');
      }
    } else {
      console.log('Empty authResult');  // Un problème s'est produit
    }
  }

  /*
   * Initie la requête au point de terminaison userinfo pour obtenir l'adresse
   * e-mail de l'utilisateur. Cette fonction dépend de gapi.auth.setToken, qui doit contenir un
   * jeton d'accès OAuth valide.
   *
   * Une fois la requête achevée, le rappel getEmailCallback est déclenché et reçoit
   * le résultat de la requête.
   */
  function getEmail(){
    // Charger les bibliothèques OAuth2 pour activer les méthodes userinfo.
    gapi.client.load('oauth2', 'v2', function() {
          var request = gapi.client.oauth2.userinfo.get();
          request.execute(getEmailCallback);
        });
  }

  function getEmailCallback(obj){
    var el = document.getElementById('email');
    var email = '';

    if (obj['email']) {
      email = 'Email: ' + obj['email'];
    }

    console.log(obj);   // Retirer les commentaires pour inspecter l'objet complet.

    el.innerHTML = email;
    toggleElement('email');
  }

  function toggleElement(id) {
    var el = document.getElementById(id);
    if (el.getAttribute('class') == 'hide') {
      el.setAttribute('class', 'show');
    } else {
      el.setAttribute('class', 'hide');
    }
  }