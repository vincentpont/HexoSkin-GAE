<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="restHexoSkin.RestInvokerHexo"%>
<%@ page import="java.util.Iterator, java.util.List"%>

<!-- Placez ce script JavaScript asynchrone juste devant votre balise </body> -->
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
	
	/**
	 * Method to check if the user is loged or not if not redirect to login page
	 */
	function signinCallback(authResult) {
    	  if (authResult['access_token']) {
        		// Logged
        	  } else if (authResult['error']) {
          	document.getElementById('signinButton').setAttribute('style', 'display: none');
        		window.location = "login.jsp";
        	  }
	}
</script>


<%
String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";
RestInvokerHexo restHEXO = new RestInvokerHexo(s1); 
RestInvokerDatastore restMap = new RestInvokerDatastore(); 
String lastDateWorkout = restMap.getLastDateWorkout("vincentpont@gmail.com"); 
String hexoDate1 = "" ;

// Test if we have something in param 
if(request.getParameter("date1") != null){
	hexoDate1 = request.getParameter("date1");
	restMap.getDataMap("vincentpont@gmail.com", hexoDate1); 
	hexoDate1 = hexoDate1.substring(0, 10);
	hexoDate1 = hexoDate1.replace('.', '-');
	
}
 // If not we show the last workout
else if (request.getParameter("date1") == null){
	hexoDate1 = lastDateWorkout; 
	restMap.getDataMap("vincentpont@gmail.com", hexoDate1); 
	hexoDate1 = hexoDate1.substring(0, 10);
	hexoDate1 = hexoDate1.replace('.', '-');
}

List<String> listPulsations1 = restHEXO.returnAllValueFromJson(hexoDate1, "19"); 
List<Double> listVitesses1 = restMap.getListVitesses();

StringBuffer stringBufferPulsation1 = new StringBuffer();
StringBuffer stringBufferVitesses1 = new StringBuffer();

stringBufferPulsation1 = restMap.convertListToStringBufferInteger(listPulsations1);
stringBufferVitesses1 = restMap.convertListToStringBufferInteger(listVitesses1);

%>

<!-- Google charts Pulsation/Vitesse trajet 1-->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

	var arrayPulsation1 = [ <%= stringBufferPulsation1.toString() %> ];
    var arrayVitesses1 = [ <%= stringBufferVitesses1.toString() %> ];


		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		
		function drawChart() {

			var data = new google.visualization.DataTable();
			data.addColumn('string', "Enregistrements");
			data.addColumn('number', 'Pulsations');
			data.addColumn('number', 'Vitesses');
	
		 	// Add values and converte it ml to l
		   for(var i = 0; i < arrayVitesses1.length ; i++){
		   	data.addRow([i.toString(), arrayPulsation1[i], arrayVitesses1[i]]);
		   }
			
		  var options = {
		    colors: ['#FF0007', '#FFF800'],
		    title: 'Vitesse / Pulsation'
		  };
		  
		  var chart = new google.visualization.AreaChart(document.getElementById('chart_div1'));
		
		  chart.draw(data, options);
		  
			 
			 var hidePuls1 = document.getElementById("hidePulsation1");
			 hidePuls1.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.hideColumns([1]); 
			    chart.draw(view, options);
			 }		
			 
			 var hideSpeed1 = document.getElementById("hideSpeed1");
			 hideSpeed1.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.hideColumns([2]); 
			    chart.draw(view, options);
			 }
			 
			 // See all
			 var seeAll1 = document.getElementById("seeAll1");
			 seeAll1.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.setColumns([0,1,2]);
			    chart.draw(view, options);
			 }
}
		

</script>


<%

List<String> listVolumeTidals1 = restHEXO.returnAllValueFromJson(hexoDate1, "37"); 
List<String> listRespirationFreqs1 = restHEXO.returnAllValueFromJson(hexoDate1, "33"); 
List<String> listVentilations1 = restHEXO.returnAllValueFromJson(hexoDate1, "36"); 

StringBuffer stringBufferVolumeTidal1 = new StringBuffer();
StringBuffer stringBufferRespirationFreq1 = new StringBuffer();
StringBuffer stringBufferVentilations1 = new StringBuffer();

stringBufferVolumeTidal1 = restMap.convertListToStringBufferInteger(listVolumeTidals1);
stringBufferRespirationFreq1 = restMap.convertListToStringBufferInteger(listRespirationFreqs1);
stringBufferVentilations1 = restMap.convertListToStringBufferInteger(listVentilations1);

%>

<!-- Google charts Respiration/Ventilation/Tidal trajet 1  -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

		var arrayVolumeTidal1 = [ <%= stringBufferVolumeTidal1.toString() %> ];
		var arrayRespiration1 = [ <%= stringBufferRespirationFreq1.toString() %> ];
		var arrayVentilation1 = [ <%= stringBufferVentilations1.toString() %> ];


		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		
		function drawChart() {

			var data = new google.visualization.DataTable();
			data.addColumn('string', "Enregistrements");
			data.addColumn('number', 'Respiration');
			data.addColumn('number', 'Ventilation');
			data.addColumn('number', 'Volume tidal');
	
		 	// Add values and converte it ml to l
		   for(var i = 0; i < arrayVitesses1.length ; i++){
		   	data.addRow([i.toString(), arrayRespiration1[i], arrayVentilation1[i]/1000, arrayVolumeTidal1[i]/1000]);
		   }
		 	
		  var options = {
		    colors: ['#960DF9', '#0C1A69' ,'#46FDCF'],
		    title: 'Respiration'
		  };
		  
		  var chart = new google.visualization.AreaChart(document.getElementById('chart_div3'));
		
		  chart.draw(data, options);
		  
			 
			 var hideRespi1 = document.getElementById("hideRespiration1");
			 hideRespi1.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.hideColumns([1]); 
			    chart.draw(view, options);
			 }		
			 
			 var hideVenti1 = document.getElementById("hideVentilation1");
			 hideVenti1.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.hideColumns([2]); 
			    chart.draw(view, options);
			 }
			 
			 var hideVolumT1 = document.getElementById("hideVolumeTidal1");
			 hideVolumT1.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.hideColumns([3]); 
			    chart.draw(view, options);
			 }
			 
			 // See all
			 var seeAll3 = document.getElementById("seeAll3");
			 seeAll3.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.setColumns([0,1,2,3]);
			    chart.draw(view, options);
			 }
}
		

</script>

<%
	String hexoDate2 = "";
	// Test if we have something in param 
	if(request.getParameter("date2") != null){
		hexoDate2 = request.getParameter("date2");
		restMap.getDataMap("vincentpont@gmail.com", hexoDate2); 
		hexoDate2 = hexoDate2.substring(0, 10);
		hexoDate2 = hexoDate2.replace('.', '-');
		
	}
	 // If not we show the last workout
	else if (request.getParameter("date2") == null)	{
		hexoDate2 = lastDateWorkout; 
		restMap.getDataMap("vincentpont@gmail.com", hexoDate2); 
		hexoDate2 = hexoDate2.substring(0, 10);
		hexoDate2 = hexoDate2.replace('.', '-');
	}

	List<String> listPulsations2 = restHEXO.returnAllValueFromJson(hexoDate2, "19"); 
	List<Double> listVitesses2 = restMap.getListVitesses();
	
	StringBuffer stringBufferPulsation2 = new StringBuffer();
	StringBuffer stringBufferVitesses2 = new StringBuffer();
	
	stringBufferPulsation2 = restMap.convertListToStringBufferInteger(listPulsations2);
	stringBufferVitesses2 = restMap.convertListToStringBufferInteger(listVitesses2);

%>

<!-- Google chart Pulsation/Vitesse trajet 2 -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

var arrayPulsation2 = [ <%= stringBufferPulsation2.toString() %> ];
var arrayVitesses2 = [ <%= stringBufferVitesses2.toString() %> ];

	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	google.setOnLoadCallback(drawChart);
	
	function drawChart() {
		
		var data = new google.visualization.DataTable();
		data.addColumn('string', "Enregistrements");
		data.addColumn('number', 'Pulsations');
		data.addColumn('number', 'Vitesses');

		
	 // Add values and converte it ml to l
	  for(var i = 0; i < arrayVitesses2.length ; i++){
	   data.addRow([i.toString(), arrayPulsation2[i], arrayVitesses2[i]]);
	  }
		

	  var options = {
				colors: ['#FF0007', '#FFF800'],
			    title: 'Vitesse / Pulsation'
			  };

		var chart = new google.visualization.AreaChart(document
				.getElementById('chart_div2'));
		chart.draw(data, options);
		
		 var hidePuls2 = document.getElementById("hidePulsation2");
		 hidePuls2.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    view.hideColumns([1]); 
		    chart.draw(view, options);
		 }	
		
		 var hideSpeed2 = document.getElementById("hideSpeed2");
		 hideSpeed2.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    view.hideColumns([2]); 
		    chart.draw(view, options);
		 }
		 	 
		 // See all
		 var seeAll2 = document.getElementById("seeAll2");
		 seeAll2.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    view.setColumns([0,1,2]);
		    chart.draw(view, options);
		 }
	}
	

</script>

<%

List<String> listVolumeTidals2 = restHEXO.returnAllValueFromJson(hexoDate2, "37"); 
List<String> listRespirationFreqs2 = restHEXO.returnAllValueFromJson(hexoDate2, "33"); 
List<String> listVentilations2 = restHEXO.returnAllValueFromJson(hexoDate2, "36"); 

StringBuffer stringBufferVolumeTidal2 = new StringBuffer();
StringBuffer stringBufferRespirationFreq2 = new StringBuffer();
StringBuffer stringBufferVentilations2 = new StringBuffer();

stringBufferVolumeTidal2 = restMap.convertListToStringBufferInteger(listVolumeTidals2);
stringBufferRespirationFreq2 = restMap.convertListToStringBufferInteger(listRespirationFreqs2);
stringBufferVentilations2 = restMap.convertListToStringBufferInteger(listVentilations2);

%>

<!-- Google charts Respiration/Ventilation/Tidal trajet 2 -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

		var arrayVolumeTidal2 = [ <%= stringBufferVolumeTidal2.toString() %> ];
		var arrayRespiration2 = [ <%= stringBufferRespirationFreq2.toString() %> ];
		var arrayVentilation2 = [ <%= stringBufferVentilations2.toString() %> ];


		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		
		function drawChart() {

			var data = new google.visualization.DataTable();
			data.addColumn('string', "Enregistrements");
			data.addColumn('number', 'Respiration');
			data.addColumn('number', 'Ventilation');
			data.addColumn('number', 'Volume tidal');
	
		 	// Add values and converte it ml to l
		   for(var i = 0; i < arrayVitesses2.length ; i++){
		   	data.addRow([i.toString(), arrayRespiration2[i], arrayVentilation2[i]/1000, arrayVolumeTidal2[i]/1000]);
		   }
		 	
		  var options = {
			colors: ['#960DF9', '#0C1A69' ,'#46FDCF'],
		    title: 'Respiration'
		  };
		  
		  var chart = new google.visualization.AreaChart(document.getElementById('chart_div4'));
		
		  chart.draw(data, options);
		  
			 
			 var hideRespi2 = document.getElementById("hideRespiration2");
			 hideRespi2.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.hideColumns([1]); 
			    chart.draw(view, options);
			 }		
			 
			 var hideVent2 = document.getElementById("hideVentilation2");
			 hideVent2.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.hideColumns([2]); 
			    chart.draw(view, options);
			 }
			 
			 var hideVoluT2 = document.getElementById("hideVolumeTidal2");
			 hideVoluT2.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.hideColumns([3]); 
			    chart.draw(view, options);
			 }
			 
			 // See all
			 var seeAll4 = document.getElementById("seeAll4");
			 seeAll4.onclick = function()
			 {
			    view = new google.visualization.DataView(data);
			    view.setColumns([0,1,2,3]);
			    chart.draw(view, options);
			 }
}

</script>

<script>
/**
 * Method ot logout the user from the site.
 */
function logout() {
	document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://8-dot-logical-light-564.appspot.com/login.jsp";
}

/**
 * Method that test if the user select two dates to compare them if not we don't allow submit form.
 */
function testChoice()
{   
		var test1 = document.getElementById("selecte1").value ;
		var test2 = document.getElementById("selecte2").value ;
		if  (test1 != '' &&  test2 !== ''){
			return true ;	
		}
		else{
			alert("Veuillez sélectionner 2 séances svp.");
			return false;
		}
}

/**
 * Method that change de color of a <TD> workout if he is more or less than the value of the other workout.
 */
function changeColor()
{   
	var value1 ;
	var value2 ;

	// We compare the value and change the color
	// Pulsation
	value1 = parseFloat(document.getElementById('puls1SP').innerHTML);
	value2  = parseFloat(document.getElementById('puls2SP').innerHTML);
	if(value1 > value2){
		document.getElementById('puls1TD').style.color = "rgb(255,69,0)";
	}
	else if (value2 > value1){
		document.getElementById('puls2TD').style.color = "rgb(255,69,0)";
	}
	
	// Vitesse
	value1 = document.getElementById('speed1SP').innerHTML;
	value2  = document.getElementById('speed2SP').innerHTML;
	
	if(value1 > value2){
		document.getElementById('speed2SP').style.color = "rgb(0,255,17)"; // vert
		document.getElementById('speed1SP').style.color = "rgb(255,69,0)"; // rouge
	}
	else if (value2 > value1){
		document.getElementById('speed1SP').style.color = "rgb(0,255,17)"; // vert
		document.getElementById('speed2SP').style.color = "rgb(255,69,0)";
	}
	
	// Calories
	value1 = document.getElementById('ca1TD').innerHTML;
	value2  = document.getElementById('ca2TD').innerHTML;
	
	if(value1 > value2){
		document.getElementById('ca2TD').style.color = "rgb(0,255,17)"; // vert
		document.getElementById('ca1TD').style.color = "rgb(255,69,0)"; 
	}
	else if (value2 > value1){
		document.getElementById('ca1TD').style.color = "rgb(0,255,17)"; // vert
		document.getElementById('ca2TD').style.color = "rgb(255,69,0)";
	}

}

</script>

<!-- Google MAPS -->
<script
	src="https://maps.googleapis.com/maps/api/js?v=3?key={AIzaSyA9MSARpM9GdjunV4sR5mxpOuD3pfkyldc}">
</script>

<!-- ... -->


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
			<div class="navbar-collapse collapse" >
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
	          <ul class="nav nav-sidebar">
	            <li><a href="index.jsp">Dashboard</a></li>
	            <li class="active"><a href="compare.jsp">Comparer</a></li>
            <li><a href="historique.jsp">Historique</a></li>
	          </ul>
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

					<h1 class="page-header">Comparatif séances &nbsp;
				   	<img src="img/compare.png" width="50px" height="50px"/> 
					</h1>
					
<br>
					<h3>Choisissez deux séances à comparer</h3>
<br>				
				    <%
					RestInvokerDatastore rest =  new RestInvokerDatastore();
					List listDates1 = rest.getAllDatesWorkoutSorted("vincentpont@gmail.com");
					Iterator iterator1 = listDates1.iterator();
					%>

					<div class="col-md-6">	
					<form action="compare.jsp" method="get" onSubmit="return testChoice();">
				    <select id="selecte1" name="date1" class="form-control" style="font-size:14pt;">
					    <option value="">-- Choisissez une date -- </option>
					    <%for(int i = 0 ; i<listDates1.size() ;i++){%>
					        <option value="<% out.print(listDates1.get(i)); %>"> <%out.print(listDates1.get(i));%> </option>
					    <%} %>
					</select>
					
<br>
<button type='submit' class="btn btn-success"> Afficher </button>
<button type='button'  class="btn btn-success" onClick="changeColor();"> Comparer </button>
<br>
<br>
				 <%
				 	// Données datastore (android)
				 
					List listWorkout1 = null ;
					String dateToShow1 = "" ;
				
					// Test if we have something in param 
					if(request.getParameter("date1") != null){
						dateToShow1 = request.getParameter("date1");
						listWorkout1 = rest.getDataWorkoutByEmailAndDate(dateToShow1,
								"vincentpont@gmail.com");
						rest.getDataMap("vincentpont@gmail.com", dateToShow1); 
					}
				     // If not we show the last workout
					else if(request.getParameter("date1") == null){
						dateToShow1 = rest.getLastDateWorkout("vincentpont@gmail.com");
						listWorkout1 = rest.getDataWorkoutByEmailAndDate(dateToShow1,
								"vincentpont@gmail.com");
						// Get data for altitude
						rest.getDataMap("vincentpont@gmail.com", dateToShow1); 
					}
					
					List<Double> listAltitude = rest.getListAltitudes();

				 %>   

<br>		
			    <span title="Date" style="font-size:20pt;" class="glyphicon glyphicon-calendar"></span>  &nbsp;
			    <span title="Date" style="font-size:14pt;" > <% out.print(dateToShow1.substring(0, 10));  %> à  <% out.print(dateToShow1.substring(11, 16));  %>  </span>
 <br>
 <br>			
 
 
 <table class="table">
				<TR>
					<TD id="time1TD"" title="Temps" class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-time"></span> 
					 <span id="time1SP"  style="font-size:12pt; font-family:Verdana;"> <% out.print(listWorkout1.get(1)); %> </span>
					
					</TD> 
						
					<TD  id="dist1TD" title="Distance en mètre"  class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort"></span> 
					 <span id="dist1SP" style="font-size:12pt; font-family:Verdana;"> <% out.print(listWorkout1.get(2)); %>  </span>
								
					</TD>
						
					<TD id="ca1TD" title="Calories brûlées" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-fire"></span>	
					 <span id="ca1SP" style="font-size:12pt; font-family:Verdana;"> <% out.print(listWorkout1.get(3)); %> </span>
					
					</TD>
						
					<TD  id="speed1TD" title="Vitesse moyenne en km/h" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-flash"></span>	
					 <span id="speed1SP" style="font-size:12pt; font-family:Verdana;">  <% out.print(listWorkout1.get(4)); %> </span>	
					
					</TD>
						
					<TD title="Altitude moyenne en mètre" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(rest.getAltitudeAverage(listAltitude)); %> </span>	
					
					</TD>
				</TR>
 		    
		<TR>
				<%
					// Donnée hexoskin
					String dateHEXO = "" ;
					
					// Test if we have something in param 
					if(request.getParameter("date1") != null){
						dateHEXO = request.getParameter("date1");
						dateHEXO = dateHEXO.substring(0, 10);
						dateHEXO = dateHEXO.replace('.', '-');
					}
				     // If not we show the last workout
					else{
						dateHEXO = dateToShow1;
						dateHEXO = dateHEXO.substring(0, 10);
						dateHEXO = dateHEXO.replace('.', '-');
					}
					// Get data from hexoskin API with datatype
					List<String> listPulsation1 = restHEXO.returnAllValueFromJson(dateHEXO, "19");
					List<String> listSteps1 = restHEXO.returnAllValueFromJson(dateHEXO, "52");
					List<String> listBreathing1 = restHEXO.returnAllValueFromJson(dateHEXO, "33");
					List<String> listVentilation1 = restHEXO.returnAllValueFromJson(dateHEXO, "36");
					List<String> listVolumeTidal1 = restHEXO.returnAllValueFromJson(dateHEXO, "37");
					
					String avgTidal1  = restHEXO.getAverageFromList(listVolumeTidal1);
					String volumTidal1 = restHEXO.changeMltoLwith2Decimals(avgTidal1);
					
					String avgVentilation1  = restHEXO.getAverageFromList(listVentilation1);
					String ventilation1 = restHEXO.changeMltoLwith2Decimals(avgVentilation1); %>

					<TD  id="puls1TD" title="Pulsation moyenne" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-heart"></span>						
					<span id="puls1SP" style="font-size:12pt; font-family:Verdana;"> <% out.print(restHEXO.getAverageFromList(listPulsation1));   %> </span>	
					
					</TD> 
					
					<TD  title="Total pas"  class="info">
					<span style="font-size:14pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:12pt; font-family:Verdana;">  <% out.print(listSteps1.get(listSteps1.size()-1));  %> </span>	
								
					</TD>
					
					<TD title="Volume Tidal moyen en l/inspiration" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> <%  out.print(volumTidal1);   %> </span>	
					
					</TD>
					
					<TD title="Respiration min moyenne" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> <% out.print(restHEXO.getAverageFromList(listBreathing1));   %> </span>	
					
					</TD>
					
					<TD title="Ventilation moyenne l/min)" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> <%  out.print(ventilation1);  %>  </span>	
					
					</TD>
				</TR>
				</table>
			
<br>
<br>
				    <h3>Graphiques </h3>
<br>
						<div id="chart_div1" style="width: 100%; height: 400px;"></div>
						<button title="Cacher la vitesse" class="btn btn-default" style="margin-left:90px;"  type="button" id="hideSpeed1"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Vitesses</button>
   						<button title="Cacher la pulsation" class="btn btn-default" type="button" id="hidePulsation1"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Pulsation</button>
   						<button  title="Voir tout" class="btn btn-default" type="button" id="seeAll1"  > <span class="glyphicon glyphicon-eye-open"></span> &nbsp;Tout</button>
<br>
						<div id="chart_div3" style="width: 100%; height: 400px;"></div>
						<button title="Cacher la respiration" class="btn btn-default" style="margin-left:90px;"  type="button" id="hideRespiration1"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Respiration</button>
   						<button title="Cacher la ventilation" class="btn btn-default" type="button" id="hideVentilation1"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Ventilation</button>
   						<button title="Cacher le volume tidal" class="btn btn-default" type="button" id="hideVolumeTidal1"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Volume Tidal</button>
   						<button title="Voir tout" class="btn btn-default" type="button" id="seeAll3"  > <span class="glyphicon glyphicon-eye-open"></span> &nbsp;Tout</button>
				</div>	

					<div class="col-md-6">

								
					<% // Récupère une liste de ttes les dates
					List listDates2 = rest.getAllDatesWorkoutSorted("vincentpont@gmail.com");
					Iterator iterator2 = listDates2.iterator();
					%>

				    <select id="selecte2" name="date2" class="form-control" style="font-size:14pt;">
					    <option value="">-- Choisissez une date -- </option>
					    <%for(int i = 0 ; i<listDates2.size() ;i++){%>
					        <option value="<% out.print(listDates2.get(i)); %>"> <%out.print(listDates2.get(i));%> </option>
					    <%} %>
					</select>
					</form>
<br>
<div style="height: 14px; width:74px"> </div>
<br>
<br>				

<% 					// Donnée datastore (android)
					List listWorkout2 = null ;
					String dateToShow2 = "" ;
				
					// Test if we have something in param 
					if(request.getParameter("date2") != null){
						dateToShow2 = request.getParameter("date2");
						listWorkout2 = rest.getDataWorkoutByEmailAndDate(dateToShow2,
								"vincentpont@gmail.com");
						rest.getDataMap("vincentpont@gmail.com", dateToShow2); 
					}
				     // If not we show the last workout
					else if(request.getParameter("date2") == null){
						dateToShow2 = rest.getLastDateWorkout("vincentpont@gmail.com");
						listWorkout2 = rest.getDataWorkoutByEmailAndDate(dateToShow2,
								"vincentpont@gmail.com");
						// Get data for altitude
						rest.getDataMap("vincentpont@gmail.com", dateToShow2); 
					}
				
					List<Double> listAltitude2 = rest.getListAltitudes(); %>  		

<br>
			    <span title="Date" style="font-size:20pt;" class="glyphicon glyphicon-calendar"></span>  &nbsp;
			    <span title="Date" style="font-size:14pt;" > <% out.print(dateToShow2.substring(0, 10));  %> à  <% out.print(dateToShow2.substring(11, 16));  %>  </span>
<br>	
<br>		

 <table class="table">
				<TR>
					<TD id="time2TD" title="Temps" class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-time"></span> 
					  <span id="time2SP" style="font-size:12pt; font-family:Verdana;">  <% out.print(listWorkout2.get(1)); %> </span>
					
					</TD> 
						
					<TD id="dist2TD" title="Distance en mètre"  class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort"></span> 
					 <span id="dist2SP" style="font-size:12pt; font-family:Verdana;">  <% out.print(listWorkout2.get(2)); %>  </span>
								
					</TD>
						
					<TD id="ca2TD" title="Calories brûlées" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-fire"></span>	
					 <span id="ca2SP" style="font-size:12pt; font-family:Verdana;">  <% out.print(listWorkout2.get(3)); %> </span>
					
					</TD>
						
					<TD id="speed2TD" title="Vitesse moyenne en km/h" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-flash"></span>	
					 <span id="speed2SP" style="font-size:12pt; font-family:Verdana;">  <% out.print(listWorkout2.get(4)); %> </span>	
					
					</TD>
						
					<TD title="Altitude moyenne en mètre" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:12pt; font-family:Verdana;"> <% out.print(rest.getAltitudeAverage(listAltitude2)); %> </span>	
					
					</TD>
				</TR>
 		    
		<TR>
		
					<%		
					// Données Hexoskin
					// Test if we have something in param 
					if(request.getParameter("date2") != null){
						dateHEXO = request.getParameter("date2");
						dateHEXO = dateHEXO.substring(0, 10);
						dateHEXO = dateHEXO.replace('.', '-');
					}
				     // If not we show the last workout
					else{
						dateHEXO = dateToShow2;
						dateHEXO = dateHEXO.substring(0, 10);
						dateHEXO = dateHEXO.replace('.', '-');
					}
					// Get data from hexoskin API with datatype
					List<String> listPulsation2 = restHEXO.returnAllValueFromJson(dateHEXO, "19");
					List<String> listSteps2 = restHEXO.returnAllValueFromJson(dateHEXO, "52");
					List<String> listBreathing2 = restHEXO.returnAllValueFromJson(dateHEXO, "33");
					List<String> listVentilation2 = restHEXO.returnAllValueFromJson(dateHEXO, "36");
					List<String> listVolumeTidal2 = restHEXO.returnAllValueFromJson(dateHEXO, "37");
					
					String avgTidal2  = restHEXO.getAverageFromList(listVolumeTidal2);
					String volumTidal2 = restHEXO.changeMltoLwith2Decimals(avgTidal2);
					
					String avgVentilation2  = restHEXO.getAverageFromList(listVentilation2);
					String ventilation2 = restHEXO.changeMltoLwith2Decimals(avgVentilation2);%>
		
					<TD id="puls2TD" title="Pulsation moyenne" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-heart"></span>						
					<span id="puls2SP"  style="font-size:12pt; font-family:Verdana;"><% out.print(restHEXO.getAverageFromList(listPulsation2));  %> </span>	
					
					</TD> 
					
					<TD  title="Total pas"  class="info">
					<span style="font-size:14pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:12pt; font-family:Verdana;"> &nbsp; <% out.print(listSteps2.get(listSteps2.size()-1));   %> </span>	
								
					</TD>
					
					<TD title="Volume Tidal moyen en mL/inspiration" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(volumTidal2);  %> </span>	
					
					</TD>
					
					<TD title="Respiration min moyenne" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(restHEXO.getAverageFromList(listBreathing2));   %> </span>	
					
					</TD>
					
					<TD title="Ventilation moyenne mL/min)" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<%  out.print(ventilation2);  %>  </span>	
					
					</TD>
				</TR>
				</table>
						
<br>
<br>	

				    <h3 >Graphiques </h3>					
<br>
						<div id="chart_div2" style="width: 100%; height: 400px;"> </div>
						<button title="Cacher la vitesse" class="btn btn-default"  style="margin-left:90px;" type="button" id="hideSpeed2"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Vitesses</button>
   						<button title="Cacher la pulsation" class="btn btn-default" type="button" id="hidePulsation2"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Pulsation</button>
   						<button  title="Voir tout" class="btn btn-default" type="button" id="seeAll2"  > <span class="glyphicon glyphicon-eye-open"></span> &nbsp;Tout</button>
<br>
						<div id="chart_div4" style="width: 100%; height: 400px;"></div>	
						<button title="Cacher la respiration" class="btn btn-default" style="margin-left:90px;"  type="button" id="hideRespiration2"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Respiration</button>
   						<button title="Cacher la ventilation" class="btn btn-default" type="button" id="hideVentilation2"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Ventilation</button>
   						<button title="Cacher le volume tidal" class="btn btn-default" type="button" id="hideVolumeTidal2"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Volume Tidal</button>
   						<button  title="Voir tout" class="btn btn-default" type="button" id="seeAll4"  > <span class="glyphicon glyphicon-eye-open"></span> &nbsp;Tout</button>
				
											
					</div>
					
<br>					
					 <h3 >Cartes  </h3>	
					
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
		

	
			



			<br> <span id="signinButton" style="display: none"> <span
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
