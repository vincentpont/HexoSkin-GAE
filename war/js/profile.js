/* ========================================================================
 * Travail de bachelor 2014
 * Author : Vincent Pont
 * Date : 1 juillet 2014
 * File javascript that create Google charts and Google maps for compare page.
 * ========================================================================
 * HES-SO Valais/Wallis
 * ======================================================================== */


/**
 * Method that test the fields ofr the profile
 * @param form
 * @return true or false
 */
function checkform (form)
{

  if (form.age.value == "") {
    alert( "Veuillez entrez une valeur pour l'age." );
    form.age.focus();
    return false;
  }
  if (!isNumber(form.age.value)) {
	    alert( "Veuillez entrer un nombre pour l'age." );
	    form.age.focus();
	    return false;
	  }
  if(!testAgeValue(form.age.value)){
	   alert( "L'âge doit être compris entre 10 et 100." );
	   form.poids.focus();
	  return false;
  }
  if(!testPoidsValue(form.poids.value)){
	   alert( "Le poids doit être compris entre 10 et 200." );
	   form.poids.focus();
	  return false;
  }
  if (!isNumber(form.poids.value)) {
	    alert( "Veuillez entrez un nombre pour le poids." );
	    form.poids.focus();
	    return false;
	  }
  if(form.sexe.value != "Femme" && form.sexe.value != "femme"
	  && form.sexe.value != "Homme" && form.sexe.value != "homme"){
	 alert( "Svp entrez un sexe (Femme ou Homme)" );
	 form.sexe.focus();
	 return false;
  }
  
  // Cast if we enter some value with .
  form.poids.value = parseInt(form.poids.value);
  form.age.value = parseInt(form.age.value);
  
  // ** END **
  return true ;
}

/**
 * Method to test if the value is correct for age (10 to 100)
 * @param value
 * @return true or false
 */
function testAgeValue(value){
	
	var first = 10 ;
	var last = 100
	
    return (first < last ? value >= first && value <= last : value >= last && value <= first);
}

/**
 * Method to test if the value is correct for poids (10 to 200)
 * @param value
 * @returns true or false
 */
function testPoidsValue(value){
	
	var first = 10 ;
	var last = 200
	
    return (first < last ? value >= first && value <= last : value >= last && value <= first);
}

/**
 * Method that test if the variable is a number
 * @param n
 * @returns true or false
 */
function isNumber(n) {
	return /^-?[\d.]+(?:e-?\d+)?$/.test(n); 
	} 