<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="restHexoSkin.RestInvokerHexo"%>
<%@ page import="java.util.Iterator, java.util.List, java.util.Date;"%>
<% 	RestInvokerDatastore restMap = new RestInvokerDatastore(); %>
<%  RestInvokerDatastore rest = new RestInvokerDatastore();%>
<%	String lastDateWorkout = restMap.getLastDateWorkout("vincentpont@gmail.com"); %>

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
String restHexoDate = "" ;

// Test if we have something in param 
if(request.getParameter("date") != null){
	restHexoDate = request.getParameter("date");
	restHexoDate = restHexoDate.substring(0, 10);
	restHexoDate = restHexoDate.replace('.', '-');
	
}
 // If not we show the last workout
else{
	restHexoDate = restMap.getLastDateWorkout("vincentpont@gmail.com"); 
	restHexoDate = restHexoDate.substring(0, 10);
	restHexoDate = restHexoDate.replace('.', '-');
}

List<String> listPulsations = restHexo.returnAllValueFromJson(restHexoDate, "19"); // A CHANGER AVEC PARAM
StringBuffer stringBufferPulsation = new StringBuffer();
stringBufferPulsation = restMap.convertListToStringBufferInteger(listPulsations);


%>
<!-- Google charts Pulsation -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">


	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	
	google.setOnLoadCallback(drawChart);
	
	function drawChart() {
		
	  	var arrayPulsation = [ <%= stringBufferPulsation.toString() %> ];
		
		var data = new google.visualization.DataTable();
		data.addColumn('string', "temps");
		data.addColumn('number', 'pulsation');

		  for(var i = 0; i < arrayPulsation.length ; i++){
		   data.addRow([i.toString(), arrayPulsation[i]]);
		  }

		var options = {
			hAxis : {
				title: 'Temps',
				titleTextStyle : {
					color : '#333'
				}
			},
			vAxis : {
				minValue : 0
			},
		};

		var chart = new google.visualization.AreaChart(document
				.getElementById('chart_div1'));
		chart.draw(data, options);
	}
</script>

<script type="text/javascript">
	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	google.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = google.visualization.arrayToDataTable([
				[ 'Director (Year)', 'Rotten Tomatoes', 'IMDB' ],
				[ 'Alfred Hitchcock (1935)', 8.4, 7.9 ],
				[ 'Ralph Thomas (1959)', 6.9, 6.5 ],
				[ 'Don Sharp (1978)', 6.5, 6.4 ],
				[ 'James Hawes (2008)', 4.4, 6.2 ] ]);

		var options = {
			title : 'The decline of \'The 39 Steps\'',
			vAxis : {
				title : 'Accumulated Rating'
			},
			isStacked : true
		};

		var chart = new google.visualization.SteppedAreaChart(document
				.getElementById('chart_div2'));
		chart.draw(data, options);
	}
</script>


<script>
function logout() {
	document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://8-dot-logical-light-564.appspot.com/login.jsp";
}
</script>



<script
	src="https://maps.googleapis.com/maps/api/js?v=3?key={AIzaSyA9MSARpM9GdjunV4sR5mxpOuD3pfkyldc}">
</script>

	<% 
	
	List listWorkouts  ;
	String lastDateMap = "";
	
	// Test if we have something in param 
	if(request.getParameter("date") != null){
		lastDateMap = request.getParameter("date");
		restMap.getDataMap("vincentpont@gmail.com", lastDateMap); 
	} // If not we show the last workout
	else{
		lastDateMap = restMap.getLastDateWorkout("vincentpont@gmail.com");
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
	
	String meterMarker = "" ;
	
	if(request.getParameter("meterMarker") != null){
		meterMarker = request.getParameter("meterMarker");
	} else {
		meterMarker = "50"; // default
	}
	
	
	%>
	
<script>

    var arrayLat = [ <%= stringBufferLat.toString() %> ];
    var arrayLong = [ <%= stringBufferLong.toString() %> ];
    var arraySpeed = [ <%= stringBufferSpeed.toString() %> ];
    var arrayAlti = [ <%= stringBufferAlti.toString() %> ];
    var size = arrayLat.length;
    var meterMarker = '<%=meterMarker%>';
    meterMarker = parseInt(meterMarker); //parse
    var numberMarker ;
    
    switch(meterMarker) {
    case 5:
    	numberMarker = 1 ;
        break;
    case 10:
    	numberMarker = 2 ;
        break;
    case 25:
    	numberMarker = 5 ;
        break;
    case 50:
    	numberMarker = 10 ;
        break;
    case 100:
    	numberMarker = 20 ;
        break;
    case 250:
    	numberMarker = 50 ;
        break;
    case 500:
    	numberMarker = 100 ;
        break;
    case 1000:
    	numberMarker = 200 ;
        break;
} 
    // Calculate speeds
    var speedAverage = '<%=speedAverage%>';
    var speedNumber = Number(speedAverage.substring(0, speedAverage.search(' '))); 
    var speedMin = 2.00 ;
    var speedUp = 10.00 ;
    
    
	function initialize() {
		var mapOptions = {  
			zoom : 16,
			center : new google.maps.LatLng(arrayLat[0], arrayLong[0]),
			mapTypeId : google.maps.MapTypeId.PLAN
		};

		var map = new google.maps.Map(document.getElementById('map-canvas'),
				mapOptions);
		
		var colorRed  = '#EF0000';
		var colorYellow = '#F3FA24';
		var colorGreen= '#35F627';
					
		// Pass the value to the array of path
		var planCoordinatesGreen= new Array() ;	
		var planCoordinatesYellow= new Array() ;	
		var planCoordinatesRed= new Array() ;	
		var planCoordinates= new Array() ;	
		var pathStyleGreen ;
		var pathStyleYellow ;
		var pathStyleRed ;
		var pathStyle ;
			
			// Path NORMAL
			for( var i = 0 ; i < arrayLat.length; i++ ){
					planCoordinates[i] = new google.maps.LatLng(arrayLat[i] , arrayLong[i]);
			}
			pathStyle= new google.maps.Polyline({
				path : planCoordinates,
				geodesic : true,
				strokeColor : colorRed,
				strokeOpacity : 1,
				strokeWeight : 4
			});
			pathStyle.setMap(map);
			
			/*
			// Path green 
			var countGreen = 0 ;
			var iGreen = 0 ;
			for( var gr = 0 ; gr < arrayLat.length; gr++ ){
				if(arraySpeed[gr] <= 5.0){
					planCoordinatesGreen[iGreen] = new google.maps.LatLng(arrayLat[gr] , arrayLong[gr]);
					iGreen++;
					countGreen++;
				}
			}
			
			if(countGreen >= 2){
				//alert(planCoordinatesGreen.join('\n'))
				pathStyleGreen = new google.maps.Polyline({
					path : planCoordinatesGreen,
					geodesic : true,
					strokeColor : colorGreen,
					strokeOpacity : 1,
					strokeWeight : 4
				});
				pathStyleGreen.setMap(map);
			}
			
			var countYellow = 0 ;
			var iYellow = 0 ;
			// Path yellow
			for( var ye = 0 ; ye < arrayLat.length; ye++ ){
				 if(arraySpeed[ye] >= 5.0){
					planCoordinatesYellow[iYellow] = new google.maps.LatLng(arrayLat[ye] , arrayLong[ye]);
					iYellow++;
					countYellow++;
				}
			}
			if(countYellow >= 2){
				//alert(planCoordinatesYellow.join('\n'))
			pathStyleYellow = new google.maps.Polyline({
				path : planCoordinatesYellow,
				geodesic : true,
				strokeColor : colorYellow,
				strokeOpacity : 1,
				strokeWeight : 4,
				map : map
			}); 
			pathStyleYellow.setMap(map);
			}
			/*
			// Path red
			for( var re = 0 ; re < arrayLat.length; re++ ){
				if(arraySpeed[re] >= speedUp){
					planCoordinatesRed[re] = new google.maps.LatLng(arrayLat[re] , arrayLong[re]);						
				}
			}
			 pathStyleRed = new google.maps.Polyline({
					path : planCoordinatesRed,
					geodesic : true,
					strokeColor : colorRed,
					strokeOpacity : 1.0,
					strokeWeight : 4,
					map : map
				});
			 pathStyleRed.setMap(map);
			 */
		
		
		// Add markers to the path since each 20 locations point
		for(var i = numberMarker ; i < arraySpeed.length ; i += numberMarker ){	
			
			// Now add the content of the popup
			  var contentStrings = '<div id="content">'+
		      '<div id="siteNotice">'+
		      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
		      '<div id="bodyContent">'+
		      '<table class="table">' + 
		      '<TR>'+
		      '<TD>' + '<span title="Vitesse km/h" style="font-size:11pt;" class="glyphicon glyphicon-flash">' + arraySpeed[i].toString() +  '</span>' +'</TD>' +
		      '<TD>' + '<span title="Altitude mètre" style="font-size:11pt;" class="glyphicon glyphicon-signal">'+ '&nbsp;'  +  arrayAlti[i].toString()  +'</span>' +'</TD>' +
		      '</TR>' +
		      '</table>'+
		      '</div>'+
		      '</div>'+
		      '</div>';
		      
		      // add content text html
			  var myinfowindow  = new google.maps.InfoWindow({
			      content: contentStrings
			  });
		      
			  var image = 'img/info_marker.png';
			  var markerPosition = new google.maps.LatLng(arrayLat[i],arrayLong[i]);
			  var marker = new google.maps.Marker({
					position: markerPosition,
		    		animation: google.maps.Animation.DROP,
					infowindow: myinfowindow ,
					icon : image
				});
		      
			  // Listener
			  google.maps.event.addListener(marker, 'click', function() {
				  this.infowindow.open(map, this);
			  });
			  
			  marker.setMap(map);
		}
		
		// Marker end
		  var contentStringEnd = '<div id="content">'+
	      '<div id="siteNotice">'+
	      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
	      '<div id="bodyContent">'+
	      '<table class="table">' +
	      '<TR>'+
	      '<TD>' + '<span title="Vitesse km/h" style="font-size:11pt;" class="glyphicon glyphicon-flash">' + arraySpeed[arraySpeed.length-1].toString() +  '</span>' +'</TD>' +
	      '<TD>' + '<span title="Altitude mètre" style="font-size:11pt;" class="glyphicon glyphicon-signal">' + '&nbsp;' + arrayAlti[arrayAlti.length-1].toString()  +'</span>' +'</TD>' +
	      '</TR>' +
	      '</table>'+
	      '</div>'+
	      '</div>'+
	      '</div>';
	      
		  var contentStringStart = '<div id="content">'+
	      '<div id="siteNotice">'+
	      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
	      '<div id="bodyContent">'+
	      '<table class="table">' +
	      '<TR>'+
	      '<TD>' + '<span title="Vitesse km/h" style="font-size:11pt;" class="glyphicon glyphicon-flash">' + arraySpeed[0].toString() +  '</span>' +'</TD>' +
	      '<TD>' + '<span title="Altitude mètre" style="font-size:11pt;" class="glyphicon glyphicon-signal">' + '&nbsp;' + arrayAlti[0].toString()  +'</span>' +'</TD>' +
	      '</TR>' +
	      '</table>'+
	      '</div>'+
	      '</div>'+
	      '</div>';
	      
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
		
		var infowindowStart = new google.maps.InfoWindow({
		      content: contentStringStart
		});

		var infowindowEnd = new google.maps.InfoWindow({
		      content: contentStringEnd
		});

	  	google.maps.event.addListener(markerStart, 'click', function() {
	  		infowindowStart.open(map,markerStart);
		  });
	  	
	  	google.maps.event.addListener(markerEnd, 'click', function() {
	  		infowindowEnd.open(map,markerEnd);
		  });

	  	
	  	/* Listener to get long and lat
	  	google.maps.event.addListener(markerStart, 'dragend', function (event) {
	  	    document.getElementById("latbox").value = this.getPosition().lat();
	  	    document.getElementById("lngbox").value = this.getPosition().lng();
	  	});
	  	*/
	  	
	  	
	  	// Add the two markers
	  	markerEnd.setMap(map);
	  	markerStart.setMap(map);

		
	}
	
	google.maps.event.addDomListener(window, 'resize', initialize);
	google.maps.event.addDomListener(window, 'load', initialize);

</script>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon"
	href="bootstrap-3.1.1/docs/assets/ico/favicon.ico">

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
				<a class="navbar-brand" href="index.jsp">HexoSkin</a>
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
					<li class="active"><a href="index.jsp">Dashboard</a></li>
					<li><a href="compare.jsp">Comparer</a></li>
					<li><a href="historique.jsp">Historique</a></li>
				</ul>
			</div>

			<%
				List listWorkout  ;
				String dateToShow = "" ;
			
				// Test if we have something in param 
				if(request.getParameter("date") != null){
					dateToShow = request.getParameter("date");
					listWorkout = rest.getDataWorkoutByEmailAndDate(dateToShow,
							"vincentpont@gmail.com");
				}
			     // If not we show the last workout
				else{
					dateToShow = rest.getLastDateWorkout("vincentpont@gmail.com");
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
						 <span style="font-size:14pt; font-family:Verdana;">&nbsp; <% out.print(rest.getAltitudeAverage(listAltitude)); %> m </span>				
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
				dateHEXO = rest.getLastDateWorkout("vincentpont@gmail.com");
				dateHEXO = dateHEXO.substring(0, 10);
				dateHEXO = dateHEXO.replace('.', '-');
			}
			
			List<String> listPulsation = restHEXO.returnAllValueFromJson(dateHEXO, "19");
			List<String> listSteps = restHEXO.returnAllValueFromJson(dateHEXO, "52");
			List<String> listBreathing = restHEXO.returnAllValueFromJson(dateHEXO, "33");
			List<String> listVentilation = restHEXO.returnAllValueFromJson(dateHEXO, "36");
			List<String> listVolumeTidal = restHEXO.returnAllValueFromJson(dateHEXO, "37");
			
			%>
			
				<TR>
					<TD title="Pulsation moyenne" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-heart"></span>						
						<span style="font-size:14pt; font-family:Verdana;"><% out.print(restHEXO.getAverageFromList(listPulsation));  %> </span>	
					</TD> 
					
					<TD  title="Total pas"  class="info">				
						<span style="font-size:21pt;" class="glyphicon glyphicon-road"></span>						
					    <span style="font-size:14pt; font-family:Verdana;"><% out.print(listSteps.get(listSteps.size()-1));  %> </span>	
					</TD>
					
					<TD title="Volume Tidal moyen" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-stats"></span>						
						<span style="font-size:14pt; font-family:Verdana;">&nbsp; <%  out.print(restHEXO.getAverageFromList(listVolumeTidal));   %> </span>	
					</TD>
					
					<TD title="Respiration rate moyenne" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-transfer"></span>						
						<span style="font-size:14pt; font-family:Verdana;">&nbsp; <% out.print(restHEXO.getAverageFromList(listBreathing));   %> </span>	
					</TD>
					
					<TD title="Ventilation/min moyenne" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
						<span style="font-size:14pt; font-family:Verdana;">&nbsp; <%  out.print(restHEXO.getAverageFromList(listVentilation));  %>  </span>	
					</TD>
				</TR>
				</table>
	</div>		
				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<h3 class="page-header">Carte
				<span  style="font-size:20pt;" class="glyphicon glyphicon-map-marker"></span>
				</h3>

				<br>
				<div class="row placeholders">
					<div id="map-canvas" style="width:800px;height:400px;"></div>
				</div>
				
				
				<h4>Filtres  </h4>
			<table>
			<TR>
				<TD>
					<form action="index.jsp" method="get">
						    <label for="precision">Sélectionnez  </label>
						    <select title ="Représente le nombre de mètres qui séparent chaque infos de la séance." name="meterMarker" id="precision" class="form-control"  style="max-width:80px;">
								  <option value="5">5 m</option>
								  <option value="10">10 m</option>
								  <option value="25">25 m</option>
								  <option value="50">50 m</option>
								  <option value="100">100 m</option>
								  <option value="200">200 m</option>
								  <option value="500">500 m</option>
								  <option value="1000">1000 m</option>
							</select> 
							 <label for="precision" style="font-size:8pt;">*Représente le nombre de mètres qui séparent chaque infos de la séance.</label>
<br>
<br>
				     		<button type='submit' class="btn btn-success" > Filtrer </button>
<br>
					</form> 
				</TD>
			</TR>
			</table>
			
			<div id="latlong">
			    <p>Latitude: <input size="20" type="text" id="latbox" name="lat" ></p>
			    <p>Longitude: <input size="20" type="text" id="lngbox" name="lng" ></p>
  			</div>
			
			
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<h3 class="page-header">Graphiques </h3>

				<div class="row placeholders">
					<div class="col-xs-6">
						<div id="chart_div1" style="width: 450px; height: 350px;"></div>
						<h4>Pulsation</h4>
						<span class="text-muted">Pulsation par minute</span>
					</div>
					<div class="col-xs-6">
						<div id="chart_div2" style="width: 500px; height: 350px;"></div>

						<h4>Accélération</h4>
						<span class="text-muted"></span>
					</div>

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
