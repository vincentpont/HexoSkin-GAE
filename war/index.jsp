<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="restHexoSkin.RestInvokerHexo"%>
<%@ page import="java.util.Iterator, java.util.List, java.util.Date;"%>


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


<!-- Google charts </body> -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	google.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = google.visualization.arrayToDataTable([
				[ 'Year', 'Sales', 'Expenses' ], [ '2013', 1000, 400 ],
				[ '2014', 1170, 460 ], [ '2015', 660, 1120 ],
				[ '2016', 1030, 540 ] ]);

		var options = {
			title : 'Company Performance',
			hAxis : {
				title : 'Year',
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


<script type="text/javascript">
	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	google.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = google.visualization.arrayToDataTable([
				[ 'Year', 'Sales', 'Expenses' ], [ '2004', 1000, 400 ],
				[ '2005', 1170, 460 ], [ '2006', 660, 1120 ],
				[ '2007', 1030, 540 ] ]);

		var options = {
			title : 'Company Performance'
		};

		var chart = new google.visualization.LineChart(document
				.getElementById('chart_div3'));
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
	// Get the values from the map to recreate the path on google maps api v3
	RestInvokerDatastore restMap = new RestInvokerDatastore();
	String lastDate = restMap.getLastDateWorkout("vincentpont@gmail.com");
	restMap.getDataMap("vincentpont@gmail.com", lastDate);
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
	
	restMap.getDataMap("vincentpont@gmail.com", lastDate);
	String vitesseMoyenneMap = restMap.getSpeedAverage();
	%>

<script>

    var arrayLat = [ <%= stringBufferLat.toString() %> ];
    var arrayLong = [ <%= stringBufferLong.toString() %> ];
    var arraySpeed = [ <%= stringBufferSpeed.toString() %> ];
    var arrayAlti = [ <%= stringBufferAlti.toString() %> ];
    var size = arrayLat.length;
    
	var startMarker = new google.maps.LatLng(arrayLat[0],arrayLong[0]);
	var endMarker = new google.maps.LatLng(arrayLat[size-1],arrayLong[size-1]);
	
	var map;
	
	// Average speed to have the indice to draw different color
	var VitesseMoyenne =  <%= vitesseMoyenneMap %> ;
	
	
	function initialize() {
		var mapOptions = {
			zoom : 17,
			center : new google.maps.LatLng(arrayLat[0], arrayLong[0]),
			mapTypeId : google.maps.MapTypeId.PLAN
		};

		var map = new google.maps.Map(document.getElementById('map-canvas'),
				mapOptions);
		
		// Pass the value to the array of path
		var planCoordinates = new Array() ;
			for(var i = 0 ; i < arrayLat.length ;i++){	
				planCoordinates[i] = new google.maps.LatLng(arrayLat[i] , arrayLong[i]);
			}
			
		// Add markers start
		var markerStart = new google.maps.Marker({
    		position: startMarker,
    		title:"START"
		});
		
		// Add markers start
		var markerEnd = new google.maps.Marker({
    		position: endMarker,
    		title:"END"
		});
		
		markerStart.setMap(map);
		markerEnd.setMap(map);

		var path = new google.maps.Polyline({
			path : planCoordinates,
			geodesic : true,
			strokeColor : '#FF0000',
			strokeOpacity : 1.0,
			strokeWeight : 4
		});

		path.setMap(map);
	}

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

<!-- Just for debugging purposes. Don't actually copy this line! -->
<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
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
					<li><a href="map.jsp">Carte</a></li>
					<li><a href="historique.jsp">Historiques</a></li>
				</ul>
			</div>

			<%
				RestInvokerDatastore rest = new RestInvokerDatastore();

				String lastWorkout = rest.getLastDateWorkout("vincentpont@gmail.com");
				String lastDate2 = rest.getLastDateWorkout("vincentpont@gmail.com");
				List list = rest.getDataWorkoutByEmailAndDate(lastWorkout,
						"vincentpont@gmail.com");
				
				// Get average of the speed
				String vitesse = "0.0";
				rest.getDataMap("vincentpont@gmail.com", lastDate2);
				vitesse = rest.getSpeedAverage();
			%>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">Dernière séance</h1>
<br>
				<h3>
					  <span  style="font-size:23pt;" class="glyphicon glyphicon-calendar"></span>  &nbsp;
					  <span style="font-size:16pt;" > <% out.print(lastWorkout.substring(0, 10));  %> à  <% out.print(lastWorkout.substring(11, 16));  %>  </span>
				</h3>
				
<br>
<br>
				<div class="row" >
				
					<div  title="Temps" class="col-md-2">
					  <span  style="font-size:21pt;" class="glyphicon glyphicon-time"></span> 
					  <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(list.get(1)); %> </span>
					 </div>

					<div title="Distance en mètre" class="col-md-2">
					<span  style="font-size:21pt;" class="glyphicon glyphicon-sort"></span> 
					 <span style="font-size:14pt; font-family:Verdana;"> &nbsp;  <% out.print(list.get(2)); %> </span>
					
					</div>

					<div title="Calories brûlées" class="col-md-2">
					<span style="font-size:21pt;" class="glyphicon glyphicon-fire"></span>	
					 <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(list.get(3)); %></span>
					</div>

					<div title="Vitesse moyenne en km/h" class="col-md-2">
					<span style="font-size:21pt;" class="glyphicon glyphicon-flash"></span>	
					 <span style="font-size:14pt; font-family:Verdana;">  <% out.print(vitesse); %> </span>	
					</div>
					
				    <div title="Mètre/min moyen" class="col-md-2">
					<span style="font-size:21pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(list.get(4)); %></span>	
					</div>
					
					</div>
<br>

			<%
			String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=347631277170";
			RestInvokerHexo restHexo = new RestInvokerHexo(s1);
			
			// Get lastdate from datastore to compare with hexoskin and substring because is not the same format
			String lastDateWorkout = rest.getLastDateWorkout("vincentpont@gmail.com");
			// A modifier lorsque que j'aurai une date synchro avec android
			lastDateWorkout = lastDateWorkout.substring(0, 10);
			lastDateWorkout = lastDateWorkout.replaceAll(".", "-");
			System.out.println(lastDateWorkout);
			List<String> listPulsation = restHexo.returnAllValueFromJson("2014-06-28", "19");
			List<String> listSteps = restHexo.returnAllValueFromJson("2014-06-28", "52");
			List<String> listBreathing = restHexo.returnAllValueFromJson("2014-06-28", "33");
			List<String> listVentilation = restHexo.returnAllValueFromJson("2014-06-28", "36");
			List<String> listVolumeTidal = restHexo.returnAllValueFromJson("2014-06-28", "37");
			
			%>

				<div class="row" >
				
					<div title="Pulsation" class="col-md-2">
					<span  style="font-size:21pt;" class="glyphicon glyphicon-heart"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(listPulsation.get(listPulsation.size()-1));  %> </span>	
					</div>

					<div title="Pas" class="col-md-2">
					<span style="font-size:21pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(listSteps.get(listSteps.size()-1));  %> </span>	
					</div>
					
					<div title="Volume Tidal" class="col-md-2">
					<span  style="font-size:21pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<%  out.print(listVolumeTidal.get(listVolumeTidal.size()-1));  %> </span>	
					</div>
					
					<div title="Breathing Rate" class="col-md-2">
					<span  style="font-size:21pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(listBreathing.get(listBreathing.size()-1));  %> </span>	
					</div>
					
				    <div title="Minute Ventilation " class="col-md-2">
					<span  style="font-size:21pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<%  out.print(listVentilation.get(listVentilation.size()-1));  %>  </span>	
					</div>
					

				</div>
			</div>
			
				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
<br>
				<h1 class="page-header">Carte</h1>

				<br>
				<div class="row placeholders">

				<div id="map-canvas" style="height: 500px; width: 700px"></div>

					
				</div>



			</div>


			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
<br>
				<h1 class="page-header">Graphiques
				  
				</h1>

				<br>
				<div class="row placeholders">
					<div class="col-xs-6">
						<div id="chart_div1" style="width: 450px; height: 350px;"></div>
						<h4>Performance</h4>
						<span class="text-muted">ECG / Respiration</span>
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
