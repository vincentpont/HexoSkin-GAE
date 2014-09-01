/* ========================================================================
 * Travail de bachelor 2014
 * Author : Vincent Pont
 * Date : 10 juin 2014
 * File javascript that handle the login with Google.
 * ========================================================================
 * HES-SO Valais/Wallis
 * ======================================================================== */

/**
 * Method that get the account
 */
(function() {
	var po = document.createElement('script');
	po.type = 'text/javascript';
	po.async = true;
	po.src = 'https://apis.google.com/js/client:plusone.js';
	var s = document.getElementsByTagName('script')[0];
	s.parentNode.insertBefore(po, s);
})();


/**
 * Method that test the token to know if the user is connected or not
 * For login page only
 * @param authResult
 */
function signinCallback(authResult) {
	if (authResult['access_token']) {
		// Autorisation réussie
		
	  window.location = "/training";
		
	} else if (authResult['error']) {
		// Fail logged
	}
}



/**
 * Method that test the token to know if the user is connected or not
 * For all others pages for redirection if not logged
 * @param authResult
 */
function signinCallbacks(authResult) {
	if (authResult['access_token']) {
		// Autorisation réussie
	} else if (authResult['error']) {
		// Fail logged
		window.location = "/login.jsp";
	}
}

/**
* Method to logout the user
*/
function logout() {
	document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://10-dot-logical-light-564.appspot.com/login.jsp";
}