<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="restHexoSkin.RestInvokerHexo"%>
<%@ page import="java.util.List;"%>

<script src="bootstrap-3.1.1/js/moment.js"></script>

<!--  Get Variable from Servlet -->
<%  String lastDateWorkout = (String) request.getAttribute("lastDateWorkout"); %>

<!-- Google account get account -->
<script type="text/javascript">
	(function() {
		var po = document.createElement('script');
		po.type = 'text/javascript';
		po.async = true;
		po.src = 'https://apis.google.com/js/client:plusone.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(po, s);
	})();
</script>

<!-- Google account test token -->
<script type="text/javascript">
	function signinCallback(authResult) {
		if (authResult['access_token']) {
			// Logged
		} else if (authResult['error']) {
			document.getElementById('signinButton').setAttribute('style',
					'display: none');
			window.location = "login.jsp";
		}
	}
	
	/**
	* Method to logout the user
	*/
	function logout() {
		document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://9-dot-logical-light-564.appspot.com/login.jsp";
	}
	
</script>

<%  
String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";
RestInvokerHexo restHexo = new RestInvokerHexo(s1); 
RestInvokerDatastore restMap = new RestInvokerDatastore(); 

String restHexoDate = "" ;
List list ;

// Test if we have something in param 
if(request.getParameter("date") != null){
	restHexoDate = request.getParameter("date");
	restMap.getDataMap("vincentpont@gmail.com", restHexoDate); 
	list = restMap.getDataWorkoutByEmailAndDate(restHexoDate, "vincentpont@gmail.com");
	restHexoDate = restHexoDate.substring(0, 10);
	restHexoDate = restHexoDate.replace('.', '-');
	
}
 // If not we show the last workout
else{ 
	restMap.getDataMap("vincentpont@gmail.com", lastDateWorkout); 
	list = restMap.getDataWorkoutByEmailAndDate(lastDateWorkout, "vincentpont@gmail.com");
	restHexoDate = lastDateWorkout.substring(0, 10);
	restHexoDate = restHexoDate.replace('.', '-');
}


List<String> listPulsations = restHexo.returnAllValueFromJson(restHexoDate, "19"); 
List<String> listVolumeTidals = restHexo.returnAllValueFromJson(restHexoDate, "37"); 
List<String> listRespirationFreqs = restHexo.returnAllValueFromJson(restHexoDate, "33"); 
List<String> listVentilations = restHexo.returnAllValueFromJson(restHexoDate, "36"); 

List<Double> listVitesses = restMap.getListVitesses();
List<Double> listAltitudes = restMap.getListAltitudes();


StringBuffer stringBufferPulsation = new StringBuffer();
StringBuffer stringBufferVitesses = new StringBuffer();
StringBuffer stringBufferVolumeTidal = new StringBuffer();
StringBuffer stringBufferRespirationFreq = new StringBuffer();
StringBuffer stringBufferVentilations = new StringBuffer();
StringBuffer stringBufferAltitudes = new StringBuffer();

stringBufferPulsation = restMap.convertListToStringBufferInteger(listPulsations);
stringBufferVitesses = restMap.convertListToStringBufferInteger(listVitesses);
stringBufferVolumeTidal = restMap.convertListToStringBufferInteger(listVolumeTidals);
stringBufferRespirationFreq = restMap.convertListToStringBufferInteger(listRespirationFreqs);
stringBufferVentilations = restMap.convertListToStringBufferInteger(listVentilations);
stringBufferAltitudes = restMap.convertListToStringBufferInteger(listAltitudes);

String timeTotal  = (String) list.get(1);

%>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">


	google.load("visualization", "1.1", {
		packages : [ "corechart" ]
	});
	
	google.setOnLoadCallback(drawChart);
	
    var arrayVitesses = [ <%= stringBufferVitesses.toString() %> ];
    var arrayAltitudes = [ <%= stringBufferAltitudes.toString() %> ];
  	var arrayPulsation = [ <%= stringBufferPulsation.toString() %> ];
    var arrayVolumeTidal = [ <%= stringBufferVolumeTidal.toString() %> ];
    var arrayRespiration = [ <%= stringBufferRespirationFreq.toString() %> ];
    var arrayVentilation = [ <%= stringBufferVentilations.toString() %> ];
    var timeTotal =  '<%=timeTotal%>';
    var multiple;

 
    
	function drawChart() {
		
		modifyListFirstTime();
		
		multiple = arrayPulsation.length / arrayVitesses.length;
		var average = 0.0;
		var index = 0;
		var position = 0;
		
		// Ici on ajoute des valeurs par rapport si la liste de pulsation et 2 ou 3 fois plus grandes

		// Ca on fait qu'une fois que nos liste sont bien corrigées (proche de 2 ou 3)
		if (multiple <= 2.5){
		    // Double speed array with averages
		    for(var f = 0  ; f < arrayPulsation.length; f++){
		    	// only pairs
		    	if(index % 2 == 0) {
		    	average = (arrayAltitudes[index] + arrayAltitudes[index+2])/2;
		    	average = average.toFixed(2);
		    	average = parseFloat(average);
		    	arrayAltitudes.splice(index+1, 0, average);
		    	}
		    	index++;
		    }
		}
		else if (multiple <= 3.5 && multiple > 2.5  ) {
	    	// Double speed array with averages
		    for(var f = 0  ; f < arrayPulsation.length; f++){
		    	
		    	// add first value
		    	if(f == 0){
		    		
					// add first number
			    	average = (arrayAltitudes[f] + arrayAltitudes[f+3])/2;
			    	average = average.toFixed(2);
			    	average = parseFloat(average);
			    	arrayAltitudes.splice(f+1, 0, average);
			    	
			    	// Second number
			    	average = (arrayAltitudes[f+1] + arrayAltitudes[3])/2;
			    	average = average.toFixed(2);
			    	average = parseFloat(average);
			    	arrayAltitudes.splice(f+2, 0, average);
		    	}
		    	
		    	// add all others values by multiple of 3 (we miss 2 data of 3 if the size is 3x bigger)
				if( position % 3 == 0){
		
				// add first average number
		    	average = (arrayAltitudes[position] + arrayAltitudes[position+3])/2;
		    	average = average.toFixed(2);
		    	average = parseFloat(average);
		    	arrayAltitudes.splice(f+1, 0, average);
		    	
		    	// Second  average number
		    	average = (arrayAltitudes[position+1] + arrayAltitudes[position+3])/2;
		    	average = average.toFixed(2);
		    	average = parseFloat(average);
		    	arrayAltitudes.splice(f+2, 0, average);
		    	
		    	}
		    
		    	position ++;
			}
		}
		
		// Reinitialize
		average = 0.0;
		index = 0;
		position = 0;
		
		// Add values in array Vitesses to be the same size to the pulsation array
		
		if (multiple <= 2.5){
		    // Double speed array with averages
		    for(var f = 0  ; f < arrayPulsation.length; f++){
		    	// only pairs
		    	if(index % 2 == 0) {
		    	average = (arrayVitesses[index] + arrayVitesses[index+2])/2;
		    	average = average.toFixed(2);
		    	average = parseFloat(average);
		    	arrayVitesses.splice(index+1, 0, average);
		    	}
		    	index++;
		    }
		}


		else if (multiple <= 3.5 && multiple > 2.5 ) {
	    	// Double speed array with averages
		    for(var f = 0  ; f < arrayPulsation.length; f++){
		    	
		    	// add first value
		    	if(f == 0){
		    		
					// add first number
			    	average = (arrayVitesses[f] + arrayVitesses[f+3])/2;
			    	average = average.toFixed(2);
			    	average = parseFloat(average);
			    	arrayVitesses.splice(f+1, 0, average);
			    	
			    	// Second number
			    	average = (arrayVitesses[f+1] + arrayVitesses[3])/2;
			    	average = average.toFixed(2);
			    	average = parseFloat(average);
			    	arrayVitesses.splice(f+2, 0, average);
		    	}
		    	
		    	// add all others values by multiple of 3 (we miss 2 data of 3 if the size is 3x bigger)
				if( position % 3 == 0){
		
				// add first number
		    	average = (arrayVitesses[position] + arrayVitesses[position+3])/2;
		    	average = average.toFixed(2);
		    	average = parseFloat(average);
		    	arrayVitesses.splice(f+1, 0, average);
		    	
		    	// Second number
		    	average = (arrayVitesses[position+1] + arrayVitesses[position+3])/2;
		    	average = average.toFixed(2);
		    	average = parseFloat(average);
		    	arrayVitesses.splice(f+2, 0, average);
		    	
		    	}
		    
		    	position ++;
			}
		}
		
		//alert("arrayVitesses " +arrayVitesses.length);
		//alert("arrayVitesses " + arrayVitesses.join('\n'));
		//alert("arrayPulsation " + arrayPulsation.length);
		
		var dateFormatter = new google.visualization.DateFormat({pattern : 'HH:mm:ss'})
		
		var data = new google.visualization.DataTable();
			data.addColumn('datetime', "Temps");
			data.addColumn('number', 'Vitesse km/h');
			data.addColumn('number', 'Altitudes décamètre');
			data.addColumn('number', 'Pulsation min');
			data.addColumn('number', 'Volume Tidale litre');
			data.addColumn('number', 'Respiration min');
			data.addColumn('number', 'Ventilation litre/min');


		
		// A AMELIORER MARCHE QUE POUR LES MIN+SEC	
		// "2:34"
		// Get time 
	    var minutesTime =  timeTotal.substring(0,1);
		var secondesTime = timeTotal.substring(2,4);
		
		// Convert to milliseconds
		var minToMs = (minutesTime * 60) * 1000 ;
		var secToMs = secondesTime * 1000 ;
		var totalMilliseconds = minToMs  +  secToMs; // 154 000

		// Get number of data
		var numberData = arrayPulsation.length-1; 		//225
		
		// Divide number of milliseconds by data to know time that was record the data (in ms)
		var msToMultiple = totalMilliseconds / numberData; // 684
		
		
		// Add values
		  for(var i = 0; i < arrayPulsation.length  ; i++){
		
		   // Convert and decimals 2
		   arrayVentilation[i] = parseFloat((arrayVentilation[i]/1000).toFixed(2));
		   arrayVolumeTidal[i] = parseFloat((arrayVolumeTidal[i]/1000).toFixed(2));

		   data.addRow([new Date(00, 00, 00, 00, 00, 00, i*msToMultiple), arrayVitesses[i], arrayAltitudes[i]/10, arrayPulsation[i], arrayVolumeTidal[i], 
		                arrayRespiration[i], arrayVentilation[i]]);

		  }
			dateFormatter.format(data,0);
		
		 
		var options = {
			colors: ['#FFF800' , '#00B125', '#FF0007', '#46FDCF', '#960DF9', '#0C1A69'],
			hAxis : {
				title: 'Temps',
				format: 'HH:mm:ss',
				gridlines: {count : arrayPulsation.length-1},
				titleTextStyle : {
					color : '#333'
				}
			},
			vAxis : {
				title: 'Valeurs',
				minValue : 0
			},
		};
		
		// Draw chart
		var chart = new google.visualization.AreaChart(document
				.getElementById('chart_div2'));
		chart.draw(data, options);
		
		var arrayToHide = new Array();
		var index = 0 ;
		

		// Listener of buttons
		 var hideSpeed = document.getElementById("hideSpeed");
		 hideSpeed.onclick = function()
		 {
			// disable button
			hideSpeed.disabled  = true;
		    view = new google.visualization.DataView(data); 
		    
		    arrayToHide.splice(index, 0, 1);
		    if(arrayToHide.length < 6){
			    view.hideColumns(arrayToHide);
			    }
	    	
		    chart.draw(view, options);
		    index++;
		 }		
		
		 var hideAlti = document.getElementById("hideAltitude");
		 hideAlti.onclick = function()
		 {
			hideAlti.disabled  = true;
		    view = new google.visualization.DataView(data); 
		    
		    arrayToHide.splice(index, 0, 2);
		    if(arrayToHide.length < 6){
			    view.hideColumns(arrayToHide);
			    }
	    	
		    chart.draw(view, options);
		    index++;
		 }
		
		
		 var hideSal = document.getElementById("hidePulsation");
		 hideSal.onclick = function()
		 {
			hideSal.disabled  = true;
		    view = new google.visualization.DataView(data); 
		    
		    arrayToHide.splice(index, 0, 3);
		    if(arrayToHide.length < 6){
			    view.hideColumns(arrayToHide);
			    }
		    
		    chart.draw(view, options);
		    index++;
		 }

		 
		 var hideTidal = document.getElementById("hideTidal");
		 hideTidal.onclick = function()
		 {
			hideTidal.disabled  = true;
		    view = new google.visualization.DataView(data);
		    
		    arrayToHide.splice(index, 0, 4);
		    if(arrayToHide.length < 6){
			    view.hideColumns(arrayToHide);
			    }
	    	
		    chart.draw(view, options);
		    index++;
		 }	
		 
		 var hideRespiration = document.getElementById("hideRespiration");
		 hideRespiration.onclick = function()
		 {
			hideRespiration.disabled  = true;
		    view = new google.visualization.DataView(data);
		    
		    arrayToHide.splice(index, 0, 5);
		    if(arrayToHide.length < 6){
		    view.hideColumns(arrayToHide);
		    }
	    	
		    chart.draw(view, options);
		    index++;
		 }	
		 
		 
		 var hideVentilation = document.getElementById("hideVentilation");
		 hideVentilation.onclick = function()
		 {
			 hideVentilation.disabled  = true;
		    view = new google.visualization.DataView(data);
		    
		    arrayToHide.splice(index, 0, 6);
		    if(arrayToHide.length < 6){
			    view.hideColumns(arrayToHide);
			    }

		    chart.draw(view, options);
		    index++;
		 }	
		 
		 
		 // See all
		 var seeAll = document.getElementById("seeAll");
		 seeAll.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    arrayToHide.length = 0;
		    view.setColumns([0,1,2,3,4,5,6]);
		    chart.draw(view, options);
		    
		    //Enabled all buttons
		    hideSpeed.disabled  = false;
			hideAlti.disabled  = false;
			hideSal.disabled  = false;
			hideTidal.disabled  = false;
			hideRespiration.disabled  = false;
			 hideVentilation.disabled  = false;
		 }
		
	}
	
	
	function modifyListFirstTime(){
		
		var random ;
		var moyenne ;
		// Ici on va corrgier les tailles des listes pour qu'elle soit le plus proche d'un chiffre entier pour 
		// par la suite rajouter plus facilement de valeurs
		
		var difference = arrayPulsation.length / arrayVitesses.length;

		if(difference > 1.50 && difference <= 2.50){
			// Tant que la différence de taille est plus grand que 1.90
			while(difference >= 1.90){
				
				// on augmente les valeurs avec des moyenne dans la vitesses pour réduire l'écart  2.2 -> 2.0
				if(difference >= 1.90 && difference < 2.50){

					random = Math.floor(Math.random()* (arrayVitesses.length-4)) + 1 ; 			// we take a random position to add new values to incement size of array
					moyenne = (arrayVitesses[random] + arrayVitesses[random+1])/2;
					arrayVitesses.splice(random+1, 0, moyenne);	
					
					// same with array of altitudes
					moyenne = (arrayAltitudes[random] + arrayAltitudes[random+1])/2;
					arrayAltitudes.splice(random+1, 0, moyenne);	
				}
				// On augmente pulsation donc 2.8 -> 3.0 
				else if (difference >= 1.50 && difference <= 1.90){

					random = Math.floor(Math.random()* (arrayPulsation.length-4)) + 1 ; 			// we take a random position to add new values to incement size of array
					moyenne = (arrayPulsation[random] + arrayPulsation[random+1])/2;
					arrayPulsation.splice(random+1, 0, moyenne);
					
					// And add too in the others list if not we have more data in pulsation
					moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random+1])/2;
					arrayVolumeTidal.splice(random+1, 0, moyenne);

					moyenne = (arrayRespiration[random] + arrayRespiration[random+1])/2;
					arrayRespiration.splice(random+1, 0, moyenne);

					moyenne = (arrayVentilation[random] + arrayVentilation[random+1])/2;
					arrayVentilation.splice(random+1, 0, moyenne);

				}
				
				//alert("difference " +difference);
				difference = difference = arrayPulsation.length / arrayVitesses.length;
			}
		}
		
		else if(difference > 2.50 && difference <= 3.50){

			//  Tant que on a est pas entre (2.9 a 3.10) pour maximum de précision
			while(difference <= 2.90 || difference >= 3.00){
				// on augmente vitesses donc 2.2 ->2.0
				if(difference >= 2.90 && difference < 3.50){

					random = Math.floor(Math.random()* (arrayVitesses.length-4)) + 1 ;// we take a random position to add new values to incement size of array
					moyenne = (arrayVitesses[random] + arrayVitesses[random+1])/2;
					arrayVitesses.splice(random+1, 0, moyenne);	
					
					// same with array of altitudes
					moyenne = (arrayAltitudes[random] + arrayAltitudes[random+1])/2;
					arrayAltitudes.splice(random+1, 0, moyenne);	
					
				}
				// On augmente pulsation donc 2.8 -> 3.0 
				else if (difference >= 2.50 && difference < 2.90){

					random = Math.floor(Math.random()* (arrayPulsation.length-4)) + 1 ;// we take a random position to add new values to incement size of array
					moyenne = (arrayPulsation[random] + arrayPulsation[random+1])/2;
					arrayPulsation.splice(random+1, 0, moyenne);
					
					// And add too in the others list if not we have more data in pulsation
					moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random+1])/2;
					arrayVolumeTidal.splice(random+1, 0, moyenne);

					moyenne = (arrayRespiration[random] + arrayRespiration[random+1])/2;
					arrayRespiration.splice(random+1, 0, moyenne);

					moyenne = (arrayVentilation[random] + arrayVentilation[random+1])/2;
					arrayVentilation.splice(random+1, 0, moyenne);
				}
				
				difference = difference = arrayPulsation.length / arrayVitesses.length;

			}
		
		}
		
	}
	
</script>


	<%
	String lastDateMap = "";
	
	// Test if we have something in param 
	if(request.getParameter("date") != null){
		lastDateMap = request.getParameter("date");
		restMap.getDataMap("vincentpont@gmail.com", lastDateMap); 
	} // If not we show the last workout
	else{
		lastDateMap = lastDateWorkout;
		restMap.getDataMap("vincentpont@gmail.com", lastDateMap); 
	}
	
	List<Double> listLatitude = restMap.getListLatitudes();
	List<Double> listLongitude = restMap.getListLongitudes();
	List<Double> listSpeed = restMap.getListVitesses();
	List<Double> listAltitude = restMap.getListAltitudes();

	StringBuffer stringBufferLat = new StringBuffer();
	StringBuffer stringBufferLong = new StringBuffer();
	StringBuffer stringBufferSpeed = new StringBuffer();
	StringBuffer stringBufferAlti = new StringBuffer();
	
	// Convert to stringbuffer to pass the list in javascript array
	stringBufferLat = restMap.convertListToStringBuffer(listLatitude);
	stringBufferLong = restMap.convertListToStringBuffer(listLongitude);
	stringBufferSpeed = restMap.convertListToStringBuffer(listSpeed);
	stringBufferAlti = restMap.convertListToStringBuffer(listAltitude);

	
	%>
	
	<!-- Google MAPS -->
<script
	src="https://maps.googleapis.com/maps/api/js?v=3?key={AIzaSyA9MSARpM9GdjunV4sR5mxpOuD3pfkyldc}">
</script>
<script 

	src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization">

</script>
	
<script>

	// Android data
	var arrayLat = [ <%= stringBufferLat.toString() %> ];
	var arrayLong = [ <%= stringBufferLong.toString() %> ];
	var arraySpeed = [ <%= stringBufferSpeed.toString() %> ];
	var arrayAlti = [ <%= stringBufferAlti.toString() %> ];
	var size = arrayLat.length;

	var planCoordinates= new Array() ;	
	var pathStyle ;
	var heatmap;
	var pointarray;
	var taxiData = new Array();
	var map ;
	var markerEnd, markerStart;

   /**
    * Method to initalize the map
    */
	function initialize() {
	   
		var mapOptions = {  
			zoom : 16,
			center : new google.maps.LatLng(arrayLat[0], arrayLong[0]),
			mapTypeId : google.maps.MapTypeId.PLAN
		};

		map = new google.maps.Map(document.getElementById('map-canvas'),
				mapOptions);
		
	   // Add by default the path
	   addPath();
	   addStartStop();
					  	
	}
  
	google.maps.event.addDomListener(window, 'resize', initialize);
	google.maps.event.addDomListener(window, 'load', initialize);
	
	
	
	
		/*
		*Method to modify the list to be more accurate to 2 or 3 MORE ACCURATE
		*
		*/
		function modifyLists(){
			
			var random ;
			var moyenne ;
			
			//alert("arrayPulsation avant " + arrayPulsation.length);
			//alert("arrayVolumeTidal avant " + arrayVolumeTidal.length);
			
			// Ici on va corrgier les tailles encore plus des listes pour qu'elle soit le plus proche d'un chiffre entier (2,3)
			var difference = arrayPulsation.length / arraySpeed.length;

			if(difference > 1.50 && difference <= 2.50){
				// Tant que la différence de taille est plus grand que 1.90
				while(difference > 2.00){
					
					// on enlève deux valeurs mais on mets une moyenne des deux enlever à la place
					if(difference > 2.00 && difference <= 2.50){

						random = Math.floor(Math.random()* (arrayPulsation.length-2)) + 1 ;
						
						moyenne = (arrayPulsation[random] + arrayPulsation[random+1])/2;
						arrayPulsation.splice(random, 0, moyenne);	
						arrayPulsation.splice(random+1, 2);// on enlève les deux valeurs		
						
						// On fait pareil avec les autres listes
						moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random+1])/2;
						arrayVolumeTidal.splice(random, 0, moyenne);	
						arrayVolumeTidal.splice(random+1, 2);	
						
						moyenne = (arrayRespiration[random] + arrayRespiration[random+1])/2;
						arrayRespiration.splice(random, 0, moyenne);	
						arrayRespiration.splice(random+1, 2);	
						
						moyenne = (arrayVentilation[random] + arrayVentilation[random+1])/2;
						arrayVentilation.splice(random, 0, moyenne);	
						arrayVentilation.splice(random+1, 2);		
					}
					
					// On rajout une valeur (moyenne) entre deux valeurs
					else if (difference >= 1.50 && difference < 2.00){

						random = Math.floor(Math.random()* (arrayPulsation.length-2)) + 1 ;
						
						moyenne = (arrayPulsation[random] + arrayPulsation[random+1])/2;
						arrayPulsation.splice(random+1, 0, moyenne);				
						
						moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random+1])/2;
						arrayVolumeTidal.splice(random+1, 0, moyenne);	
						
						moyenne = (arrayRespiration[random] + arrayRespiration[random+1])/2;
						arrayRespiration.splice(random+1, 0, moyenne);	
						
						moyenne = (arrayVentilation[random] + arrayVentilation[random+1])/2;
						arrayVentilation.splice(random+1, 0, moyenne);		
						
						
					}
					//alert("difference " +difference);
					difference = difference = arrayPulsation.length / arraySpeed.length;
				}
			}
			
			else if(difference > 2.50 && difference <= 3.50){

				//  Tant que on a est pas entre (2.9 a 3.10) pour maximum de précision
				while(difference < 3.00){
					// on baisse
					if(difference > 3.00 && difference <= 3.50){

						random = Math.floor(Math.random()* (arrayPulsation.length-2)) + 1 ;
						
						moyenne = (arrayPulsation[random] + arrayPulsation[random+1])/2;					
						arrayPulsation.splice(random, 0, moyenne);	
						arrayPulsation.splice(random+1, 2);// on enlève les deux valeurs
						
						moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random+1])/2;
						arrayVolumeTidal.splice(random, 0, moyenne);	
						arrayVolumeTidal.splice(random+1, 2);	
						
						moyenne = (arrayRespiration[random] + arrayRespiration[random+1])/2;
						arrayRespiration.splice(random, 0, moyenne);	
						arrayRespiration.splice(random+1, 2);	
						
						moyenne = (arrayVentilation[random] + arrayVentilation[random+1])/2;
						arrayVentilation.splice(random, 0, moyenne);	
						arrayVentilation.splice(random+1, 2);	
						
					}
					// On augmente 
					else if (difference >= 2.50 && difference <= 3.0){

						random = Math.floor(Math.random()* (arrayPulsation.length-2)) + 1 ;
						
						moyenne = (arrayPulsation[random] + arrayPulsation[random+1])/2;
						arrayPulsation.splice(random+1, 0, moyenne);
						
						moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random+1])/2;
						arrayVolumeTidal.splice(random+1, 0, moyenne);	
						
						moyenne = (arrayRespiration[random] + arrayRespiration[random+1])/2;
						arrayRespiration.splice(random+1, 0, moyenne);	
						
						moyenne = (arrayVentilation[random] + arrayVentilation[random+1])/2;
						arrayVentilation.splice(random+1, 0, moyenne);		
						
					}
					//alert("difference "+difference );
					difference = difference = arrayPulsation.length / arraySpeed.length;

				}
			
			}
			//alert("arrayPulsation après " + arrayPulsation.length);
			//alert("arrayVolumeTidal après " + arrayVolumeTidal.length);

			
			
		}
		
	/**
	 * Method to add heart rate information
	 */
	function addHeartRate(){
	
		modifyLists();
		
		var multiple = 0 ;
		multiple = arrayPulsation.length / arraySpeed.length;		
		var number = 0 ;
		var multi  ;


		if (multiple <= 2.5){
			number = 2;
			multi = 2 ;
		}
		else if (multiple <= 3.5 && multiple > 2.5 ) {
			number = 3 ;
			multi = 3 ;
		}
		
		 // Add HEART RATE markers if the user want it
			for(var j = 0 ; j < arraySpeed.length ; j++){	
				
				var markerPuls ;
		 
				// Now add the content of the popup
				  var contentStringSpeeds = '<div id="content">'+
			      '<div id="siteNotice">'+
			      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
			      '<div id="bodyContent">'+
			      '<table class="table">' + 
			      '<TR>'+
			      '<TD>' + '<span title="Vitesse km/h" style="font-size:11pt;" class="glyphicon glyphicon-heart">' + arrayPulsation[number].toString() +  '</span>' +'</TD>' +
			      '</TR>' +
			      '</table>'+
			      '</div>'+
			      '</div>'+
			      '</div>';
			      
			      // add content text html
				  var myinfowindow  = new google.maps.InfoWindow({
				      content: contentStringSpeeds
				  });
			      				
				  if (arrayPulsation[number] <= 80 ){
					  var hhlow = 'img/h1.png';
					  var markerPosition = new google.maps.LatLng(arrayLat[j],arrayLong[j]);
					  markerPuls = new google.maps.Marker({
							position: markerPosition,
				    		animation: google.maps.Animation.DROP,
							infowindow: myinfowindow ,
							icon : hhlow
						});  
				  }
				  else if (arrayPulsation[number] > 80 && arrayPulsation[number] <= 150){
					  var hhmid = 'img/h2.png';
					  var markerPosition = new google.maps.LatLng(arrayLat[j],arrayLong[j]);
					  markerPuls = new google.maps.Marker({
							position: markerPosition,
				    		animation: google.maps.Animation.DROP,
							infowindow: myinfowindow ,
							icon : hhmid
						});
				  }
				  
				  else if (arrayPulsation[number] > 150){
					  var hhfast = 'img/h3.png';
					  var markerPosition = new google.maps.LatLng(arrayLat[j],arrayLong[j]);
					  markerPuls = new google.maps.Marker({
							position: markerPosition,
				    		animation: google.maps.Animation.DROP,
							infowindow: myinfowindow ,
							icon : hhfast
						});	
				  }
				  // Listener
				  google.maps.event.addListener(markerPuls, 'click', function() {
					  this.infowindow.open(map, this);
				  });
				  
				  number += multi ;
				  markerPuls.setMap(map);				  
			}
	}
	
	function addConstanceHeart(){
		
		modifyLists();
		
		var pointarray;
		var HeartConstant = new Array();
		
		var number = 0 ;
		var multi ;
		var multiple = 0 ;
		
		multiple = arrayPulsation.length / arraySpeed.length;
		
		if (multiple <= 2.5){
			number = 2;
			multi = 2 ;
		}
		else if (multiple <= 3.5 && multiple > 2.5 ) {
			number = 3 ;
			multi = 3 ;
		}
		//alert("arraySpeed " +arraySpeed.length);
		//alert("arrayPulsation " +arrayPulsation.length);
		// Heart rate, show if the workout was performant (same speed more or less) 
		for(var p = 0 ; p < arraySpeed.length ; p++ ){	

			//Create array of location
			if(arrayPulsation[number] <= 80){	  
				HeartConstant[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 10};
			}		
			else if(arrayPulsation[number] > 80 && arrayPulsation[number] <= 150 ) {
				HeartConstant[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 100};								
			}
			else if(arrayPulsation[number] > 150) {
				HeartConstant[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 1000};								
			}
			
			  number += multi ;
		}
		
		  var gradient = [
		                  'rgba(0, 255, 255, 0)',
		                  'rgba(0, 255, 255, 1)',
		                  'rgba(0, 191, 255, 1)',
		                  'rgba(0, 127, 255, 1)',
		                  'rgba(0, 63, 255, 1)',
		                  'rgba(0, 0, 255, 1)',
		                  'rgba(0, 0, 223, 1)',
		                  'rgba(0, 0, 191, 1)',
		                  'rgba(0, 0, 159, 1)',
		                  'rgba(0, 0, 127, 1)',
		                  'rgba(63, 0, 91, 1)',
		                  'rgba(127, 0, 63, 1)',
		                  'rgba(191, 0, 31, 1)',
		                  'rgba(255, 0, 0, 1)'
		                ]



		  pointArray = new google.maps.MVCArray(HeartConstant);
			
		  heatmap = new google.maps.visualization.HeatmapLayer({
			    data: pointArray
			  });
		  

		  heatmap.set('gradient', gradient); // bleu
		  heatmap.set('radius', 20);
		  
		  // add heatmap
		  heatmap.setMap(map);
		
	}
	
	/**
	 * Method to add infos marker (all information)
	 */
	function addAllInfos(){

		modifyLists();
		
		
		var number = 0 ;
		var multi = 0 ;
		var multiple = 0 ;
		multiple = arrayPulsation.length / arraySpeed.length;

		if (multiple <= 2.5){
			number = 2;
			multi = 2 ;
		}
		else if (multiple <= 3.5 && multiple > 2.5 ) {
			number = 3 ;
			multi = 3 ;
		}
		
		for(var i = 0 ; i < arraySpeed.length ; i ++ ){	
			
			
		    var arrayMarkers = new Array();
			
			// Now add the content of the popup
			  var contentStrings = '<div id="content">'+
		      '<div id="siteNotice">'+
		      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
		      '<div id="bodyContent">'+
		      '<table class="table">' + 
		      '<TR>'+
		      '<TD>' + '<span title="Vitesse km/h" style="font-size:10pt;" class="glyphicon glyphicon-flash">' + '&nbsp;' + arraySpeed[i].toString() +  '</span>' +
		      '<br>' +
		       '<span title="Altitude mètre" style="font-size:10pt;" class="glyphicon glyphicon-signal">'+ '&nbsp;'  +  arrayAlti[i].toString()  +'</span>' +
		      '<br>' +
		       '<span title="Pulsation min" style="font-size:10pt;" class="glyphicon glyphicon-heart">' + '&nbsp;' + arrayPulsation[number].toString() +  '</span>' +
		      '<br>' +
		       '<span title="Volume tidal" style="font-size:10pt;" class="glyphicon glyphicon-stats">' + '&nbsp;'+ (arrayVolumeTidal[number]/1000).toFixed(2) +  '</span>' +
		      '<br>' +
		       '<span title="Respiration fréquence" style="font-size:10pt;" class="glyphicon glyphicon-transfer">'+ '&nbsp;' + arrayRespiration[number].toString() +  '</span>' +
		      '<br>' +
		      '<span title="Ventilation min" style="font-size:10pt;" class="glyphicon glyphicon-sort-by-attributes">'+ '&nbsp;' + (arrayVentilation[number]/1000).toFixed(2)  +  '</span>' +'</TD>' +
		      '</TR>' +
		      '</table>'+
		      '</div>'+
		      '</div>'+
		      '</div>';
		      
			  var markerPosition = new google.maps.LatLng(arrayLat[i],arrayLong[i]);
			  var image = 'img/info_marker.png';

		      arrayMarkers[i] = new google.maps.Marker({
		        position: markerPosition,
		        icon : image,
	    		animation: google.maps.Animation.DROP,
		        map: map
		      });
		      		      
		      arrayMarkers[i].infowindow = new google.maps.InfoWindow({
		    	  content: contentStrings,
		    	  maxWidth: 120
		    	});
			  			  		      
			  // Listener
			  google.maps.event.addListener(arrayMarkers[i], 'click', function() {
				  this.infowindow.open(map, this);
			  });
			  
			  number += multi ;
			  arrayMarkers[i].setMap(map);
		}
	}
	
	
	/**
	 * Method to add speed infos
	 */
	function addSpeed() {

		for(var k = 0 ; k < arraySpeed.length ; k ++){	
			 
			var markerSpeed ;
			
			// Now add the content of the popup
			  var contentStringSpeeds = '<div id="content">'+
		      '<div id="siteNotice">'+
		      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
		      '<div id="bodyContent">'+
		      '<table class="table">' + 
		      '<TR>'+
		      '<TD>' + '<span title="Vitesse km/h" style="font-size:11pt;" class="glyphicon glyphicon-flash">' + arraySpeed[k].toString() +  '</span>' +'</TD>' +
		      '</TR>' +
		      '</table>'+
		      '</div>'+
		      '</div>'+
		      '</div>';
		      
		      // add content text html
			  var myinfowindow  = new google.maps.InfoWindow({
			      content: contentStringSpeeds
			  });
		      				
			  if (arraySpeed[k] <= 6.0 ){
				  var speedLowImg = 'img/Speedlow.png';
				  var markerPosition = new google.maps.LatLng(arrayLat[k],arrayLong[k]);
				  markerSpeed = new google.maps.Marker({
						position: markerPosition,
			    		animation: google.maps.Animation.DROP,
						infowindow: myinfowindow ,
						icon : speedLowImg
					});  
			  }
			  else if (arraySpeed[k] > 6.0 && arraySpeed[k] <= 12.0){
				  var speedMidImg = 'img/SpeedMiddle.png';
				  var markerPosition = new google.maps.LatLng(arrayLat[k],arrayLong[k]);
				  markerSpeed = new google.maps.Marker({
						position: markerPosition,
			    		animation: google.maps.Animation.DROP,
						infowindow: myinfowindow ,
						icon : speedMidImg
					});
			  }
			  
			  else if (arraySpeed[k] > 12.0){
				  var speedFastImg = 'img/SpeedMax.png';
				  var markerPosition = new google.maps.LatLng(arrayLat[k],arrayLong[k]);
				  markerSpeed = new google.maps.Marker({
						position: markerPosition,
			    		animation: google.maps.Animation.DROP,
						infowindow: myinfowindow ,
						icon : speedFastImg
					});	
			  }
			  // Listener
			  google.maps.event.addListener(markerSpeed, 'click', function() {
				  this.infowindow.open(map, this);
			  });
			  
			  markerSpeed.setMap(map);
		}	
	}
	
	/**
	 * Method to add speed constance
	 */
		function addConstanceSpeed(){
		
			var pointarray;
			var speedConstant = new Array();
			
			// Heart rate, show if the workout was performant (same speed more or less) 
			for(var p = 0 ; p < arraySpeed.length ; p ++ ){	
					
				//Create array of location
				if(arraySpeed[p] <= 3.0){	  
					speedConstant[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 10};
				}		
				else if(arraySpeed[p] > 3.0 && arraySpeed[p] <= 6 ) {
					speedConstant[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 100};								
				}
				else if(arraySpeed[p] > 6.0 && arraySpeed[p] <= 9 ) {
					speedConstant[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 500};								
				}
				else if(arraySpeed[p] > 9.0 && arraySpeed[p] <= 12.0 ) {
					speedConstant[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 1000};								
				}
				else if(arraySpeed[p] > 12.0) {
					speedConstant[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 1500};								
				}
			}

			  pointArray = new google.maps.MVCArray(speedConstant);
				
			  heatmap = new google.maps.visualization.HeatmapLayer({
				    data: pointArray
				  });
			  

			  //heatmap.set('gradient', gradient); // bleu
			  heatmap.set('radius', 20);
			  // add heatmap
			  heatmap.setMap(map);
	}
	
	/**
	*Method to add the start and end point to the path
	*/
	function addStartStop(){
		
	     var imageStart = 'img/dd-start.png';
	     var imageEnd = 'img/dd-end.png';

	  	var endMarker = new google.maps.LatLng(arrayLat[arrayLat.length-1],arrayLong[arrayLong.length-1]);	
		markerEnd = new google.maps.Marker({
    		position: endMarker,
    		animation: google.maps.Animation.DROP,
    		title:"END",
    		icon: imageEnd
		});
		
	  	var startMarker = new google.maps.LatLng(arrayLat[0],arrayLong[0]);	
		markerStart = new google.maps.Marker({
    		position: startMarker,
    		animation: google.maps.Animation.DROP,
    		title:"START",
    		icon: imageStart,
		});
		
		 // Add the two markers
		 markerEnd.setMap(map);
		 markerStart.setMap(map);  	
		
	}
	
	/**
	*Method to remove the start/end point 
	*/
	function removeStartEndPoint(){	
		markerStart.setMap(null);
		markerEnd.setMap(null);
	}
	
	
	/**
	*Method to add the path to the map 
	*/
	function addPath(){
		
			// Path NORMAL
				for( var i = 0 ; i < arrayLat.length; i++ ){
						planCoordinates[i] = new google.maps.LatLng(arrayLat[i] , arrayLong[i]);
				}
				
				pathStyle= new google.maps.Polyline({
					path : planCoordinates,
					geodesic : true,
					strokeColor : "#000000",
					strokeOpacity : 1,
					strokeWeight : 4
				});
				pathStyle.setMap(map);	
	}
	
	/**
	*Method to remove the path to the map 
	*/
	function removePath(){
		pathStyle.setMap(null);
	}

</script>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="img/icoFav.png">

<title>HexoSkin-Dashboard</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-3.1.1/dist/css/bootstrap.min.css">
<link href="bootstrap-3.1.1/dist/css/dashboard.css" rel="stylesheet">

</head>

<body>

	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="dashboard">HexoSkin</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="profile.jsp">Profile</a></li>
					<li><a href="javascript:logout();">Logout</a></li>
					<li><a href="about.jsp">About</a></li>
				</ul>
				<form class="navbar-form navbar-right"></form>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar titreNavigation">
					<li class="active"><a href="dashboard">Dashboard</a></li>
					<li><a href="compare">Comparer</a></li>
					<li><a href="historique.jsp">Historique</a></li>
				    <li><a href="definition.jsp">Définitions</a></li>
				</ul>
			</div>

			<%
				List<String> listWorkout  ;
				String dateToShow = "" ;
				 RestInvokerDatastore rest = new RestInvokerDatastore();
				// Test if we have something in param 
				if(request.getParameter("date") != null){
					dateToShow = request.getParameter("date");
					listWorkout = rest.getDataWorkoutByEmailAndDate(dateToShow,
							"vincentpont@gmail.com");
				}
			     // If not we show the last workout
				else{
					dateToShow = lastDateWorkout;
					listWorkout = rest.getDataWorkoutByEmailAndDate(dateToShow,
							"vincentpont@gmail.com");
				}
			%>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h3 class="page-header">Séance</h3>

			    <span title="Date" style="font-size:20pt;" class="glyphicon glyphicon-calendar"></span>  &nbsp;
				<span title="Date" style="font-size:14pt;" > <% out.print(dateToShow.substring(0, 10));  %> à  <% out.print(dateToShow.substring(11, 16));  %>  </span>

				<table class="table">
				<TR>
					<TD title="Temps" class="success">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-time"></span> 
						<span style="font-size:14pt; font-family:Verdana;"> <% out.print(listWorkout.get(1)); %> </span>
					</TD> 
						
					<TD  title="Distance en mètre"  class="success">				
						<span  style="font-size:21pt;" class="glyphicon glyphicon-sort"></span> 
						 <span style="font-size:14pt; font-family:Verdana;">  <% out.print(listWorkout.get(2)); %> </span>
					</TD>
						
					<TD title="Calories brûlées" class="success">
						<span style="font-size:21pt;" class="glyphicon glyphicon-fire"></span>	
						 <span style="font-size:14pt; font-family:Verdana;">&nbsp;  <% out.print(listWorkout.get(3)); %></span>
					</TD>
						
					<TD title="Vitesse moyenne en km/h" class="success">
						<span style="font-size:21pt;" class="glyphicon glyphicon-flash"></span>	
						 <span style="font-size:14pt; font-family:Verdana;">&nbsp;  <% out.print(listWorkout.get(4)); %> </span>	
											
					</TD>
						
					<TD title="Altitude moyenne en mètre" class="success">
						<span style="font-size:21pt;" class="glyphicon glyphicon-signal"></span>	
						 <span style="font-size:14pt; font-family:Verdana;">&nbsp; <% out.print(rest.getAltitudeAverage(listAltitude)); %> </span>				
					</TD>
				</TR>
		

			<%	
			String s1s = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";
			RestInvokerHexo restHEXO = new RestInvokerHexo(s1s);
			String dateHEXO = "" ;
			
			// Test if we have something in param 
			if(request.getParameter("date") != null){
				dateHEXO = request.getParameter("date");
				dateHEXO = dateHEXO.substring(0, 10);
				dateHEXO = dateHEXO.replace('.', '-');
			}
		     // If not we show the last workout
			else{
				dateHEXO = lastDateWorkout;
				dateHEXO = dateHEXO.substring(0, 10);
				dateHEXO = dateHEXO.replace('.', '-');
			}
			
			List<String> listPulsation = restHEXO.returnAllValueFromJson(dateHEXO, "19");
			List<String> listSteps = restHEXO.returnAllValueFromJson(dateHEXO, "52");
			List<String> listBreathing = restHEXO.returnAllValueFromJson(dateHEXO, "33");
			List<String> listVentilation = restHEXO.returnAllValueFromJson(dateHEXO, "36");
			List<String> listVolumeTidal = restHEXO.returnAllValueFromJson(dateHEXO, "37");
			
			String avgTidal  = restHEXO.getAverageFromList(listVolumeTidal);
			String volumTidal = restHEXO.changeMltoLwith2Decimals(avgTidal);
			
			String avgVentilation  = restHEXO.getAverageFromList(listVentilation);
			String ventilation = restHEXO.changeMltoLwith2Decimals(avgVentilation);

			%>
			
				<TR>
					<TD title="Pulsation moyenne" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-heart"></span>						
						<span style="font-size:14pt; font-family:Verdana;"><% out.print(restHEXO.getAverageFromList(listPulsation));  %> </span>	
					</TD> 
					
					<TD  title="Total pas" class="info">				
						<span style="font-size:21pt;" class="glyphicon glyphicon-road"></span>						
					    <span style="font-size:14pt; font-family:Verdana;"><% out.print(listSteps.get(listSteps.size()-1));  %> </span>	
					</TD>
					
					<TD title="Volume Tidal moyen l/inspiration" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-stats"></span>						
						<span style="font-size:14pt; font-family:Verdana;">&nbsp; <%  out.print(volumTidal);   %> </span>	
					</TD>
					
					<TD title="Respiration min moyenne" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-transfer"></span>						
						<span style="font-size:14pt; font-family:Verdana;">&nbsp; <% out.print(restHEXO.getAverageFromList(listBreathing));   %> </span>	
					</TD>
					
					<TD title="Ventilation moyenne l/min)" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
						<span style="font-size:14pt; font-family:Verdana;">&nbsp; <%  out.print(ventilation);  %>  </span>	
					</TD>
				</TR>
				</table>
	</div>		
				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<h3 class="page-header">Carte
				<span  style="font-size:20pt;" class="glyphicon glyphicon-map-marker"></span>
				</h3>

				<br>
				
				
				<div class="row">
  					<div class="col-xs-12 col-md-8">			
				  		<div id="map-canvas" style="width:100%;height:400px;"></div>			  		
  					</div>
  							
  					<div class="col-xs-6 col-md-4">
  
  					<h5> <b> Filtres </b> </h5> 
 <br>
  						<table>
						<TR>
							<TD>
							<button title="Enlever le chemin de la carte." type='button' class="btn btn-default btn-sm" onclick="removePath();"><b>Chemin</b></button>	
							<button title="Enlever les points de départ et stop."  type='button' class="btn btn-default btn-sm" onclick="removeStartEndPoint();"><b>Départ/stop</b></button>	
							</TD>
						</TR>

						<TR>
							<TD>												
							<button title="Montrer toutes les vitesses." style="margin-top:12pt;" type='button' class="btn btn-warning btn-sm" onclick="addSpeed();"><span class="glyphicon glyphicon-flash"></span></button>
							<button title="Montrer si la vitesse est constante." style="margin-top:12pt;"  type='button' class="btn btn-warning btn-sm" onclick="addConstanceSpeed();"><b>Constance</b></button>
							</TD>
						</TR>
										
						<TR>						
							<TD>
							<button title="Montrer toutes les pulsations." style="margin-top:12pt;" type='button' class="btn btn-danger btn-sm" onclick="addHeartRate();"><span class="glyphicon glyphicon-heart"></span></button>	
							<button title="Montrer si les pulsations sont constantes." style="margin-top:12pt;" type='button' class="btn btn-danger btn-sm" onclick="addConstanceHeart();"><b>Constance</b></button>
							</TD>
						</TR>
							
						<TR>
							<TD>	
							<button title="Montrer toutes les données de la séances." style="margin-top:12pt;" type='button' class="btn btn-info btn-sm" onclick="addAllInfos();"><span class="glyphicon glyphicon-info-sign"></span></button>
							</TD>
						</TR>

					</table>
<br><br>					
					<button  title="Recharger la carte et réinitialiser." style="margin-top:15pt;" type='button' class="btn btn-success" onclick="initialize();"> <b> <span class="glyphicon glyphicon-refresh"> </span>  &nbsp; Recharger  </b></button>
  </div>

				</div>	
<br>				
			<h5> <b> Légendes </b>  </h5>
<br>				
			<table>
			<TR>
			
				<TD> <span style="font-style:italic; font-size:10pt;"> Chemin du trajet : &nbsp; </span>
				<img title="Tracé du chemin de la séance parcourue." src="img/path.png"/> 
				
<br>
			    
			    <span style="font-style:italic; font-size:10pt;"> Point début/stop :  </span>
				<img title="Point de départ." src="img/dd-start.png"/> 
				<img title="Point d'arrivée." src="img/dd-end.png"/> 
				
 <br>
 				
				 <span style="font-style:italic; font-size:10pt;"> Degré des pulsations : </span>
				<img title="Vitesse basse" src="img/h1.png"/>  <span style="font-size:10pt;"><%out.print("<b>< </b>"); %>85</span>  
				<img title="Vitesse moyenne" src="img/h2.png"/>  <span style="font-size:10pt;">entre 85 et 150 </span>
				<img title="Vitesse haute" src="img/h3.png"/>  <span style="font-size:10pt;"><%out.print("<b>> </b>"); %> 150</span>
 <br>			
				 <span style="font-style:italic; font-size:10pt;"> Degré des vitesses :   </span>

				<img title="Vitesse basse" src="img/Speedlow.png"/>  <span style="font-size:10pt;"><%out.print("<b>< </b>"); %>6</span>   
				<img title="Vitesse moyenne" src="img/SpeedMiddle.png"/> <span style="font-size:10pt;">entre 6 et 12 </span>
				<img title="Vitesse haute" src="img/SpeedMax.png"/> <span style="font-size:10pt;"><%out.print("<b>> </b>"); %> 12</span>
 <br>				
				
				 <span style="font-style:italic; font-size:10pt;"> Détails séance.  </span>
				<img title="Données de la séance." src="img/info_marker.png"/> 

    
		    
			    </TD>
			    
			</TR>
			</table>	
				
					
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

					<h3 class="page-header">Graphiques </h3>


																	
						<div class="row">

			  				<div id="chart_div2" style="width: 100%; height: 500px;"></div>									

								<table>
									<TR>
										<TD>
										<button style="margin-left:150px;" title="Cacher la vitesse" class="btn btn-default btn-sm" type="button" id="hideSpeed"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Vitesse</button>
										<button  title="Cacher l'altitue" class="btn btn-default btn-sm" type="button" id="hideAltitude"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Altitude</button>				   					
				   						<button  title="Cacher la pulsation" class="btn btn-default btn-sm" type="button" id="hidePulsation"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Pulsation</button>
										<button  title="Cacher le volume tidal" class="btn btn-default btn-sm" type="button" id="hideTidal"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Volume ti. </button>
										<button  title="Cacher la respiration" class="btn btn-default btn-sm" type="button" id="hideRespiration"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Repiration</button>
										<button  title="Cacher la ventilation" class="btn btn-default btn-sm" type="button" id="hideVentilation"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Ventilation</button>
				   						<button  title="Voir tout" class="btn btn-default btn-sm" type="button" id="seeAll"> &nbsp; <span class="glyphicon glyphicon-eye-open"></span> &nbsp;</button>
										</TD>
									</TR>
								</table>

					</div>
					 
			

		</div>
	</div>
	

<div class="row">
		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<hr>
		<footer>
			<p>
				<b>Copyright ©2014 HexoSkin Travail bachelor. Tous droits
					réservés.</b>
			</p>
		</footer>
		</div>
	</div>
	
</div>

	<span id="signinButton" style="display: none"> <span
		class="g-signin" data-callback="signinCallback"
		data-clientid="799362622292-cisd7bgllvoo1pckcsm38smvl9ec1m60.apps.googleusercontent.com"
		data-cookiepolicy="single_host_origin"
		data-requestvisibleactions="http://schemas.google.com/AddActivity"
		data-scope="https://www.googleapis.com/auth/plus.login"> </span>
	</span>

	<!-- Bootstrap core JavaScript -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="bootstrap-3.1.1/dist/js/bootstrap.min.js"></script>
	<script src="bootstrap-3.1.1/docs/assets/js/docs.min.js"></script>

</body>
</html>
