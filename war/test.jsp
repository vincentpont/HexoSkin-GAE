<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>Demo: Getting an email address using the Google+ Sign-in button</title>
  <style type="text/css">
  .hide { display: none;}
  .show { display: block;}
  </style>
  
  <script src="https://apis.google.com/js/plusone.js" type="text/javascript"></script>
  <script src="https://apis.google.com/js/client:plusone.js" type="text/javascript"></script>
  <script type="text/javascript">
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
  </script>
</head>
<body>

	<span id="signinButton" style="display: none"> <span
		class="g-signin" data-callback="signinCallback"
		data-clientid="799362622292-cisd7bgllvoo1pckcsm38smvl9ec1m60.apps.googleusercontent.com"
		data-cookiepolicy="single_host_origin"
		data-requestvisibleactions="http://schemas.google.com/AddActivity"
		data-scope="https://www.googleapis.com/auth/plus.login"> </span>
	</span>
	

  <div id="email" class="hide"></div>
</body>
</html>

