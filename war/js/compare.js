/* ========================================================================
 * Travail de bachelor 2014
 * Author : Vincent Pont
 * Date : 1 juillet 2014
 * File javascript that create Google charts and Google maps for compare page.
 * ========================================================================
 * HES-SO Valais/Wallis
 * ======================================================================== */

/**
 * Method that test if the user select two dates to compare them if not we don't
 * allow submit form.
 */
function testChoice() {
	var test1 = document.getElementById("selecte1").value;
	var test2 = document.getElementById("selecte2").value;
	if (test1 != '' && test2 !== '') {
		return true;
	} else {
		alert("Veuillez sélectionner 2 séances svp.");
		return false;
	}
}

/**
 * Method that change de color of a
 * <TD> workout if he is more or less than the value of the other workout. We
 * say that the two workouts is the same path to compare the performance
 */
function changeColor() {
	var value1;
	var value2;

	// Bigger is the heart rate = good training
	// Pulsation
	value1 = parseFloat(document.getElementById('puls1SP').innerHTML);
	value2 = parseFloat(document.getElementById('puls2SP').innerHTML);
	if (value1 > value2) {
		document.getElementById('puls1TD').style.color = "rgb(0,205,0)";
		document.getElementById('puls1TD').style.fontWeight = 'bold';
	} else if (value2 > value1) {
		document.getElementById('puls2TD').style.color = "rgb(0,205,0)";
		document.getElementById('puls2TD').style.fontWeight = 'bold';
	}

	// Vitesse
	// Bigger is the speed = good training
	value1 = parseFloat(document.getElementById('speed1SP').innerHTML);
	value2 = parseFloat(document.getElementById('speed2SP').innerHTML);

	if (value1 > value2) {
		document.getElementById('speed1SP').style.color = "rgb(0,205,0)"; // vert
		document.getElementById('speed1SP').style.fontWeight = 'bold';
	} else if (value2 > value1) {
		document.getElementById('speed2SP').style.color = "rgb(0,205,0)"; // vert
		document.getElementById('speed2SP').style.fontWeight = 'bold';
	}

	// Calories
	// Bigger is calories = good training
	value1 = parseFloat(document.getElementById('ca1SP').innerHTML);
	value2 = parseFloat(document.getElementById('ca2SP').innerHTML);

	if (value1 > value2) {
		document.getElementById('ca1TD').style.color = "rgb(0,205,0)"; // vert
		document.getElementById('ca1TD').style.fontWeight = 'bold';

	} else if (value2 > value1) {
		document.getElementById('ca2TD').style.color = "rgb(0,205,0)"; // vert
		document.getElementById('ca2TD').style.fontWeight = 'bold';
	}

	// Temps
	// Less is the time = good training
	value1 = document.getElementById('time1SP').innerHTML;
	value2 = document.getElementById('time2SP').innerHTML;
	value1 = value1.replace(":", "");
	value2 = value2.replace(":", "");

	if (parseInt(value1) > parseInt(value2)) {
		document.getElementById('time2TD').style.color = "rgb(0,205,0)"; // vert
		document.getElementById('time2TD').style.fontWeight = 'bold';
	} else if (parseInt(value2) > parseInt(value1)) {
		document.getElementById('time1TD').style.color = "rgb(0,205,0)"; // vert
		document.getElementById('time1TD').style.fontWeight = 'bold';
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
		center : new google.maps.LatLng(arrayLat1[0], arrayLong1[0]),
		mapTypeId : google.maps.MapTypeId.PLAN
	};

	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

	// Add by default the two paths and marker of the path1
	addPaths();
	addMarkerPath1();

}

/**
 * Method to add differences of heart rate on the path
 */
function addDiffHeart() {
	
	modifyLists(arrayPulsation1, arraySpeed1);
	modifyLists(arrayPulsation2, arraySpeed1);

	var markerDiffPuls;
	var markerPosition;
	var pulsImg;
	var namePath;

	// Test the differences vitesses
	var diffPuls;
	var diffPulsStr;

	var number;
	var multi;

	multiple = arrayPulsation1.length / arraySpeed1.length;

	if (multiple <= 2.5) {
		number = 2;
		multi = 2;
	} else if (multiple <= 3.5 && multiple > 2.5) {
		number = 3;
		multi = 3;
	}

	// Differences pulsation
	for (var k = 0; k < arraySpeed1.length; k++) {

		if (arrayPulsation1[number] > arrayPulsation2[number]) {
			// Set position
			markerPosition = new google.maps.LatLng(arrayLat1[k], arrayLong1[k]);
			diffPuls = arrayPulsation1[number] - arrayPulsation2[number];

			// Test value of the differences to add the right icon img
			if (diffPuls <= 20) {
				pulsImg = 'img/h1.png';
			} else if (diffPuls > 20 && diffPuls <= 40) {
				pulsImg = 'img/h2.png';
			} else if (diffPuls > 40) {
				pulsImg = 'img/h3.png';
			}

			diffPulsStr = diffPuls.toString() + ' puls.';
			namePath = "Trajet 1";
		} else {
			markerPosition = new google.maps.LatLng(arrayLat2[k], arrayLong2[k]);
			diffPuls = arrayPulsation2[number] - arrayPulsation1[number];

			// Test value of the differences to add the right icon img
			if (diffPuls <= 20) {
				pulsImg = 'img/h1.png';
			} else if (diffPuls > 20 && diffPuls <= 50) {
				pulsImg = 'img/h2.png';
			} else if (diffPuls > 50) {
				pulsImg = 'img/h3.png';
			}

			diffPulsStr = diffPuls.toString() + ' puls.';
			namePath = "Trajet 2";
		}

		// Now add the content of the popup
		var contentStringPuls = '<div id="content">'
				+ '<div id="siteNotice">'
				+ '<div id="bodyContent">'
				+ '<span  style="font-size:10pt; white-space: nowrap;" >'
				+ namePath.toString()
				+ '</span>'
				+ '</br>'
				+ '<span title="Vitesse en km/h" style="font-size:10pt; white-space: nowrap;">'
				+ '<b>+</b>' + diffPulsStr.toString() + '</span>' + '</div>'
				+ '</div>' + '</div>';

		// add content text html
		var myinfowindow = new google.maps.InfoWindow({
			content : contentStringPuls
		});

		markerDiffPuls = new google.maps.Marker({
			position : markerPosition,
			animation : google.maps.Animation.DROP,
			infowindow : myinfowindow,
			icon : pulsImg
		});

		// Listener
		google.maps.event.addListener(markerDiffPuls, 'click', function() {
			this.infowindow.open(map, this);
		});

		// show only if there is a differences

		number += multi;
		markerDiffPuls.setMap(map);
	}
}

/**
 * Method to modify the list to be more accurate to 2 or 3 for maps
 */
function modifyLists(arrayPulsations, arraySpeeds) {
	var arrayPulsation = arrayPulsations;
	var arraySpeed = arraySpeeds;
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

			}

			// On rajout une valeur (moyenne) entre deux valeurs
			else if (difference >= 1.50 && difference < 2.00) {

				random = Math
						.floor(Math.random() * (arrayPulsation.length - 2)) + 1;

				moyenne = (arrayPulsation[random] + arrayPulsation[random + 1]) / 2;
				arrayPulsation.splice(random + 1, 0, moyenne);

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
				arrayPulsation.splice(random + 1, 2);// on enlève les deux valeurs
			}
			// On augmente
			else if (difference >= 2.50 && difference <= 3.0) {

				random = Math
						.floor(Math.random() * (arrayPulsation.length - 2)) + 1;

				moyenne = (arrayPulsation[random] + arrayPulsation[random + 1]) / 2;
				arrayPulsation.splice(random + 1, 0, moyenne);

			}

			difference = difference = arrayPulsation.length / arraySpeed.length;
		}
	}
}

/**
 * Method to add differences of Speeds on the path
 */
function addDiffSpeed() {

	// Differences vitesses
	for (var k = 0; k < arraySpeed1.length; k++) {

		var markerDiffSpeed;
		var markerPosition;
		var speedImg;
		var namePath;

		// Test the differences vitesses
		var diffSpeeds;
		var diffSpeedStr;

		if (arraySpeed1[k] > arraySpeed2[k]) {

			// Set position
			markerPosition = new google.maps.LatLng(arrayLat1[k], arrayLong1[k]);
			diffSpeeds = arraySpeed1[k] - arraySpeed2[k];
			diffSpeeds = diffSpeeds.toFixed(2);

			// Test value of the differences to add the right icon img
			if (diffSpeeds <= 3.0) {
				speedImg = 'img/Speedlow.png';
			} else if (diffSpeeds > 3.0 && diffSpeeds <= 6.0) {
				speedImg = 'img/SpeedMiddle.png';
			} else if (diffSpeeds > 6.0) {
				speedImg = 'img/SpeedMax.png';
			}

			diffSpeedStr = diffSpeeds.toString()+' km/h';
			namePath = "Trajet 1";
		} else {

			markerPosition = new google.maps.LatLng(arrayLat2[k], arrayLong2[k]);
			diffSpeeds = arraySpeed2[k] - arraySpeed1[k];
			diffSpeeds = diffSpeeds.toFixed(2);

			// Test value of the differences to add the right icon img
			if (diffSpeeds <= 3.0) {
				speedImg = 'img/Speedlow.png';
			} else if (diffSpeeds > 3.0 && diffSpeeds <= 6.0) {
				speedImg = 'img/SpeedMiddle.png';
			} else if (diffSpeeds > 6.0) {
				speedImg = 'img/SpeedMax.png';
			}

			diffSpeedStr = diffSpeeds.toString() + ' km/h';
			namePath = "Trajet 2";
		}

		// Now add the content of the popup
		var contentStringSpeeds = '<div id="content">'
				+ '<div id="siteNotice">'
				+ '<div id="bodyContent">'
				+ '<span  style="font-size:10pt; white-space: nowrap;" >'
				+ namePath.toString()
				+ '</span>'
				+ '</br>'
				+ '<span title="Vitesse en km/h" style="font-size:10pt; white-space: nowrap;">'
				+ '<b>+</b> ' + diffSpeedStr.toString() + '</span>' + '</div>'
				+ '</div>' + '</div>';

		// add content text html
		var myinfowindow = new google.maps.InfoWindow({
			content : contentStringSpeeds
		});

		markerDiffSpeed = new google.maps.Marker({
			position : markerPosition,
			animation : google.maps.Animation.DROP,
			infowindow : myinfowindow,
			icon : speedImg
		});

		// Listener
		google.maps.event.addListener(markerDiffSpeed, 'click', function() {
			this.infowindow.open(map, this);
		});

		// show only if there is a differences

		markerDiffSpeed.setMap(map);

	}
}

/**
 * Method to add the two paths to the map
 */
function addPaths() {

	// Path 1
	var planCoordinates1 = new Array();

	for (var j = 0; j < arrayLat1.length; j++) {
		planCoordinates1[j] = new google.maps.LatLng(arrayLat1[j],
				arrayLong1[j]);
	}

	pathStyle1 = new google.maps.Polyline({
		path : planCoordinates1,
		geodesic : true,
		strokeColor : "#000000",
		strokeOpacity : 1,
		strokeWeight : 4
	});

	pathStyle1.setMap(map);

	// Path 2
	var planCoordinates2 = new Array();

	for (var i = 0; i < arrayLat2.length; i++) {
		planCoordinates2[i] = new google.maps.LatLng(arrayLat2[i],
				arrayLong2[i]);
	}

	pathStyle2 = new google.maps.Polyline({
		path : planCoordinates2,
		geodesic : true,
		strokeColor : "#1201FD",
		strokeOpacity : 1,
		strokeWeight : 4
	});

	pathStyle2.setMap(map);
}

function addMarkerPath1() {

	var imageStart = 'img/dd-start.png';
	var imageEnd = 'img/dd-end.png';

	var endMarker = new google.maps.LatLng(arrayLat1[arrayLat1.length - 1],
			arrayLong1[arrayLong1.length - 1]);
	markerEnd = new google.maps.Marker({
		position : endMarker,
		animation : google.maps.Animation.DROP,
		title : "END",
		icon : imageEnd
	});

	var startMarker = new google.maps.LatLng(arrayLat1[0], arrayLong1[0]);
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
 * Method to remove the start/end point of path 1
 */
function removeStartEndPointPath1() {
	markerStart.setMap(null);
	markerEnd.setMap(null);
}

/**
 * Method to remove the paths to the map
 */
function removePaths() {
	pathStyle1.setMap(null);
	pathStyle2.setMap(null);
}

/*
 * ============== GOOGLE CHARTS ==============
 * =========================================
 * =========================================
 * =========================================
 */

/**
 * Method that create the charts speed alti 1
 */
function drawChartSpeed1() {

	var dateFormatter = new google.visualization.DateFormat({
		pattern : 'HH:mm:ss'
	})

	// Get time
	var minutesTime = timeTotal1.substring(0, 1);
	var secondesTime = timeTotal1.substring(2, 4);

	// Convert to milliseconds
	var minToMs = (minutesTime * 60) * 1000;
	var secToMs = secondesTime * 1000;
	var totalMilliseconds = minToMs + secToMs;

	// Get number of data
	var numberData = arrayVitesses1.length - 1;

	// Divide number of milliseconds by data to know time that was record the
	// data (in ms)
	var msToMultiple = totalMilliseconds / numberData;

	var data = new google.visualization.DataTable();
	data.addColumn('datetime', "Temps");
	data.addColumn('number', 'Altitude dam');
	data.addColumn('number', 'Vitesse km/h');

	// Add values and converte it ml to l
	for (var i = 0; i < arrayVitesses1.length; i++) {
		data.addRow([ new Date(00, 00, 00, 00, 00, 00, i * msToMultiple),
				arrayAltitude1[i] / 10, arrayVitesses1[i] ]);
	}

	dateFormatter.format(data, 0);

	var options = {
		colors : [ '#1A9F3B', '#FF7700' ],
		hAxis : {
			title : 'Temps',
			format : 'HH:mm:ss',
			gridlines : {
				count : arrayVitesses1.length - 1
			},
		},
		vAxis : {
			title : 'Valeurs'
		},
		title : 'Vitesses / Altitudes'
	};

	var chart = new google.visualization.AreaChart(document
			.getElementById('chart_div1'));

	chart.draw(data, options);

	var hideSpeed1 = document.getElementById("hideSpeed1");
	hideSpeed1.onclick = function() {
		hideSpeed1.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHideSpeedAlti1.splice(indexSpeedAlti1, 0, 2);
		if (arrayToHideSpeedAlti1.length < 2) {
			view.hideColumns(arrayToHideSpeedAlti1);
		}
		chart.draw(view, options);
		indexSpeedAlti1++;
	}

	var hideAlti1 = document.getElementById("hideAlti1");
	hideAlti1.onclick = function() {
		hideAlti1.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHideSpeedAlti1.splice(indexSpeedAlti1, 0, 1);
		if (arrayToHideSpeedAlti1.length < 2) {
			view.hideColumns(arrayToHideSpeedAlti1);
		}
		chart.draw(view, options);
		indexSpeedAlti1++;
	}

	// See all
	var seeAll1 = document.getElementById("seeAll1");
	seeAll1.onclick = function() {
		view = new google.visualization.DataView(data);
		arrayToHideSpeedAlti1.length = 0;
		view.setColumns([ 0, 1, 2 ]);
		chart.draw(view, options);
		hideSpeed1.disabled = false;
		hideAlti1.disabled = false;

	}

}

/**
 * Method that create charts puls,resp,venti,tidal.. 1
 */
function drawChartResp1() {

	var dateFormatter = new google.visualization.DateFormat({
		pattern : 'HH:mm:ss'
	})

	// Get time
	var minutesTime = timeTotal1.substring(0, 1);
	var secondesTime = timeTotal1.substring(2, 4);

	// Convert to milliseconds
	var minToMs = (minutesTime * 60) * 1000;
	var secToMs = secondesTime * 1000;
	var totalMilliseconds = minToMs + secToMs;

	// Get number of data
	var numberData = arrayPulsation1.length - 1;

	// Divide number of milliseconds by data to know time that was record the
	// data (in ms)
	var msToMultiple = totalMilliseconds / numberData;

	var data = new google.visualization.DataTable();
	data.addColumn('datetime', "Temps");
	data.addColumn('number', 'Pulsation min');
	data.addColumn('number', 'Respiration min');
	data.addColumn('number', 'Ventilation l/min');
	data.addColumn('number', 'Volume Ti. l');

	// Add values and converte it ml to l
	for (var i = 0; i < arrayPulsation1.length; i++) {

		arrayVentilation1[i] = parseFloat((arrayVentilation1[i] / 1000)
				.toFixed(2));
		arrayVolumeTidal1[i] = parseFloat((arrayVolumeTidal1[i] / 1000)
				.toFixed(2));

		data.addRow([ new Date(00, 00, 00, 00, 00, 00, i * msToMultiple),
				arrayPulsation1[i], arrayRespiration1[i], arrayVentilation1[i],
				arrayVolumeTidal1[i] ]);
	}

	dateFormatter.format(data, 0);

	var options = {
		colors : [ '#FF0007', '#960DF9', '#0C1A69', '#46FDCF' ],
		hAxis : {
			title : 'Temps',
			format : 'HH:mm:ss',
			gridlines : {
				count : arrayPulsation1.length - 1
			},
		},
		vAxis : {
			title : 'Valeurs'
		},
		title : 'Capacité thoracique'
	};

	var chart = new google.visualization.AreaChart(document
			.getElementById('chart_div3'));

	chart.draw(data, options);

	var hidePuls1 = document.getElementById("hidePulsation1");
	hidePuls1.onclick = function() {
		hidePuls1.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHide1.splice(index1, 0, 1);
		if (arrayToHide1.length < 4) {
			view.hideColumns(arrayToHide1);
		}

		chart.draw(view, options);
		index1++;
	}

	var hideRespi1 = document.getElementById("hideRespiration1");
	hideRespi1.onclick = function() {
		hideRespi1.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHide1.splice(index1, 0, 2);
		if (arrayToHide1.length < 4) {
			view.hideColumns(arrayToHide1);
		}

		chart.draw(view, options);
		index1++;
	}

	var hideVenti1 = document.getElementById("hideVentilation1");
	hideVenti1.onclick = function() {
		hideVenti1.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHide1.splice(index1, 0, 3);
		if (arrayToHide1.length < 4) {
			view.hideColumns(arrayToHide1);
		}

		chart.draw(view, options);
		index1++;
	}

	var hideVolumT1 = document.getElementById("hideVolumeTidal1");
	hideVolumT1.onclick = function() {
		hideVolumT1.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHide1.splice(index1, 0, 4);
		if (arrayToHide1.length < 4) {
			view.hideColumns(arrayToHide1);
		}

		chart.draw(view, options);
		index1++;
	}

	// See all
	var seeAll3 = document.getElementById("seeAll3");
	seeAll3.onclick = function() {
		view = new google.visualization.DataView(data);
		arrayToHide1.length = 0;
		view.setColumns([ 0, 1, 2, 3, 4 ]);
		chart.draw(view, options);
		hideVolumT1.disabled = false;
		hideVenti1.disabled = false;
		hideRespi1.disabled = false;
		hidePuls1.disabled = false;
	}
}

/**
 * Method that create charts speed alti 2
 */
function drawChartSpeed2() {

	var dateFormatter = new google.visualization.DateFormat({
		pattern : 'HH:mm:ss'
	})
	var arrayToHideSpeedAlti2 = new Array();
	var indexSpeedAlti2 = 0;

	// Get time
	var minutesTime = timeTotal2.substring(0, 1);
	var secondesTime = timeTotal2.substring(2, 4);

	// Convert to milliseconds
	var minToMs = (minutesTime * 60) * 1000;
	var secToMs = secondesTime * 1000;
	var totalMilliseconds = minToMs + secToMs;

	// Get number of data
	var numberData = arrayVitesses2.length - 1;

	// Divide number of milliseconds by data to know time that was record the
	// data (in ms)
	var msToMultiple = totalMilliseconds / numberData;

	var data = new google.visualization.DataTable();
	data.addColumn('datetime', "Temps");
	data.addColumn('number', 'Altitude dam');
	data.addColumn('number', 'Vitesse km/h');

	// Add values and converte it ml to l
	for (var i = 0; i < arrayVitesses2.length; i++) {
		data.addRow([ new Date(00, 00, 00, 00, 00, 00, i * msToMultiple),
				arrayAltitudes2[i] / 10, arrayVitesses2[i] ]);
	}

	dateFormatter.format(data, 0);

	var options = {
		colors : [ '#1A9F3B', '#FF7700' ],
		hAxis : {
			title : 'Temps',
			format : 'HH:mm:ss',
			gridlines : {
				count : arrayVitesses2.length - 1
			},
		},
		vAxis : {
			title : 'Valeurs'
		},
		title : 'Vitesses / Altitudes'
	};

	var chart = new google.visualization.AreaChart(document
			.getElementById('chart_div2'));
	chart.draw(data, options);

	var hideSpeed2 = document.getElementById("hideSpeed2");
	hideSpeed2.onclick = function() {
		hideSpeed2.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHideSpeedAlti2.splice(indexSpeedAlti2, 0, 2);
		if (arrayToHideSpeedAlti2.length < 2) {
			view.hideColumns(arrayToHideSpeedAlti2);
		}
		chart.draw(view, options);
		indexSpeedAlti2++;
	}

	var hideAlti2 = document.getElementById("hideAlti2");
	hideAlti2.onclick = function() {
		hideAlti2.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHideSpeedAlti2.splice(indexSpeedAlti2, 0, 1);
		if (arrayToHideSpeedAlti2.length < 2) {
			view.hideColumns(arrayToHideSpeedAlti2);
		}
		chart.draw(view, options);
		indexSpeedAlti2++;
	}

	// See all
	var seeAll2 = document.getElementById("seeAll2");
	seeAll2.onclick = function() {
		view = new google.visualization.DataView(data);
		arrayToHideSpeedAlti2.length = 0;
		view.setColumns([ 0, 1, 2 ]);
		chart.draw(view, options);
		hideSpeed2.disabled = false;
		hideAlti2.disabled = false;

	}

}

/**
 * Method that create charts resp, puls, venti.. 2
 */
function drawChartResp2() {

	var dateFormatter = new google.visualization.DateFormat({
		pattern : 'HH:mm:ss'
	})
	// Get time
	var minutesTime = timeTotal2.substring(0, 1);
	var secondesTime = timeTotal2.substring(2, 4);

	// Convert to milliseconds
	var minToMs = (minutesTime * 60) * 1000;
	var secToMs = secondesTime * 1000;
	var totalMilliseconds = minToMs + secToMs;

	// Get number of data
	var numberData = arrayPulsation2.length - 1;

	// Divide number of milliseconds by data to know time that was record the
	// data (in ms)
	var msToMultiple = totalMilliseconds / numberData;

	var data = new google.visualization.DataTable();
	data.addColumn('datetime', "Temps");
	data.addColumn('number', 'Pulsation min');
	data.addColumn('number', 'Respiration min');
	data.addColumn('number', 'Ventilation l/min');
	data.addColumn('number', 'Volume Ti. l');

	// Add values and converte it ml to l
	for (var i = 0; i < arrayPulsation2.length; i++) {

		arrayVentilation2[i] = parseFloat((arrayVentilation2[i] / 1000)
				.toFixed(2));
		arrayVolumeTidal2[i] = parseFloat((arrayVolumeTidal2[i] / 1000)
				.toFixed(2));

		data.addRow([ new Date(00, 00, 00, 00, 00, 00, i * msToMultiple),
				arrayPulsation2[i], arrayRespiration2[i], arrayVentilation2[i],
				arrayVolumeTidal2[i] ]);
	}

	dateFormatter.format(data, 0);

	var options = {
		colors : [ '#FF0007', '#960DF9', '#0C1A69', '#46FDCF' ],
		hAxis : {
			title : 'Temps',
			format : 'HH:mm:ss',
			gridlines : {
				count : arrayPulsation2.length - 1
			},
		},
		vAxis : {
			title : 'Valeurs'
		},
		title : 'Capacité thoracique'
	};

	// Draw the chart
	var chart = new google.visualization.AreaChart(document
			.getElementById('chart_div4'));
	chart.draw(data, options);

	// Listener of buttons
	var hidePuls2 = document.getElementById("hidePulsation2");
	hidePuls2.onclick = function() {
		hidePuls2.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHide.splice(index, 0, 1);
		if (arrayToHide.length < 4) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	var hideRespi2 = document.getElementById("hideRespiration2");
	hideRespi2.onclick = function() {
		hideRespi2.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHide.splice(index, 0, 2);
		if (arrayToHide.length < 4) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	var hideVent2 = document.getElementById("hideVentilation2");
	hideVent2.onclick = function() {
		hideVent2.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHide.splice(index, 0, 3);
		if (arrayToHide.length < 4) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	var hideVoluT2 = document.getElementById("hideVolumeTidal2");
	hideVoluT2.onclick = function() {
		hideVoluT2.disabled = true;
		view = new google.visualization.DataView(data);
		arrayToHide.splice(index, 0, 4);
		if (arrayToHide.length < 4) {
			view.hideColumns(arrayToHide);
		}

		chart.draw(view, options);
		index++;
	}

	// See all
	var seeAll4 = document.getElementById("seeAll4");
	seeAll4.onclick = function() {
		view = new google.visualization.DataView(data);
		arrayToHide.length = 0;
		view.setColumns([ 0, 1, 2, 3, 4 ]);
		chart.draw(view, options);
		hideVoluT2.disabled = false;
		hideVent2.disabled = false;
		hideRespi2.disabled = false;
		hidePuls2.disabled = false;
	}
}
