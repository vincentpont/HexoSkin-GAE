/* ========================================================================
 * Travail de bachelor 2014
 * Author : Vincent Pont
 * Date : 1 juillet 2014
 * File javascript that create Google charts and Google maps for index page.
 * ========================================================================
 * HES-SO Valais/Wallis
 * ======================================================================== */

/* ============ GOOGLE CHARTS ==============
 *  =========================================
 *  =========================================
 *  =========================================
 */

/**
 * Method that draw the charts
 */
function drawChart() {

	// Call method to modify the lists
	modifyListFirstTime();

	multiple = arrayPulsation.length / arrayVitesses.length;
	var average = 0.0;
	var index = 0;
	var position = 0;

	// Ici on ajoute des valeurs par rapport si la liste de pulsation et 2 ou 3
	// fois plus grandes

	// Ca on fait qu'une fois que nos liste sont bien corrigées (proche de 2 ou
	// 3)
	if (multiple <= 2.5) {
		// Double speed array with averages
		for (var f = 0; f < arrayPulsation.length; f++) {
			// only pairs
			if (index % 2 == 0) {
				average = (arrayAltitudes[index] + arrayAltitudes[index + 2]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayAltitudes.splice(index + 1, 0, average);
			}
			index++;
		}
	} else if (multiple <= 3.5 && multiple > 2.5) {
		// Double speed array with averages
		for (var f = 0; f < arrayPulsation.length; f++) {

			// add first value
			if (f == 0) {

				// add first number
				average = (arrayAltitudes[f] + arrayAltitudes[f + 3]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayAltitudes.splice(f + 1, 0, average);

				// Second number
				average = (arrayAltitudes[f + 1] + arrayAltitudes[3]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayAltitudes.splice(f + 2, 0, average);
			}

			// add all others values by multiple of 3 (we miss 2 data of 3 if
			// the size is 3x bigger)
			if (position % 3 == 0) {

				// add first average number
				average = (arrayAltitudes[position] + arrayAltitudes[position + 3]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayAltitudes.splice(f + 1, 0, average);

				// Second average number
				average = (arrayAltitudes[position + 1] + arrayAltitudes[position + 3]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayAltitudes.splice(f + 2, 0, average);

			}

			position++;
		}
	}

	// Reinitialize
	average = 0.0;
	index = 0;
	position = 0;

	// Add values in array Vitesses to be the same size to the pulsation array

	if (multiple <= 2.5) {
		// Double speed array with averages
		for (var f = 0; f < arrayPulsation.length; f++) {
			// only pairs
			if (index % 2 == 0) {
				average = (arrayVitesses[index] + arrayVitesses[index + 2]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayVitesses.splice(index + 1, 0, average);
			}
			index++;
		}
	}

	else if (multiple <= 3.5 && multiple > 2.5) {
		// Double speed array with averages
		for (var f = 0; f < arrayPulsation.length; f++) {

			// add first value
			if (f == 0) {

				// add first number
				average = (arrayVitesses[f] + arrayVitesses[f + 3]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayVitesses.splice(f + 1, 0, average);

				// Second number
				average = (arrayVitesses[f + 1] + arrayVitesses[3]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayVitesses.splice(f + 2, 0, average);
			}

			// add all others values by multiple of 3 (we miss 2 data of 3 if
			// the size is 3x bigger)
			if (position % 3 == 0) {

				// add first number
				average = (arrayVitesses[position] + arrayVitesses[position + 3]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayVitesses.splice(f + 1, 0, average);

				// Second number
				average = (arrayVitesses[position + 1] + arrayVitesses[position + 3]) / 2;
				average = average.toFixed(2);
				average = parseFloat(average);
				arrayVitesses.splice(f + 2, 0, average);

			}

			position++;
		}
	}

	var dateFormatter = new google.visualization.DateFormat({
		pattern : 'HH:mm:ss'
	})

	var data = new google.visualization.DataTable();
	data.addColumn('datetime', "Temps");
	data.addColumn('number', 'Vitesse km/h');
	data.addColumn('number', 'Altitude dam');
	data.addColumn('number', 'Pulsation min');
	data.addColumn('number', 'Volume Ti. l');
	data.addColumn('number', 'Respiration min');
	data.addColumn('number', 'Ventilation l/min');

	// A améliorer si on a des heures
	// "2:34"
	// Get time
	var minutesTime = timeTotal.substring(0, 1);
	var secondesTime = timeTotal.substring(2, 4);

	// Convert to milliseconds
	var minToMs = (minutesTime * 60) * 1000;
	var secToMs = secondesTime * 1000;
	var totalMilliseconds = minToMs + secToMs; // 154 000

	// Get number of data
	var numberData = arrayPulsation.length - 1; // 225

	// Divide number of milliseconds by data to know time that was record the
	// data (in ms)
	var msToMultiple = totalMilliseconds / numberData; // 684

	// Add values
	for (var i = 0; i < arrayPulsation.length; i++) {

		// Convert and decimals 2
		arrayVentilation[i] = parseFloat((arrayVentilation[i] / 1000)
				.toFixed(2));
		arrayVolumeTidal[i] = parseFloat((arrayVolumeTidal[i] / 1000)
				.toFixed(2));

		data
				.addRow([ new Date(00, 00, 00, 00, 00, 00, i * msToMultiple),
						arrayVitesses[i], arrayAltitudes[i] / 10,
						arrayPulsation[i], arrayVolumeTidal[i],
						arrayRespiration[i], arrayVentilation[i] ]);

	}
	dateFormatter.format(data, 0);

	var options = {
		colors : [ '#FF7700', '#00B125', '#FF0007', '#46FDCF', '#960DF9',
				'#0C1A69' ],
		hAxis : {
			title : 'Temps',
			format : 'HH:mm:ss',
			gridlines : {
				count : arrayPulsation.length - 1
			},
			titleTextStyle : {
				color : '#333'
			}
		},
		vAxis : {
			title : 'Valeurs',
			minValue : 0
		},
	};

	// Draw chart
	var chart = new google.visualization.AreaChart(document
			.getElementById('chart_div2'));
	chart.draw(data, options);

	var arrayToHide = new Array();
	var index = 0;

	// Listener of buttons
	var hideSpeed = document.getElementById("hideSpeed");
	hideSpeed.onclick = function() {
		// disable button
		hideSpeed.disabled = true;
		view = new google.visualization.DataView(data);

		arrayToHide.splice(index, 0, 1);
		if (arrayToHide.length < 6) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	var hideAlti = document.getElementById("hideAltitude");
	hideAlti.onclick = function() {
		hideAlti.disabled = true;
		view = new google.visualization.DataView(data);

		arrayToHide.splice(index, 0, 2);
		if (arrayToHide.length < 6) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	var hideSal = document.getElementById("hidePulsation");
	hideSal.onclick = function() {
		hideSal.disabled = true;
		view = new google.visualization.DataView(data);

		arrayToHide.splice(index, 0, 3);
		if (arrayToHide.length < 6) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	var hideTidal = document.getElementById("hideTidal");
	hideTidal.onclick = function() {
		hideTidal.disabled = true;
		view = new google.visualization.DataView(data);

		arrayToHide.splice(index, 0, 4);
		if (arrayToHide.length < 6) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	var hideRespiration = document.getElementById("hideRespiration");
	hideRespiration.onclick = function() {
		hideRespiration.disabled = true;
		view = new google.visualization.DataView(data);

		arrayToHide.splice(index, 0, 5);
		if (arrayToHide.length < 6) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	var hideVentilation = document.getElementById("hideVentilation");
	hideVentilation.onclick = function() {
		hideVentilation.disabled = true;
		view = new google.visualization.DataView(data);

		arrayToHide.splice(index, 0, 6);
		if (arrayToHide.length < 6) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	// See all
	var seeAll = document.getElementById("seeAll");
	seeAll.onclick = function() {
		view = new google.visualization.DataView(data);
		arrayToHide.length = 0;
		view.setColumns([ 0, 1, 2, 3, 4, 5, 6 ]);
		chart.draw(view, options);

		// Enabled all buttons
		hideSpeed.disabled = false;
		hideAlti.disabled = false;
		hideSal.disabled = false;
		hideTidal.disabled = false;
		hideRespiration.disabled = false;
		hideVentilation.disabled = false;
	}

}

/**
 * Method that modify the list to have the same size to pass into the graph
 */
function modifyListFirstTime() {

	var random;
	var moyenne;
	// Ici on va corrgier les tailles des listes pour qu'elle soit le plus
	// proche d'un chiffre entier pour
	// par la suite rajouter plus facilement de valeurs

	var difference = arrayPulsation.length / arrayVitesses.length;

	if (difference > 1.50 && difference <= 2.50) {
		// Tant que la différence de taille est plus grand que 1.90
		while (difference >= 1.90) {

			// on augmente les valeurs avec des moyenne dans la vitesses pour
			// réduire l'écart 2.2 -> 2.0
			if (difference >= 1.90 && difference < 2.50) {
				// We don't want to begin at 3 start or end points
				random = Math.floor(Math.random() * (arrayVitesses.length - 3)) + 3; // we
																						// take
																						// a
																						// random
																						// position
																						// to
																						// add
																						// new
																						// values
																						// to
																						// incement
																						// size
																						// of
																						// array
				moyenne = (arrayVitesses[random] + arrayVitesses[random + 1]) / 2;
				arrayVitesses.splice(random + 1, 0, moyenne);

				// same with array of altitudes
				moyenne = (arrayAltitudes[random] + arrayAltitudes[random + 1]) / 2;
				arrayAltitudes.splice(random + 1, 0, moyenne);
			}
			// On augmente pulsation donc 2.8 -> 3.0
			else if (difference >= 1.50 && difference <= 1.90) {

				random = Math
						.floor(Math.random() * (arrayPulsation.length - 3)) + 3; // we
																					// take
																					// a
																					// random
																					// position
																					// to
																					// add
																					// new
																					// values
																					// to
																					// incement
																					// size
																					// of
																					// array
				moyenne = (arrayPulsation[random] + arrayPulsation[random + 1]) / 2;
				arrayPulsation.splice(random + 1, 0, moyenne);

				// And add too in the others list if not we have more data in
				// pulsation
				moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random + 1]) / 2;
				arrayVolumeTidal.splice(random + 1, 0, moyenne);

				moyenne = (arrayRespiration[random] + arrayRespiration[random + 1]) / 2;
				arrayRespiration.splice(random + 1, 0, moyenne);

				moyenne = (arrayVentilation[random] + arrayVentilation[random + 1]) / 2;
				arrayVentilation.splice(random + 1, 0, moyenne);

			}

			difference = difference = arrayPulsation.length
					/ arrayVitesses.length;
		}
	}

	else if (difference > 2.50 && difference <= 3.50) {

		// Tant que on a est pas entre (2.9 a 3.10) pour maximum de précision
		while (difference <= 2.90 || difference >= 3.00) {
			// on augmente vitesses donc 2.2 ->2.0
			if (difference >= 2.90 && difference < 3.50) {

				random = Math.floor(Math.random() * (arrayVitesses.length - 3)) + 3;// we
																					// take
																					// a
																					// random
																					// position
																					// to
																					// add
																					// new
																					// values
																					// to
																					// incement
																					// size
																					// of
																					// array
				moyenne = (arrayVitesses[random] + arrayVitesses[random + 1]) / 2;
				arrayVitesses.splice(random + 1, 0, moyenne);

				// same with array of altitudes
				moyenne = (arrayAltitudes[random] + arrayAltitudes[random + 1]) / 2;
				arrayAltitudes.splice(random + 1, 0, moyenne);

			}
			// On augmente pulsation donc 2.8 -> 3.0
			else if (difference >= 2.50 && difference < 2.90) {

				random = Math
						.floor(Math.random() * (arrayPulsation.length - 3)) + 3;// we
																				// take
																				// a
																				// random
																				// position
																				// to
																				// add
																				// new
																				// values
																				// to
																				// incement
																				// size
																				// of
																				// array
				moyenne = (arrayPulsation[random] + arrayPulsation[random + 1]) / 2;
				arrayPulsation.splice(random + 1, 0, moyenne);

				// And add too in the others list if not we have more data in
				// pulsation
				moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random + 1]) / 2;
				arrayVolumeTidal.splice(random + 1, 0, moyenne);

				moyenne = (arrayRespiration[random] + arrayRespiration[random + 1]) / 2;
				arrayRespiration.splice(random + 1, 0, moyenne);

				moyenne = (arrayVentilation[random] + arrayVentilation[random + 1]) / 2;
				arrayVentilation.splice(random + 1, 0, moyenne);
			}

			difference = difference = arrayPulsation.length
					/ arrayVitesses.length;

		}

	}

}

/*
 * ============== GOOGLE MAPS ==============
 * =========================================
 * =========================================
 * =========================================
 */

/**
 * Method to initalize the map
 */
function initialize() {

	var mapOptions = {
		zoom : 16,
		center : new google.maps.LatLng(arrayLat[0], arrayLong[0]),
		mapTypeId : google.maps.MapTypeId.PLAN
	};

	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

	// Add by default the path
	addPath();
	addStartStop();

}

/**
 * Method to modify the list to be more accurate to 2 or 3 for maps
 */
function modifyLists() {

	var random;
	var moyenne;

	// Ici on va corrgier les tailles encore plus des listes pour qu'elle soit
	// le plus proche d'un chiffre entier (2,3)
	var difference = arrayPulsation.length / arraySpeed.length;

	if (difference > 1.50 && difference <= 2.50) {
		// Tant que la différence de taille est plus grand que 1.90
		while (difference > 2.00) {

			// on enlève deux valeurs mais on mets une moyenne des deux enlever
			// à la place
			if (difference > 2.00 && difference <= 2.50) {

				random = Math
						.floor(Math.random() * (arrayPulsation.length - 2)) + 1;

				moyenne = (arrayPulsation[random] + arrayPulsation[random + 1]) / 2;
				arrayPulsation.splice(random, 0, moyenne);
				arrayPulsation.splice(random + 1, 2);// on enlève les deux
														// valeurs

				// On fait pareil avec les autres listes
				moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random + 1]) / 2;
				arrayVolumeTidal.splice(random, 0, moyenne);
				arrayVolumeTidal.splice(random + 1, 2);

				moyenne = (arrayRespiration[random] + arrayRespiration[random + 1]) / 2;
				arrayRespiration.splice(random, 0, moyenne);
				arrayRespiration.splice(random + 1, 2);

				moyenne = (arrayVentilation[random] + arrayVentilation[random + 1]) / 2;
				arrayVentilation.splice(random, 0, moyenne);
				arrayVentilation.splice(random + 1, 2);
			}

			// On rajout une valeur (moyenne) entre deux valeurs
			else if (difference >= 1.50 && difference < 2.00) {

				random = Math
						.floor(Math.random() * (arrayPulsation.length - 2)) + 1;

				moyenne = (arrayPulsation[random] + arrayPulsation[random + 1]) / 2;
				arrayPulsation.splice(random + 1, 0, moyenne);

				moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random + 1]) / 2;
				arrayVolumeTidal.splice(random + 1, 0, moyenne);

				moyenne = (arrayRespiration[random] + arrayRespiration[random + 1]) / 2;
				arrayRespiration.splice(random + 1, 0, moyenne);

				moyenne = (arrayVentilation[random] + arrayVentilation[random + 1]) / 2;
				arrayVentilation.splice(random + 1, 0, moyenne);

			}
			difference = difference = arrayPulsation.length / arraySpeed.length;
		}
	}

	else if (difference > 2.50 && difference <= 3.50) {

		// Tant que on a est pas entre (2.9 a 3.10) pour maximum de précision
		while (difference < 3.00) {
			// on baisse
			if (difference > 3.00 && difference <= 3.50) {

				random = Math
						.floor(Math.random() * (arrayPulsation.length - 2)) + 1;

				moyenne = (arrayPulsation[random] + arrayPulsation[random + 1]) / 2;
				arrayPulsation.splice(random, 0, moyenne);
				arrayPulsation.splice(random + 1, 2);// on enlève les deux
														// valeurs

				moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random + 1]) / 2;
				arrayVolumeTidal.splice(random, 0, moyenne);
				arrayVolumeTidal.splice(random + 1, 2);

				moyenne = (arrayRespiration[random] + arrayRespiration[random + 1]) / 2;
				arrayRespiration.splice(random, 0, moyenne);
				arrayRespiration.splice(random + 1, 2);

				moyenne = (arrayVentilation[random] + arrayVentilation[random + 1]) / 2;
				arrayVentilation.splice(random, 0, moyenne);
				arrayVentilation.splice(random + 1, 2);

			}
			// On augmente
			else if (difference >= 2.50 && difference <= 3.0) {

				random = Math
						.floor(Math.random() * (arrayPulsation.length - 2)) + 1;

				moyenne = (arrayPulsation[random] + arrayPulsation[random + 1]) / 2;
				arrayPulsation.splice(random + 1, 0, moyenne);

				moyenne = (arrayVolumeTidal[random] + arrayVolumeTidal[random + 1]) / 2;
				arrayVolumeTidal.splice(random + 1, 0, moyenne);

				moyenne = (arrayRespiration[random] + arrayRespiration[random + 1]) / 2;
				arrayRespiration.splice(random + 1, 0, moyenne);

				moyenne = (arrayVentilation[random] + arrayVentilation[random + 1]) / 2;
				arrayVentilation.splice(random + 1, 0, moyenne);

			}

			difference = difference = arrayPulsation.length / arraySpeed.length;
		}
	}
}

/**
 * Method to add heart rate information
 */
function addHeartRate() {

	modifyLists();

	var multiple = 0;
	multiple = arrayPulsation.length / arraySpeed.length;
	var number = 0;
	var multi;

	if (multiple <= 2.5) {
		number = 2;
		multi = 2;
	} else if (multiple <= 3.5 && multiple > 2.5) {
		number = 3;
		multi = 3;
	}

	// Add HEART RATE markers if the user want it
	for (var j = 0; j < arraySpeed.length; j++) {

		var markerPuls;

		// Now add the content of the popup
		var contentStringSpeeds = '<div id="content">'
				+ '<div id="siteNotice">'
				+ '<div id="bodyContent">'
				+ '<span title="Pulsation min" style="font-size:11pt;" class="glyphicon glyphicon-heart">'
				+ arrayPulsation[number].toString() + '</span>' + '</div>'
				+ '</div>' + '</div>';

		// add content text html
		var myinfowindow = new google.maps.InfoWindow({
			content : contentStringSpeeds
		});

		if (arrayPulsation[number] <= 80) {
			var hhlow = 'img/h1.png';
			var markerPosition = new google.maps.LatLng(arrayLat[j],
					arrayLong[j]);
			markerPuls = new google.maps.Marker({
				position : markerPosition,
				animation : google.maps.Animation.DROP,
				infowindow : myinfowindow,
				icon : hhlow
			});
		} else if (arrayPulsation[number] > 80 && arrayPulsation[number] <= 150) {
			var hhmid = 'img/h2.png';
			var markerPosition = new google.maps.LatLng(arrayLat[j],
					arrayLong[j]);
			markerPuls = new google.maps.Marker({
				position : markerPosition,
				animation : google.maps.Animation.DROP,
				infowindow : myinfowindow,
				icon : hhmid
			});
		}

		else if (arrayPulsation[number] > 150) {
			var hhfast = 'img/h3.png';
			var markerPosition = new google.maps.LatLng(arrayLat[j],
					arrayLong[j]);
			markerPuls = new google.maps.Marker({
				position : markerPosition,
				animation : google.maps.Animation.DROP,
				infowindow : myinfowindow,
				icon : hhfast
			});
		}
		// Listener
		google.maps.event.addListener(markerPuls, 'click', function() {
			this.infowindow.open(map, this);
		});

		number += multi;
		markerPuls.setMap(map);
	}
}

/**
 * Add constance heart on the maps
 */
function addConstanceHeart() {

	modifyLists();

	var pointarray;
	var HeartConstant = new Array();

	var number = 0;
	var multi;
	var multiple = 0;

	multiple = arrayPulsation.length / arraySpeed.length;

	if (multiple <= 2.5) {
		number = 2;
		multi = 2;
	} else if (multiple <= 3.5 && multiple > 2.5) {
		number = 3;
		multi = 3;
	}

	// Heart rate, show if the workout was performant (same speed more or less)
	for (var p = 0; p < arraySpeed.length; p++) {

		// Create array of location
		if (arrayPulsation[number] <= 80) {
			HeartConstant[p] = {
				location : new google.maps.LatLng(arrayLat[p], arrayLong[p]),
				weight : 10
			};
		} else if (arrayPulsation[number] > 80 && arrayPulsation[number] <= 150) {
			HeartConstant[p] = {
				location : new google.maps.LatLng(arrayLat[p], arrayLong[p]),
				weight : 100
			};
		} else if (arrayPulsation[number] > 150) {
			HeartConstant[p] = {
				location : new google.maps.LatLng(arrayLat[p], arrayLong[p]),
				weight : 1000
			};
		}

		number += multi;
	}

	var gradient = [ 'rgba(0, 255, 255, 0)', 'rgba(0, 255, 255, 1)',
			'rgba(0, 191, 255, 1)', 'rgba(0, 127, 255, 1)',
			'rgba(0, 63, 255, 1)', 'rgba(0, 0, 255, 1)', 'rgba(0, 0, 223, 1)',
			'rgba(0, 0, 191, 1)', 'rgba(0, 0, 159, 1)', 'rgba(0, 0, 127, 1)',
			'rgba(63, 0, 91, 1)', 'rgba(127, 0, 63, 1)', 'rgba(191, 0, 31, 1)',
			'rgba(255, 0, 0, 1)' ]

	pointArray = new google.maps.MVCArray(HeartConstant);

	heatmap = new google.maps.visualization.HeatmapLayer({
		data : pointArray
	});

	heatmap.set('gradient', gradient); // bleu
	heatmap.set('radius', 20);

	// add heatmap
	heatmap.setMap(map);

}

/**
 * Method to add infos markers (all information)
 */
function addAllInfos() {

	modifyLists();

	var number = 0;
	var multi = 0;
	var multiple = 0;
	multiple = arrayPulsation.length / arraySpeed.length;

	if (multiple <= 2.5) {
		number = 2;
		multi = 2;
	} else if (multiple <= 3.5 && multiple > 2.5) {
		number = 3;
		multi = 3;
	}

	for (var i = 0; i < arraySpeed.length; i++) {

		var arrayMarkers = new Array();

		// Now add the content of the popup
		var contentStrings = '<div id="content">'
				+ '<div id="siteNotice">'
				+ '<div id="bodyContent">'
				+ '<table>'
				+ '<TR>'
				+ '<TD>'
				+ '<span title="Vitesse en km/h" style="font-size:10pt;" class="glyphicon glyphicon-flash">'
				+ '&nbsp;'
				+ arraySpeed[i].toString()
				+ '</span>'
				+ '<br>'
				+ '<span title="Altitude en mètre" style="font-size:10pt;" class="glyphicon glyphicon-signal">'
				+ '&nbsp;'
				+ arrayAlti[i].toString()
				+ '</span>'
				+ '<br>'
				+ '<span title="Pulsation min" style="font-size:10pt;" class="glyphicon glyphicon-heart">'
				+ '&nbsp;'
				+ arrayPulsation[number].toString()
				+ '</span>'
				+ '<br>'
				+ '<span title="Volume tidal l/inspiration" style="font-size:10pt;" class="glyphicon glyphicon-stats">'
				+ '&nbsp;'
				+ arrayVolumeTidal[number].toString()
				+ '</span>'
				+ '<br>'
				+ '<span title="Respiration fréquence/min" style="font-size:10pt;" class="glyphicon glyphicon-transfer">'
				+ '&nbsp;'
				+ arrayRespiration[number].toString()
				+ '</span>'
				+ '<br>'
				+ '<span title="Ventilation l/min" style="font-size:10pt;" class="glyphicon glyphicon-sort-by-attributes">'
				+ '&nbsp;'
				+ arrayVentilation[number].toString()
				+ '</span>'
				+ '</TD>'
				+ '</TR>'
				+ '</table>'
				+ '</div>'
				+ '</div>'
				+ '</div>';

		var markerPosition = new google.maps.LatLng(arrayLat[i], arrayLong[i]);
		var image = 'img/info_marker.png';

		arrayMarkers[i] = new google.maps.Marker({
			position : markerPosition,
			icon : image,
			animation : google.maps.Animation.DROP,
			map : map
		});

		arrayMarkers[i].infowindow = new google.maps.InfoWindow({
			content : contentStrings,
			maxWidth : 120
		});

		// Listener
		google.maps.event.addListener(arrayMarkers[i], 'click', function() {
			this.infowindow.open(map, this);
		});

		number += multi;
		arrayMarkers[i].setMap(map);
	}
}

/**
 * Method to add speed infos markers
 */
function addSpeed() {

	for (var k = 0; k < arraySpeed.length; k++) {

		var markerSpeed;

		// Now add the content of the popup
		var contentStringSpeeds = '<div id="content">'
				+ '<div id="siteNotice">'
				+ '<div id="bodyContent">'
				+ '<span title="Vitesse en km/h" style="font-size:11pt;" class="glyphicon glyphicon-flash">'
				+ arraySpeed[k].toString() + '</span>' + '</div>' + '</div>'
				+ '</div>';

		// add content text html
		var myinfowindow = new google.maps.InfoWindow({
			content : contentStringSpeeds
		});

		if (arraySpeed[k] <= 6.0) {
			var speedLowImg = 'img/Speedlow.png';
			var markerPosition = new google.maps.LatLng(arrayLat[k],
					arrayLong[k]);
			markerSpeed = new google.maps.Marker({
				position : markerPosition,
				animation : google.maps.Animation.DROP,
				infowindow : myinfowindow,
				icon : speedLowImg
			});
		} else if (arraySpeed[k] > 6.0 && arraySpeed[k] <= 12.0) {
			var speedMidImg = 'img/SpeedMiddle.png';
			var markerPosition = new google.maps.LatLng(arrayLat[k],
					arrayLong[k]);
			markerSpeed = new google.maps.Marker({
				position : markerPosition,
				animation : google.maps.Animation.DROP,
				infowindow : myinfowindow,
				icon : speedMidImg
			});
		}

		else if (arraySpeed[k] > 12.0) {
			var speedFastImg = 'img/SpeedMax.png';
			var markerPosition = new google.maps.LatLng(arrayLat[k],
					arrayLong[k]);
			markerSpeed = new google.maps.Marker({
				position : markerPosition,
				animation : google.maps.Animation.DROP,
				infowindow : myinfowindow,
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
 * Method to add speed constance markers
 */
function addConstanceSpeed() {

	var pointarray;
	var speedConstant = new Array();

	// Heart rate, show if the workout was performant (same speed more or less)
	for (var p = 0; p < arraySpeed.length; p++) {

		// Create array of location
		if (arraySpeed[p] <= 3.0) {
			speedConstant[p] = {
				location : new google.maps.LatLng(arrayLat[p], arrayLong[p]),
				weight : 10
			};
		} else if (arraySpeed[p] > 3.0 && arraySpeed[p] <= 6) {
			speedConstant[p] = {
				location : new google.maps.LatLng(arrayLat[p], arrayLong[p]),
				weight : 100
			};
		} else if (arraySpeed[p] > 6.0 && arraySpeed[p] <= 9) {
			speedConstant[p] = {
				location : new google.maps.LatLng(arrayLat[p], arrayLong[p]),
				weight : 500
			};
		} else if (arraySpeed[p] > 9.0 && arraySpeed[p] <= 12.0) {
			speedConstant[p] = {
				location : new google.maps.LatLng(arrayLat[p], arrayLong[p]),
				weight : 1000
			};
		} else if (arraySpeed[p] > 12.0) {
			speedConstant[p] = {
				location : new google.maps.LatLng(arrayLat[p], arrayLong[p]),
				weight : 1500
			};
		}
	}

	pointArray = new google.maps.MVCArray(speedConstant);

	heatmap = new google.maps.visualization.HeatmapLayer({
		data : pointArray
	});

	// heatmap.set('gradient', gradient); // bleu
	heatmap.set('radius', 20);
	// add heatmap
	heatmap.setMap(map);
}

/**
 * Method to add the start and end point to the path
 */
function addStartStop() {

	var imageStart = 'img/dd-start.png';
	var imageEnd = 'img/dd-end.png';

	var endMarker = new google.maps.LatLng(arrayLat[arrayLat.length - 1],
			arrayLong[arrayLong.length - 1]);
	markerEnd = new google.maps.Marker({
		position : endMarker,
		animation : google.maps.Animation.DROP,
		title : "END",
		icon : imageEnd
	});

	var startMarker = new google.maps.LatLng(arrayLat[0], arrayLong[0]);
	markerStart = new google.maps.Marker({
		position : startMarker,
		animation : google.maps.Animation.DROP,
		title : "START",
		icon : imageStart,
	});

	// Add the two markers
	markerEnd.setMap(map);
	markerStart.setMap(map);

}

/**
 * Method to remove the start/end point
 */
function removeStartEndPoint() {
	markerStart.setMap(null);
	markerEnd.setMap(null);
}

/**
 * Method to add the path to the map
 */
function addPath() {

	// Path NORMAL
	for (var i = 0; i < arrayLat.length; i++) {
		planCoordinates[i] = new google.maps.LatLng(arrayLat[i], arrayLong[i]);
	}

	pathStyle = new google.maps.Polyline({
		path : planCoordinates,
		geodesic : true,
		strokeColor : "#000000",
		strokeOpacity : 1,
		strokeWeight : 4
	});
	pathStyle.setMap(map);
}

/**
 * Method to remove the path to the map
 */
function removePath() {

	pathStyle.setMap(null);
}
