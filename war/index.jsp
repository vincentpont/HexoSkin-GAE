<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="restHexoSkin.RestInvokerHexo"%>
<%@ page import="java.util.Iterator, java.util.List, java.util.Date, java.text.DecimalFormat;"%>

<!--  Get Variable servlet -->
<%  String lastDateWorkout = (String) request.getAttribute("lastDateWorkout"); %>

<!-- LOGIN Google</body> -->
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


<script>
	function signinCallback(authResult) {
		if (authResult['access_token']) {
			// Logged
		} else if (authResult['error']) {
			document.getElementById('signinButton').setAttribute('style',
					'display: none');
			window.location = "login.jsp";
		}
	}
</script>

<%  
String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";
RestInvokerHexo restHexo = new RestInvokerHexo(s1); 
RestInvokerDatastore restMap = new RestInvokerDatastore(); 

String restHexoDate = "" ;

// Test if we have something in param 
if(request.getParameter("date") != null){
	restHexoDate = request.getParameter("date");
	restMap.getDataMap("vincentpont@gmail.com", restHexoDate); 
	restHexoDate = restHexoDate.substring(0, 10);
	restHexoDate = restHexoDate.replace('.', '-');
	
}
 // If not we show the last workout
else{ 
	restMap.getDataMap("vincentpont@gmail.com", lastDateWorkout); 
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


%>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">


	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	
	google.setOnLoadCallback(drawChart);
	
	function drawChart() {
		
	    var arrayVitesses = [ <%= stringBufferVitesses.toString() %> ];
	    var arrayAltitudes = [ <%= stringBufferAltitudes.toString() %> ];
	  	var arrayPulsation = [ <%= stringBufferPulsation.toString() %> ];
	    var arrayVolumeTidal = [ <%= stringBufferVolumeTidal.toString() %> ];
	    var arrayRespiration = [ <%= stringBufferRespirationFreq.toString() %> ];
	    var arrayVentilation = [ <%= stringBufferVentilations.toString() %> ];
		
		var data = new google.visualization.DataTable();
		data.addColumn('string', "Enregistrements");
		data.addColumn('number', 'Vitesse km/h');
		data.addColumn('number', 'Altitudes décamètre');
		data.addColumn('number', 'Pulsation min');
		data.addColumn('number', 'Volume Tidale litre');
		data.addColumn('number', 'Respiration min');
		data.addColumn('number', 'Ventilation litre/min');
		
		
	    // Because of the differences of length

	
		 // Add values and converte it ml to l /1000
		  for(var i = 0; i < arrayPulsation.length  ; i++){
		   data.addRow([i.toString(), arrayVitesses[i], arrayAltitudes[i]/10, arrayPulsation[i], (arrayVolumeTidal[i]/1000), 
		                arrayRespiration[i], (arrayVentilation[i]/1000)]);
		
		  }

		var options = {
			colors: ['#FFF800' , '#00B125', '#FF0007', '#46FDCF', '#960DF9', '#0C1A69'],
			hAxis : {
				title: 'Enregistrements',
				titleTextStyle : {
					color : '#333'
				}
			},
			vAxis : {
				title: 'Valeurs',
				minValue : 0
			},
		};
		
		var chart = new google.visualization.AreaChart(document
				.getElementById('chart_div2'));
		chart.draw(data, options);
		
		
		 var hideSpeed = document.getElementById("hideSpeed");
		 hideSpeed.onclick = function()
		 {

		    view = new google.visualization.DataView(data); 
		    view.hideColumns([1]); 
		    chart.draw(view, options);

		 }
		
		var chart = new google.visualization.AreaChart(document
				.getElementById('chart_div2'));
		chart.draw(data, options);
		
		
		 var hideAlti = document.getElementById("hideAltitude");
		 hideAlti.onclick = function()
		 {

		    view = new google.visualization.DataView(data); 
		    view.hideColumns([2]); 
		    chart.draw(view, options);

		 }
		
		
		 var hideSal = document.getElementById("hidePulsation");
		 hideSal.onclick = function()
		 {

		    view = new google.visualization.DataView(data); 
		    view.hideColumns([3]); 
		    chart.draw(view, options);

		 }
		 
		 
		 var hideTidal = document.getElementById("hideTidal");
		 hideTidal.onclick = function()
		 {

		    view = new google.visualization.DataView(data);
		    view.hideColumns([4]);
		    chart.draw(view, options);

		 }	
		 
		 var hideRespiration = document.getElementById("hideRespiration");
		 hideRespiration.onclick = function()
		 {


		    view = new google.visualization.DataView(data);
		    view.hideColumns([5]); 
		    chart.draw(view, options);

		 }	
		 
		 var hideVentilation = document.getElementById("hideVentilation");
		 hideVentilation.onclick = function()
		 {


		    view = new google.visualization.DataView(data);
		    view.hideColumns([6]); 
		    chart.draw(view, options);

		 }	
		 
		 // See all
		 var seeAll = document.getElementById("seeAll");
		 seeAll.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    view.setColumns([0,1,2,3,4,5,6]);
		    chart.draw(view, options);
		 }
		
	}
</script>

<script>
function logout() {
	document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://9-dot-logical-light-564.appspot.com/login.jsp";
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
	
	// Get Average of speed
	List<String> list = restMap.getDataWorkoutByEmailAndDate(lastDateMap, "vincentpont@gmail.com");
	String speedAverage = list.get(4) ;
	
	%>
	
	<!-- Google MAPS -->
<script
	src="https://maps.googleapis.com/maps/api/js?v=3?key={AIzaSyA9MSARpM9GdjunV4sR5mxpOuD3pfkyldc}">
</script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script>
	
<script>

	// Android data
	var arrayLat = [ <%= stringBufferLat.toString() %> ];
	var arrayLong = [ <%= stringBufferLong.toString() %> ];
	var arraySpeed = [ <%= stringBufferSpeed.toString() %> ];
	var arrayAlti = [ <%= stringBufferAlti.toString() %> ];
	var size = arrayLat.length;
	
	// HexoSkin data
	var arrayPulsation = [ <%= stringBufferPulsation.toString() %> ];
	var arrayVolumeTidal = [ <%= stringBufferVolumeTidal.toString() %> ];
	var arrayRespirationFreq = [ <%= stringBufferRespirationFreq.toString() %> ];
	var arrayVentilations = [ <%= stringBufferVentilations.toString() %> ];

	var heatmap;
	var pointarray;
	var taxiData = new Array();
	var map ;

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
		
	   // Add by default the path and start/end point
	   addPath();
	   addStartStop();
					  	
	}
  


	google.maps.event.addDomListener(window, 'resize', initialize);
	google.maps.event.addDomListener(window, 'load', initialize);
	
	/**
	 * Method to add infos marker (all information)
	 */
	function addAllInfos(){
		
		for(var i = 0 ; i < arraySpeed.length ; i ++ ){	
			
		    var arrayMarkers = new Array();
			
			// Now add the content of the popup
			  var contentStrings = '<div id="content">'+
		      '<div id="siteNotice">'+
		      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
		      '<div id="bodyContent">'+
		      '<table class="table">' + 
		      '<TR>'+
		      '<TD>' + '<span title="Vitesse km/h" style="font-size:11pt;" class="glyphicon glyphicon-flash">' + '&nbsp;' + arraySpeed[i].toString() +  '</span>' +
		      '<br>' +
		       '<span title="Altitude mètre" style="font-size:11pt;" class="glyphicon glyphicon-signal">'+ '&nbsp;'  +  arrayAlti[i].toString()  +'</span>' +
		      '<br>' +
		       '<span title="Pulsation min" style="font-size:11pt;" class="glyphicon glyphicon-heart">' + '&nbsp;' + arrayPulsation[i+1].toString() +  '</span>' +
		      '<br>' +
		       '<span title="Volume tidal" style="font-size:11pt;" class="glyphicon glyphicon-stats">' + '&nbsp;'+ arrayVolumeTidal[i+1].toString() +  '</span>' +
		      '<br>' +
		       '<span title="Respiration fréquence" style="font-size:11pt;" class="glyphicon glyphicon-transfer">'+ '&nbsp;' + arrayRespirationFreq[i+1].toString() +  '</span>' +
		      '<br>' +
		      '<span title="Ventilation min" style="font-size:11pt;" class="glyphicon glyphicon-sort-by-attributes">'+ '&nbsp;' + arrayVentilations[i+1].toString() +  '</span>' +'</TD>' +
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
			  google.maps.event.addListener(arrayMarkers[i], 'mouseover', function() {
				  this.infowindow.open(map, this);
			  });
			  
			  arrayMarkers[i].setMap(map);
		}
	}
	
	
	
	/**
	 * Method to add speed constance
	 */
		function addConstanceSpeed(){
		
			var pointarray;
			var taxiData = new Array();
			
			// Heart rate, show if the workout was performant (same speed more or less) 
			for(var p = 0 ; p < arraySpeed.length ; p ++ ){	
					
				//Create array of location
				if(arraySpeed[p] <= 3.0){	  
					taxiData[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 10};
				}		
				else if(arraySpeed[p] > 3.0 && arraySpeed[p] <= 6 ) {
					taxiData[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 100};								
				}
				else if(arraySpeed[p] > 6.0 && arraySpeed[p] <= 9 ) {
					taxiData[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 500};								
				}
				else if(arraySpeed[p] > 9.0 && arraySpeed[p] <= 12.0 ) {
					taxiData[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 1000};								
				}
				else if(arraySpeed[p] > 12.0) {
					taxiData[p] = {location: new google.maps.LatLng(arrayLat[p], arrayLong[p]), weight: 1500};								
				}
			}


			  pointArray = new google.maps.MVCArray(taxiData);
				
			  heatmap = new google.maps.visualization.HeatmapLayer({
				    data: pointArray
				  });
			  

			  //heatmap.set('gradient', gradient); // bleu
			  heatmap.set('radius', 20);
			  // add heatmap
			  heatmap.setMap(map);
	}
	
	/**
	 * Method to add heart rate information
	 */
	function addHeartRate(){
		
		 // Add HEART RATE markers if the user want it
			for(var j = 0 ; j < arraySpeed.length ; j ++){	
				
				var markerPuls ;
		 
				// Now add the content of the popup
				  var contentStringSpeeds = '<div id="content">'+
			      '<div id="siteNotice">'+
			      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
			      '<div id="bodyContent">'+
			      '<table class="table">' + 
			      '<TR>'+
			      '<TD>' + '<span title="Vitesse km/h" style="font-size:11pt;" class="glyphicon glyphicon-flash">' + arrayPulsation[j+1].toString() +  '</span>' +'</TD>' +
			      '</TR>' +
			      '</table>'+
			      '</div>'+
			      '</div>'+
			      '</div>';
			      
			      // add content text html
				  var myinfowindow  = new google.maps.InfoWindow({
				      content: contentStringSpeeds
				  });
			      				
				  if (arrayPulsation[j] <= 80 ){
					  var hhlow = 'img/h1.png';
					  var markerPosition = new google.maps.LatLng(arrayLat[j],arrayLong[j]);
					  markerPuls = new google.maps.Marker({
							position: markerPosition,
				    		animation: google.maps.Animation.DROP,
							infowindow: myinfowindow ,
							icon : hhlow
						});  
				  }
				  else if (arrayPulsation[j] > 85 && arrayPulsation[j] <= 150){
					  var hhmid = 'img/h2.png';
					  var markerPosition = new google.maps.LatLng(arrayLat[j],arrayLong[j]);
					  markerPuls = new google.maps.Marker({
							position: markerPosition,
				    		animation: google.maps.Animation.DROP,
							infowindow: myinfowindow ,
							icon : hhmid
						});
				  }
				  
				  else if (arrayPulsation[j] > 150){
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
				  
				  markerPuls.setMap(map);
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
	*Method to add the start and end point to the path
	*/
	function addStartStop(){
		
	     var imageStart = 'img/dd-start.png';
	     var imageEnd = 'img/dd-end.png';

	  	var endMarker = new google.maps.LatLng(arrayLat[arrayLat.length-1],arrayLong[arrayLong.length-1]);	
		var markerEnd = new google.maps.Marker({
    		position: endMarker,
    		animation: google.maps.Animation.DROP,
    		title:"END",
    		icon: imageEnd
		});
		
	  	var startMarker = new google.maps.LatLng(arrayLat[0],arrayLong[0]);	
		var markerStart = new google.maps.Marker({
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
	*Method to add the path to the map 
	*/
	function addPath(){

		// Pass the value to the array of path
		var planCoordinates= new Array() ;	
		var pathStyle ;
			
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
	*Method to reload the map NOT USED
	*/
	function reloadMap(){
		google.maps.event.trigger(map, 'resize');
	}

</script>

<!--  Test heat -->



<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="img/icoFav.png">

<title>HexoSkin-TB</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="bootstrap-3.1.1/dist/css/bootstrap.min.css">

<!-- Custom styles for this template -->
<link href="bootstrap-3.1.1/dist/css/dashboard.css" rel="stylesheet">

</head>

<body>

	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
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
				List listWorkout  ;
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
		
<br>
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
  						<table>
						<TR>
							<TD>
							

<br>		
							<button  type='button' class="btn btn-primary btn-sm" onclick="addPath();"><b>Chemin</b></button>	
							<button  type='button' class="btn btn-primary btn-sm" onclick="addStartStop();"><b>Départ/Stop</b></button>	
<br>											
							<button style="margin-top:8pt;"  type='button' class="btn btn-primary btn-sm" onclick="addConstanceSpeed();"><b>Constance vitesse</b></button>											
							<button style="margin-top:8pt;" type='button' class="btn btn-primary btn-sm" onclick="addSpeed();"><b>Ajouter vitesses</b></button>
<br>											

							<button style="margin-top:8pt;" type='button' class="btn btn-primary btn-sm" onclick="addHeartRate();"><b>Ajouter pulsation</b></button>
<br>											
							<button style="margin-top:8pt;" type='button' class="btn btn-primary btn-sm" onclick="addAllInfos();"><b>Informations maximales</b></button>
							

<br>
<br>
				     		<button style="margin-top:8pt;" type='button' class="btn btn-success" onclick="initialize();"> <b> <span class="glyphicon glyphicon-refresh"> </span>  &nbsp; Recharger  </b></button>
<br>

							</TD>
						</TR>
					</table>
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
					
			
			  				<div id="chart_div2" style="width: 100%; height: 600px;"></div>
			  		
<br><br>	  				
 										

								<table>
									<TR>
										<TD>
										<button style="margin-left:150px;" title="Cacher la vitesse" class="btn btn-default" type="button" id="hideSpeed"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Vitesse</button>
										<button  title="Cacher l'altitue" class="btn btn-default" type="button" id="hideAltitude"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Altitude</button>				   					
				   						<button  title="Cacher la pulsation" class="btn btn-default" type="button" id="hidePulsation"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Pulsation</button>
										<button  title="Cacher le volume tidal" class="btn btn-default" type="button" id="hideTidal"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Volume ti. </button>
										<button  title="Cacher la respiration" class="btn btn-default" type="button" id="hideRespiration"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Repiration</button>
										<button  title="Cacher la ventilation" class="btn btn-default" type="button" id="hideVentilation"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Ventilation</button>
				   						<button  title="Voir tout" class="btn btn-default" type="button" id="seeAll"> &nbsp; <span class="glyphicon glyphicon-eye-open"></span> &nbsp;</button>
										</TD>
									</TR>
								</table>

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

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="bootstrap-3.1.1/dist/js/bootstrap.min.js"></script>
	<script src="bootstrap-3.1.1/docs/assets/js/docs.min.js"></script>

	<script type="text/javascript">
		signinCallback(authResult);
	</script>

</body>
</html>
