<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="restHexoSkin.RestInvokerHexo"%>
<%@ page import="java.util.Iterator, java.util.List, java.util.Date, java.text.DecimalFormat;"%>


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
String lastDateWorkout = restMap.getLastDateWorkout("vincentpont@gmail.com"); 
String restHexoDate = "" ;

// Test if we have something in param 
if(request.getParameter("date") != null){
	restHexoDate = request.getParameter("date");
	restHexoDate = restHexoDate.substring(0, 10);
	restHexoDate = restHexoDate.replace('.', '-');
	
}
 // If not we show the last workout
else{
	restHexoDate = lastDateWorkout; 
	restHexoDate = restHexoDate.substring(0, 10);
	restHexoDate = restHexoDate.replace('.', '-');
}

restMap.getDataMap("vincentpont@gmail.com", lastDateWorkout); 
List<String> listPulsations = restHexo.returnAllValueFromJson(restHexoDate, "19"); 
List<String> listVolumeTidals = restHexo.returnAllValueFromJson(restHexoDate, "37"); 
List<String> listRespirationFreqs = restHexo.returnAllValueFromJson(restHexoDate, "33"); 
List<String> listVentilations = restHexo.returnAllValueFromJson(restHexoDate, "36"); 

List<Double> listVitesses = restMap.getListVitesses();

StringBuffer stringBufferPulsation = new StringBuffer();
StringBuffer stringBufferVitesses = new StringBuffer();
StringBuffer stringBufferVolumeTidal = new StringBuffer();
StringBuffer stringBufferRespirationFreq = new StringBuffer();
StringBuffer stringBufferVentilations = new StringBuffer();

stringBufferPulsation = restMap.convertListToStringBufferInteger(listPulsations);
stringBufferVitesses = restMap.convertListToStringBufferInteger(listVitesses);
stringBufferVolumeTidal = restMap.convertListToStringBufferInteger(listVolumeTidals);
stringBufferRespirationFreq = restMap.convertListToStringBufferInteger(listRespirationFreqs);
stringBufferVentilations = restMap.convertListToStringBufferInteger(listVentilations);


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
	    var arrayVitesses = [ <%= stringBufferVitesses.toString() %> ];
	    var arrayVolumeTidal = [ <%= stringBufferVolumeTidal.toString() %> ];
	    var arrayRespiration = [ <%= stringBufferRespirationFreq.toString() %> ];
	    var arrayVentilation = [ <%= stringBufferVentilations.toString() %> ];

		//alert("arrayVolumeTidal" + arrayVolumeTidal.join('\n'));
		//alert("arrayPulsation length :" + arrayPulsation.length);
		var arrayVolumeTidalParse = new Array();
		for(var i = 0 ; i <arrayVolumeTidal.length;i++){
			arrayVolumeTidalParse[i] = parseFloat(arrayVolumeTidal[i].toFixed(2));
		}
		var arrayVentilationParse = new Array();
		for(var i = 0 ; i <arrayVentilation.length;i++){
			arrayVentilationParse[i] = parseFloat(arrayVentilation[i].toFixed(2));
		}
		
		var data = new google.visualization.DataTable();
		data.addColumn('string', "Enregistrements");
		data.addColumn('number', 'Pulsation');
		data.addColumn('number', 'Vitesse');
		data.addColumn('number', 'Volume Tidale');
		data.addColumn('number', 'Respiration rate');
		data.addColumn('number', 'Ventilation');
		
	

		 // Add values and converte it ml to l
		  for(var i = 0; i < arrayVitesses.length ; i++){
		   data.addRow([i.toString(), arrayPulsation[i], arrayVitesses[i], (arrayVolumeTidalParse[i]/1000), 
		                arrayRespiration[i], (arrayVentilationParse[i]/1000)]);
		  }

		var options = {
			colors: ['#FF0007', '#FFF800', '#46FDCF', '#960DF9', '#0C1A69'],
			hAxis : {
				title: 'Enregistrements',
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
		
		
		 var hideSal = document.getElementById("hidePulsation");
		 hideSal.onclick = function()
		 {

		    view = new google.visualization.DataView(data); 
		    view.hideColumns([1]); 
		    chart.draw(view, options);

		 }
		 
		 var hideExp = document.getElementById("hideSpeed");
		 hideExp.onclick = function()
		 {


		    view = new google.visualization.DataView(data);
		    view.hideColumns([2]); 
		    chart.draw(view, options);

		    
		 }	
		 
		 var hideTidal = document.getElementById("hideTidal");
		 hideTidal.onclick = function()
		 {

		    view = new google.visualization.DataView(data);
		    view.hideColumns([3]);
		    chart.draw(view, options);

		 }	
		 
		 var hideRespiration = document.getElementById("hideRespiration");
		 hideRespiration.onclick = function()
		 {


		    view = new google.visualization.DataView(data);
		    view.hideColumns([4]); 
		    chart.draw(view, options);

		 }	
		 
		 var hideVentilation = document.getElementById("hideVentilation");
		 hideVentilation.onclick = function()
		 {


		    view = new google.visualization.DataView(data);
		    view.hideColumns([5]); 
		    chart.draw(view, options);

		 }	
		 
		 // See all
		 var seeAll = document.getElementById("seeAll");
		 seeAll.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    view.setColumns([0,1,2,3,4,5]);
		    chart.draw(view, options);
		 }
		
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
	
	// Default values
	String meterMarker = "50" ;
	String booleanInfo = "No" ;
	String booleanSpeed = "No" ;
	String booleanPath = "Yes" ; 
	String booleanStartStop = "Yes";
	
	// Test if the user want to show the info
	String infoTest = request.getParameter("testInfo");
	if(request.getParameter("testInfo") != null){
		if(infoTest.equals("Yes")){
			if(request.getParameter("meterMarker") != null){
				meterMarker = request.getParameter("meterMarker");
				booleanInfo = "Yes";
			} else {
				meterMarker = "50"; // default
				booleanInfo = "Yes";
			}
		}
		else{
			booleanInfo = "No";
		}
	}
	
	
	// Test show speeds
	String speedTest = request.getParameter("testSpeed");
	if(request.getParameter("testSpeed") != null){
		if(speedTest.equals("Yes")){
			if(request.getParameter("meterMarker") != null){
				meterMarker = request.getParameter("meterMarker");
				booleanSpeed = "Yes";
			} else {
				booleanSpeed = "Yes";
				meterMarker = "50"; // default
			}
		}
		else {
			booleanSpeed = "No";
		}
	}
	
	// Test show path
	String pathTest = request.getParameter("testPath");
	if(request.getParameter("testPath") != null){
		if(pathTest.equals("Yes")){
			booleanPath = "Yes";
		}
		else {
			booleanPath = "No";
		}
	}	
	
	// Test show path
	String depStopTest = request.getParameter("testDepStop");
	if(request.getParameter("testDepStop") != null){
		if(depStopTest.equals("Yes")){
			booleanStartStop = "Yes";
		}
		else {
			booleanStartStop = "No";
		}
	}	
	
	%>
	
	
<script>

	function initialize() {
		
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

	   
	    
	    // Param post
	    var meterMarker = '<%=meterMarker%>';
	    meterMarker = parseInt(meterMarker); //parse
	    var numberMarker ;
	    
	    var booleanInfo = '<%=booleanInfo%>';
	    var booleanSpeed = '<%=booleanSpeed%>';
	    var booleanPath = '<%=booleanPath%>';
	    var booleanStartStop = '<%=booleanStartStop%>';
	    
	    // Set checked if the user already checked 
	    if(booleanInfo == "Yes"){
	    document.getElementById("testInfo").checked = true;
	    }
	    if(booleanSpeed == "Yes"){
	    	document.getElementById("testSpeed").checked = true;
	    }
	    if(booleanPath == "Yes"){
	    	document.getElementById("testPath").checked = true;
	    }
	    if(booleanStartStop == "Yes"){
	    	document.getElementById("testDepStop").checked = true;
	    }
	    
	    
	    switch(meterMarker) {
	    case 2:
	    	numberMarker = 1 ;
	        break;
	    case 10:
	    	numberMarker = 3 ;
	        break;
	    case 50:
	    	numberMarker = 11 ;
	        break;
	    case 100:
	    	numberMarker = 25;
	        break;
	    case 200:
	    	numberMarker = 50 ;
	        break;
	    case 500:
	    	numberMarker = 125 ;
	        break;
	    case 1000:
	    	numberMarker = 250 ;
	        break;
	} 
	    // Calculate speeds
	    var speedAverage = '<%=speedAverage%>';
	    var speedNumber = Number(speedAverage.substring(0, speedAverage.search(' '))); 
	    var speedMin = 2.00 ;
	    var speedUp = 10.00 ;
		
		
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
		var planCoordinatesYellow= new Array() ;	
		var planCoordinatesRed= new Array() ;	
		var planCoordinates= new Array() ;	
		var pathStyleGreen ;
		var pathStyleYellow ;
		var pathStyleRed ;
		var pathStyle ;
			
			// Path NORMAL
			if(booleanPath == "Yes"){
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
			
		
		var marker ;
			 
	    // Add speed marker if the user want it
	    if(booleanSpeed == "Yes"){
			for(var j = numberMarker ; j < arraySpeed.length ; j += numberMarker){	
		 
				// Now add the content of the popup
				  var contentStringSpeeds = '<div id="content">'+
			      '<div id="siteNotice">'+
			      '<h5 id="firstHeading" class="firstHeading">Données</h5>'+
			      '<div id="bodyContent">'+
			      '<table class="table">' + 
			      '<TR>'+
			      '<TD>' + '<span title="Vitesse km/h" style="font-size:11pt;" class="glyphicon glyphicon-flash">' + arraySpeed[j].toString() +  '</span>' +'</TD>' +
			      '</TR>' +
			      '</table>'+
			      '</div>'+
			      '</div>'+
			      '</div>';
			      
			      // add content text html
				  var myinfowindow  = new google.maps.InfoWindow({
				      content: contentStringSpeeds
				  });
			      
				
				  if (arraySpeed[j] <= 5 ){
					  var speedLowImg = 'img/Speedlow.png';
					  var markerPosition = new google.maps.LatLng(arrayLat[j],arrayLong[j]);
					  marker = new google.maps.Marker({
							position: markerPosition,
				    		animation: google.maps.Animation.DROP,
							infowindow: myinfowindow ,
							icon : speedLowImg
						});
					  
				  }
				  else if (arraySpeed[j] > 5 && arraySpeed[j] <= 8){
					  var speedMidImg = 'img/SpeedMiddle.png';
					  var markerPosition = new google.maps.LatLng(arrayLat[j],arrayLong[j]);
					   marker = new google.maps.Marker({
							position: markerPosition,
				    		animation: google.maps.Animation.DROP,
							infowindow: myinfowindow ,
							icon : speedMidImg
						});
	
				  }
				  
				  else if (arraySpeed[j] > 8){
					  var speedFastImg = 'img/SpeedMax.png';
					  var markerPosition = new google.maps.LatLng(arrayLat[j],arrayLong[j]);
					  	marker = new google.maps.Marker({
							position: markerPosition,
				    		animation: google.maps.Animation.DROP,
							infowindow: myinfowindow ,
							icon : speedFastImg
						});	
				  }
				  // Listener
				  google.maps.event.addListener(marker, 'click', function() {
					  this.infowindow.open(map, this);
				  });
				  
				  marker.setMap(map);
			}
	    }
	    
	      var arrayMarkers = new Array();
	    
	 	// Add info marker if the user want it
	    if(booleanInfo == "Yes"){
			// Add markers to the path 
			for(var i = numberMarker ; i < arraySpeed.length ; i += numberMarker ){	
				
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
			       '<span title="Pulsation min" style="font-size:11pt;" class="glyphicon glyphicon-heart">' + '&nbsp;' + arrayPulsation[i].toString() +  '</span>' +
			      '<br>' +
			       '<span title="Volume tidal" style="font-size:11pt;" class="glyphicon glyphicon-stats">' + '&nbsp;'+ arrayVolumeTidal[i].toString() +  '</span>' +
			      '<br>' +
			       '<span title="Respiration fréquence" style="font-size:11pt;" class="glyphicon glyphicon-transfer">'+ '&nbsp;' + arrayRespirationFreq[i].toString() +  '</span>' +
			      '<br>' +
			      '<span title="Ventilation min" style="font-size:11pt;" class="glyphicon glyphicon-sort-by-attributes">'+ '&nbsp;' + arrayVentilations[i].toString() +  '</span>' +'</TD>' +
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

		// Only if the user ask for it
		if(booleanStartStop == "Yes"){
		  	google.maps.event.addListener(markerStart, 'click', function() {
		  		infowindowStart.open(map,markerStart);
			  });
		  	
		  	google.maps.event.addListener(markerEnd, 'click', function() {
		  		infowindowEnd.open(map,markerEnd);
			  });
		  	
		  	// Add the two markers
		  	markerEnd.setMap(map);
		  	markerStart.setMap(map);
		}
	  	
	  	/* Listener to get long and lat
	  	google.maps.event.addListener(markerStart, 'dragend', function (event) {
	  	    document.getElementById("latbox").value = this.getPosition().lat();
	  	    document.getElementById("lngbox").value = this.getPosition().lng();
	  	});
	  	*/


	  	/*
		  google.maps.event.addListener(map, 'mouseover', function() {
			  for(var j = 0 ; j < arrayMarkers.length ; j++ ){
				  if(typeof arrayMarkers[j] !== 'undefined'){
				 	arrayMarkers[j].infowindow.close();
				  }
			  }
		  });
		*/
	}
	
	google.maps.event.addDomListener(window, 'resize', initialize);
	google.maps.event.addDomListener(window, 'load', initialize);
	
	function reloadMap(map){
		google.maps.event.trigger(map, 'resize');
	}

</script>


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
								<form  method="post" action="" onsubmit="reloadMap();">
									    <select title ="Représente le nombre de mètres qui séparent chaque infos de la séance." name="meterMarker" id="precision" class="form-control"  style="max-width:100px;">
											  <option value="2">2 m</option>
											  <option value="10">10 m</option>
											  <option value="50">50 m</option>
											  <option value="100">100 m</option>
											  <option value="200">200 m</option>
											  <option value="500">500 m</option>
											  <option value="1000">1000 m</option>
										</select> 
							
											<div title="Afficher le trajet enregistré." class="checkbox">
											<span>
												   <input id='testPath' type='checkbox' value='Yes' name='testPath'>
												    Chemin
												   <input id='testPathHidden' type='hidden' value='No' name='testPath'>
												  
											</span>
											</div>
											<div title="Afficher point départ et stop" class="checkbox">
											<span>
												  <input id='testDepStop' type='checkbox' value='Yes' name='testDepStop'>
												  Point départ/stop
												  <input id='testDepStopHidden' type='hidden' value='No' name='testDepStop'>
											</span>
											</div>
											<div title="Afficher les vitesses sur trajet." class="checkbox">
											<span>
												   <input id='testSpeed' type='checkbox' value='Yes' name='testSpeed'>
												    	Vitesses
												   <input id='testSpeedHidden' type='hidden' value='No' name='testSpeed'>
											</span>
											 </div>
											<div title="Afficher les données enregistrées." class="checkbox">
											<span>
												  <input id='testInfo' type='checkbox' value='Yes' name='testInfo'>
												  Détails séances
												  <input id='testInfoHidden' type='hidden' value='No' name='testInfo'>
											</span>
											</div>		
<br>
							     		<button type='submit' class="btn btn-success" onClick="reloadMap();"> Filtrer </button>
<br>
								</form> 
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
			
				<TD> <span style="font-style:italic; font-size:10pt;"> Chemin du trajet. &nbsp; </span>
				<img title="Tracé du chemin de la séance parcourue." src="img/path.png"/> 
				
<br>
			    
			    <span style="font-style:italic; font-size:10pt;"> Point début/stop séance.  </span>
				<img title="Point de départ." src="img/dd-start.png"/> 
				<img title="Point d'arrivée." src="img/dd-end.png"/> 
				
 <br>
			
				 <span style="font-style:italic; font-size:10pt;"> Degré vitesse. (faible à fort)  </span>

				<img title="Vitesse basse" src="img/Speedlow.png"/> 
				<img title="Vitesse moyenne" src="img/SpeedMiddle.png"/> 
				<img title="Vitesse haute" src="img/SpeedMax.png"/> 
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
					
	  					<div class="col-xs-12 col-md-8">			
			  				<div id="chart_div1" style="width: 100%; height: 500px;"></div>
			  			</div>  
<br><br>	  				
<br><br>
<br><br>	  										
						<div class="col-xs-12 col-md-4">	
								<table>
									<TR>
										<TD>				   					
				   						<button  title="Cacher la pulsation" class="btn btn-default" type="button" id="hidePulsation"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Pulsation</button>
<br>									<button style="margin-top:8px;" title="Cacher la vitesse" class="btn btn-default" type="button" id="hideSpeed"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Vitesse</button>
<br>									<button style="margin-top:8px;" title="Cacher le volume tidal" class="btn btn-default" type="button" id="hideTidal"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Volume tidal l</button>
<br>									<button style="margin-top:8px;" title="Cacher la respiration" class="btn btn-default" type="button" id="hideRespiration"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Repiration min</button>
<br>									<button style="margin-top:8px;" title="Cacher la ventilation" class="btn btn-default" type="button" id="hideVentilation"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Ventilation</button>
<br>				   					<button style="margin-top:8px;" style="margin-top:8px;" title="Voir tout" class="btn btn-default" type="button" id="seeAll"> <span class="glyphicon glyphicon-eye-open"></span> &nbsp;Tout</button>
										</TD>
									</TR>
								</table>
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
