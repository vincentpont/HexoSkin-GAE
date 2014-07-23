<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="restHexoSkin.RestInvokerHexo"%>
<%@ page import="java.util.Iterator, java.util.List"%>

<!-- Import script file for login, maps and charts -->
<script src="js/login.js"></script>
<script src="js/compare.js"></script>

<!--  Get Variable Servlet -->
<%  String lastDateWorkout = (String) request.getAttribute("lastDateWorkout"); %>


<%
String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";
RestInvokerHexo restHEXO = new RestInvokerHexo(s1); 
RestInvokerDatastore restMap = new RestInvokerDatastore(); 
String hexoDate1 = "" ;
String hexoDateSub1 = "";
List list1 = null ;

// Test if we have something in param 
if(request.getParameter("date1") != null){
	hexoDate1 = request.getParameter("date1");
	restMap.getDataMap("vincentpont@gmail.com", hexoDate1); 
	list1 = restMap.getDataWorkoutByEmailAndDate(hexoDate1, "vincentpont@gmail.com");
	hexoDateSub1 = hexoDate1.substring(0, 10);
	hexoDateSub1 = hexoDateSub1.replace('.', '-');
	
}
 // If not we show the last workout
else if (request.getParameter("date1") == null){
	hexoDate1 = lastDateWorkout; 
	restMap.getDataMap("vincentpont@gmail.com", hexoDate1); 
	list1 = restMap.getDataWorkoutByEmailAndDate(hexoDate1, "vincentpont@gmail.com");
	hexoDateSub1 = hexoDate1.substring(0, 10);
	hexoDateSub1 = hexoDateSub1.replace('.', '-');
}

List<String> listPulsations1 = restHEXO.returnAllValueFromJson(hexoDateSub1, "19"); 
List<Double> listVitesses1 = restMap.getListVitesses();
List<Double> listAltitude1 = restMap.getListAltitudes();

StringBuffer stringBufferPulsation1 = new StringBuffer();
StringBuffer stringBufferVitesses1 = new StringBuffer();
StringBuffer stringBufferAltitude1 = new StringBuffer();

stringBufferPulsation1 = restMap.convertListToStringBufferInteger(listPulsations1);
stringBufferVitesses1 = restMap.convertListToStringBufferInteger(listVitesses1);
stringBufferAltitude1 = restMap.convertListToStringBufferInteger(listAltitude1);

String timeTotal1  = (String) list1.get(1);

%>

<!-- Google charts Pulsation/Vitesse trajet 1-->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

    var arrayVitesses1 = [ <%= stringBufferVitesses1.toString() %> ];
    var arrayAltitude1 =  [ <%= stringBufferAltitude1.toString() %> ];
    var timeTotal1 =  '<%=timeTotal1%>';

	var arrayToHideSpeedAlti1 = new Array();
	var indexSpeedAlti1 = 0 ;

		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChartSpeed1);
		
		
</script>

<%
List<String> listVolumeTidals1 = restHEXO.returnAllValueFromJson(hexoDateSub1, "37"); 
List<String> listRespirationFreqs1 = restHEXO.returnAllValueFromJson(hexoDateSub1, "33"); 
List<String> listVentilations1 = restHEXO.returnAllValueFromJson(hexoDateSub1, "36"); 

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

		var arrayPulsation1 = [ <%= stringBufferPulsation1.toString() %> ];
		var arrayVolumeTidal1 = [ <%= stringBufferVolumeTidal1.toString() %> ];
		var arrayRespiration1 = [ <%= stringBufferRespirationFreq1.toString() %> ];
		var arrayVentilation1 = [ <%= stringBufferVentilations1.toString() %> ];
		
		var arrayToHide1 = new Array();
		var index1 = 0 ;


		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChartResp1);
		
		
</script>

<%
	List list2 = null ;

	String hexoDate2 = "";
	String hexoDateSub2 = "";
	// Test if we have something in param 
	if(request.getParameter("date2") != null){
		hexoDate2 = request.getParameter("date2");
		restMap.getDataMap("vincentpont@gmail.com", hexoDate2); 
		list2 = restMap.getDataWorkoutByEmailAndDate(hexoDate2, "vincentpont@gmail.com");
		hexoDateSub2 = hexoDate2.substring(0, 10);
		hexoDateSub2 = hexoDateSub2.replace('.', '-');
		
	}
	 // If not we show the last workout
	else if (request.getParameter("date2") == null)	{
		hexoDate2 = lastDateWorkout; 
		restMap.getDataMap("vincentpont@gmail.com", hexoDate2); 
		list2 = restMap.getDataWorkoutByEmailAndDate(hexoDate2, "vincentpont@gmail.com");
		hexoDateSub2 = hexoDate2.substring(0, 10);
		hexoDateSub2 = hexoDateSub2.replace('.', '-');
	}

	List<String> listPulsations2 = restHEXO.returnAllValueFromJson(hexoDateSub2, "19"); 
	List<Double> listVitesses2 = restMap.getListVitesses();
	List<Double> listAltitudes2 = restMap.getListAltitudes();
	
	StringBuffer stringBufferPulsation2 = new StringBuffer();
	StringBuffer stringBufferVitesses2 = new StringBuffer();
	StringBuffer stringBufferAltitudes2 = new StringBuffer();
	
	stringBufferPulsation2 = restMap.convertListToStringBufferInteger(listPulsations2);
	stringBufferVitesses2 = restMap.convertListToStringBufferInteger(listVitesses2);
	stringBufferAltitudes2 = restMap.convertListToStringBufferInteger(listAltitudes2);
	
	String timeTotal2  = (String) list2.get(1);
	
%>

<!-- Google chart Pulsation/Vitesse trajet 2 -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

	var arrayVitesses2 = [ <%= stringBufferVitesses2.toString() %> ];
	var arrayAltitudes2 = [ <%= stringBufferAltitudes2.toString() %> ];
    var timeTotal2 =  '<%=timeTotal2%>';

	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	
	google.setOnLoadCallback(drawChartSpeed2);
	

</script>

<%
List<String> listVolumeTidals2 = restHEXO.returnAllValueFromJson(hexoDateSub2, "37"); 
List<String> listRespirationFreqs2 = restHEXO.returnAllValueFromJson(hexoDateSub2, "33"); 
List<String> listVentilations2 = restHEXO.returnAllValueFromJson(hexoDateSub2, "36"); 

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


		var arrayPulsation2 = [ <%= stringBufferPulsation2.toString() %> ];
		var arrayVolumeTidal2 = [ <%= stringBufferVolumeTidal2.toString() %> ];
		var arrayRespiration2 = [ <%= stringBufferRespirationFreq2.toString() %> ];
		var arrayVentilation2 = [ <%= stringBufferVentilations2.toString() %> ];
		var arrayToHide = new Array();
		var index = 0 ;

		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChartResp2);
		
</script>


<!-- Google MAPS -->
<script
	src="https://maps.googleapis.com/maps/api/js?v=3?key={AIzaSyA9MSARpM9GdjunV4sR5mxpOuD3pfkyldc}">
</script>
<script 
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization">
</script>


<%
// Trajet 1
restMap.getDataMap("vincentpont@gmail.com", hexoDate1); 
List<Double> listLatitude1 = restMap.getListLatitudes();
List<Double> listLongitude1 = restMap.getListLongitudes();

StringBuffer stringBufferLat1 = new StringBuffer();
StringBuffer stringBufferLong1 = new StringBuffer();

stringBufferLat1 = restMap.convertListToStringBuffer(listLatitude1);
stringBufferLong1 = restMap.convertListToStringBuffer(listLongitude1);

// trajet 2
restMap.getDataMap("vincentpont@gmail.com", hexoDate2); 
List<Double> listLatitude2 = restMap.getListLatitudes();
List<Double> listLongitude2 = restMap.getListLongitudes();

StringBuffer stringBufferLat2 = new StringBuffer();
StringBuffer stringBufferLong2 = new StringBuffer();

stringBufferLat2 = restMap.convertListToStringBuffer(listLatitude2);
stringBufferLong2 = restMap.convertListToStringBuffer(listLongitude2);

%>

<script>

	// Path 1
	var arrayLat1 = [ <%= stringBufferLat1.toString() %> ];
	var arrayLong1 = [ <%= stringBufferLong1.toString() %> ];
	var arraySpeed1 = [ <%= stringBufferVitesses1.toString() %> ];
	var arrayPulsation1 = [ <%= stringBufferPulsation1.toString() %> ];
	
	// Path 2
	var arrayLat2 = [ <%= stringBufferLat2.toString() %> ];
	var arrayLong2 = [ <%= stringBufferLong2.toString() %> ];
	var arraySpeed2 = [ <%= stringBufferVitesses2.toString() %> ];
	var arrayPulsation2 = [ <%= stringBufferPulsation2.toString() %> ];
	
	var pathStyle1;
	var pathStyle2;
	var map;
 	var startMarker, endMarker;
 	
 	// Load map
	google.maps.event.addDomListener(window, 'load', initialize);
	google.maps.event.addDomListener(window, 'resize', initialize);

   </script>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="img/icoFav.png">


<title>HexoSkin-Compare</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-3.1.1/dist/css/bootstrap.min.css">
<link href="bootstrap-3.1.1/dist/css/dashboard.css" rel="stylesheet">

</head>

<body onload="changeColor();">


	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="training">HexoSkin</a>
			</div>
			<div class="navbar-collapse collapse" >
				<ul class="nav navbar-nav navbar-right">
					<li><a href="profile">Profile</a></li>
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
					<li><a href="training">Entraînement</a></li>
					<li><a href="compare">Comparer</a></li>
					<li><a href="historique.jsp">Historique</a></li>
				</ul>
				
				<ul class="nav nav-sidebar">
					<li><a href="statistic">Statistique</a></li>
				    <li><a href="definition.jsp">Définitions</a></li>
		        </ul>
			</div>
			

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

					<h1 class="page-header">Comparatif séances &nbsp;
				   	<img src="img/compare.png" width="45px" height="45px"/> 
					</h1>
					
<br>
					<h3>Choisissez deux séances à comparer</h3>
<br>				
				    <%
					RestInvokerDatastore rest =  new RestInvokerDatastore();
					List listDates1 = rest.getAllDatesWorkoutSorted("vincentpont@gmail.com");
					Iterator<String> iterator1 = listDates1.iterator();
					%>

					<div class="col-md-6">	
					<form action="compare" method="get" onSubmit="return testChoice();">
				    <select id="selecte1" name="date1" class="form-control" style="font-size:14pt;">
					    <option value="">-- Choisissez une date -- </option>
					    <%for(int i = 0 ; i<listDates1.size() ;i++){%>
					        <option value="<% out.print(listDates1.get(i)); %>"> <%out.print(listDates1.get(i));%> </option>
					    <%} %>
					</select>
					
<br>
<button type='submit' class="btn btn-success"> <b> Afficher</b> </button>
<br>
<br>
				 <%
				 	// Données datastore (android)
				 
					List<String> listWorkout1 = null ;
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
						dateToShow1 = lastDateWorkout;
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
					<TD id="time1TD" title="Temps total." class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-time"></span> 
					 <span id="time1SP"  style="font-size:11pt; font-family:Verdana;"> <% out.print(listWorkout1.get(1)); %> </span>
					
					</TD> 
						
					<TD  id="dist1TD" title="Distance en mètre."  class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort"></span> 
					 <span id="dist1SP" style="font-size:11pt; font-family:Verdana;"> <% out.print(listWorkout1.get(2)); %>  </span>
								
					</TD>
						
					<TD id="ca1TD" title="Calories brûlées." class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-fire"></span>	
					 <span id="ca1SP" style="font-size:11pt; font-family:Verdana;"> <% out.print(listWorkout1.get(3)); %> </span>
					
					</TD>
						
					<TD  id="speed1TD" title="Vitesse moyenne en km/h." class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-flash"></span>	
					 <span id="speed1SP" style="font-size:11pt; font-family:Verdana;">  <% out.print(listWorkout1.get(4)); %> </span>	
					
					</TD>
						
					<TD title="Altitude moyenne en mètre." class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:11pt; font-family:Verdana;"> &nbsp;<% out.print(rest.getAltitudeAverage(listAltitude)); %> </span>	
					
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

					<TD  id="puls1TD" title="Pulsation min moyenne." class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-heart"></span>						
					<span id="puls1SP" style="font-size:11pt; font-family:Verdana;"> <% out.print(restHEXO.getAverageFromList(listPulsation1));   %> </span>	
					
					</TD> 
					
					<TD  title="Total pas."  class="info">
					<span style="font-size:14pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:11pt; font-family:Verdana;">  <% out.print(listSteps1.get(listSteps1.size()-1));  %> </span>	
								
					</TD>
					
					<TD title="Volume Tidal moyen l/inspiration." class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:11pt; font-family:Verdana;"> <%  out.print(volumTidal1);   %> </span>	
					
					</TD>
					
					<TD title="Respiration min moyenne." class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:11pt; font-family:Verdana;"> <% out.print(restHEXO.getAverageFromList(listBreathing1));   %> </span>	
					
					</TD>
					
					<TD title="Ventilation moyenne l/min." class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:11pt; font-family:Verdana;"> <%  out.print(ventilation1);  %>  </span>	
					
					</TD>
				</TR>
				</table>

<br>		
<br>
<br>
				    <h3>Graphiques </h3>
<br>
						<div id="chart_div1" style="width: 100%; height: 400px;"></div>
						
						<button title="Cacher l'altitude." class="btn btn-default btn-sm"  style="margin-left:90px;" type="button" id="hideAlti1"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Altitude</button>
						<button title="Cacher la vitesse." class="btn btn-default btn-sm"  type="button" id="hideSpeed1"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Vitesse</button>
   						<button title="Voir tout." class="btn btn-default btn-sm" type="button" id="seeAll1"  > &nbsp; <span class="glyphicon glyphicon-eye-open"></span> &nbsp;</button>

<br>
						<div id="chart_div3" style="width: 100%; height: 400px;"></div>
<br>
						<button title="Cacher la pulsation." class="btn btn-default btn-sm" style="margin-left:90px;" type="button" id="hidePulsation1"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Pulsation</button>
						<button title="Cacher la respiration." class="btn btn-default btn-sm"  type="button" id="hideRespiration1"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Respi.</button>
   						<button title="Cacher la ventilation." class="btn btn-default btn-sm" type="button" id="hideVentilation1"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Venti.</button>
 <br>
   						<button title="Cacher le volume tidal." class="btn btn-default btn-sm" style="margin-left:165px; margin-top:8px;" type="button" id="hideVolumeTidal1"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Vol. Ti</button>
   						<button title="Voir tout." class="btn btn-default btn-sm"  style="margin-top:8px;"type="button" id="seeAll3"  > &nbsp; <span class="glyphicon glyphicon-eye-open"></span> &nbsp;</button>
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
<div style="height: 14px;"> </div>
<br>
<br>				

<% 					// Donnée datastore (android)
					List<String> listWorkout2 = null ;
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
						dateToShow2 = lastDateWorkout;
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
					<TD id="time2TD" title="Temps total." class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-time"></span> 
					  <span id="time2SP" style="font-size:11pt; font-family:Verdana;">  <% out.print(listWorkout2.get(1)); %> </span>
					
					</TD> 
						
					<TD id="dist2TD" title="Distance en mètre."  class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort"></span> 
					 <span id="dist2SP" style="font-size:11pt; font-family:Verdana;">  <% out.print(listWorkout2.get(2)); %>  </span>
								
					</TD>
						
					<TD id="ca2TD" title="Calories brûlées." class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-fire"></span>	
					 <span id="ca2SP" style="font-size:11pt; font-family:Verdana;">  <% out.print(listWorkout2.get(3)); %> </span>
					
					</TD>
						
					<TD id="speed2TD" title="Vitesse moyenne en km/h." class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-flash"></span>	
					 <span id="speed2SP" style="font-size:11pt; font-family:Verdana;">  <% out.print(listWorkout2.get(4)); %> </span>	
					
					</TD>
						
					<TD title="Altitude moyenne en mètre." class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:11pt; font-family:Verdana;"> <% out.print(rest.getAltitudeAverage(listAltitude2)); %> </span>	
					
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
		
					<TD id="puls2TD" title="Pulsation moyenne." class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-heart"></span>						
					<span id="puls2SP"  style="font-size:11pt; font-family:Verdana;"><% out.print(restHEXO.getAverageFromList(listPulsation2));  %> </span>	
					
					</TD> 
					
					<TD  title="Total pas."  class="info">
					<span style="font-size:14pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:11pt; font-family:Verdana;"> &nbsp; <% out.print(listSteps2.get(listSteps2.size()-1));   %> </span>	
								
					</TD>
					
					<TD title="Volume Tidal moyen en l/inspiration." class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:11pt; font-family:Verdana;"> &nbsp;<% out.print(volumTidal2);  %> </span>	
					
					</TD>
					
					<TD title="Respiration min moyenne." class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:11pt; font-family:Verdana;"> &nbsp;<% out.print(restHEXO.getAverageFromList(listBreathing2));   %> </span>	
					
					</TD>
					
					<TD title="Ventilation moyenne l/min" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:11pt; font-family:Verdana;"> &nbsp;<%  out.print(ventilation2);  %>  </span>	
					
					</TD>
				</TR>
				</table>
						
<br>

<br>
<br>	

<div style="height: 56px;"> </div>			   				
<br>
						<div id="chart_div2" style="width: 100%; height: 400px;"> </div>
						
						<button title="Cacher l'altitude." class="btn btn-default btn-sm"  style="margin-left:90px;" type="button" id="hideAlti2"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Altitude</button>
						<button title="Cacher la vitesse." class="btn btn-default btn-sm"  type="button" id="hideSpeed2"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Vitesse</button>
   						<button title="Voir tout." class="btn btn-default btn-sm" type="button" id="seeAll2"  > &nbsp; <span class="glyphicon glyphicon-eye-open"></span> &nbsp;</button>
						
<br>

						<div id="chart_div4" style="width: 100%; height: 400px;"></div>	
<br>
						<button title="Cacher la pulsation." class="btn btn-default btn-sm" style="margin-left:90px;" type="button" id="hidePulsation2"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Pulsation</button>
						<button title="Cacher la respiration." class="btn btn-default btn-sm"  type="button" id="hideRespiration2"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Respi.</button> 
   						<button title="Cacher la ventilation." class="btn btn-default btn-sm" type="button" id="hideVentilation2"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Venti.</button>
<br>
   						<button title="Cacher le volume tidal." class="btn btn-default btn-sm" type="button" style="margin-left:165px; margin-top:8px;" id="hideVolumeTidal2"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Vol. Ti</button>
   						<button  title="Voir tout." class="btn btn-default btn-sm" style="margin-top:8px;" type="button" id="seeAll4"  > &nbsp; <span class="glyphicon glyphicon-eye-open"></span> &nbsp;</button>
				
											
					</div>
<br>					

		  				 <div class="col-xs-12 col-md-8">	
<br>
<br>
		  				 <h3> Cartes </h3>		
<br>
				  		    <div id="map-canvas" style="width:100%;height:400px;"></div>	
				  		 </div>  				  		 
						 <div class="col-xs-12 col-md-4">

<div style="height: 125px;"> </div>

						 <h5> <b> Filtres </b> </h5> 
  						<table>
						<TR>
							<TD>

<br>
							<button title="Enlever le chemin de la carte." type='button' class="btn btn-default btn-sm" onclick="removePaths();"><b>Enlever chemin</b></button>	
							<button title="Enlever les points de départ et stop." type='button' class="btn btn-default btn-sm" onclick="removeStartEndPointPath1();"><b>Enlever départ/stop</b></button>	
<br>
<br>
							<button title="Montrer les différences de vitesses." style="margin-top:12pt;" type='button' class="btn btn-warning btn-sm" onclick="addDiffSpeed();"><b>Calculer vitesses</b></button>
<br>
							<button title="Montrer les différences de pulsation." style="margin-top:12pt;" type='button' class="btn btn-danger btn-sm" onclick="addDiffHeart();"><b>Calculer pulsations</b></button>
<br>
<br>
							<button  title="Recharger la carte et réinitialiser." style="margin-top:15pt;" type='button' class="btn btn-success" onclick="initialize();"> <b> <span class="glyphicon glyphicon-refresh"> </span>  &nbsp; Recharger  </b></button>
							</TD>
						</TR>
					</table>
						 </div>
						</div> 
<br>

		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		
			<h5> <b> Légende </b>  </h5>
<br>				
			<table>
			<TR>
			
				<TD> <span style="font-style:italic; font-size:11pt;"> Première séance : &nbsp; </span>
				<img title="Tracé du premier chemin de la séance parcourue." src="img/path.png"/> 
				
<br>

				<span style="font-style:italic; font-size:11pt;"> Deuxième séance : &nbsp; </span>
				<img title="Tracé du deuxième chemin de la séance parcourue." src="img/path2.png"/> 
				
<br>
			    
			    <span style="font-style:italic; font-size:11pt;"> Point début/stop : </span>
				<img title="Point de départ." src="img/dd-start.png"/> 
				<img title="Point d'arrivée." src="img/dd-end.png"/> 
<br>				
				<span style="font-style:italic; font-size:11pt;"> Degré de pulsation entre les deux séances :   </span>
				<img title="Vitesse basse." src="img/h1.png"/>  <span style="font-size:10pt;"><%out.print("<b>< </b>"); %>20</span>
				<img title="Vitesse moyenne." src="img/h2.png"/> <span style="font-size:10pt;">entre 20 et 40</span>
				<img title="Vitesse haute." src="img/h3.png"/> <span style="font-size:10pt;"><%out.print("<b>> </b>"); %>40</span>
						
 <br>			
				<span style="font-style:italic; font-size:11pt;"> Degré de vitesse entre les deux séances :  </span>
				<img title="Vitesse basse." src="img/Speedlow.png"/> <span style="font-size:10pt;"><%out.print("<b>< </b>"); %>3</span>  
				<img title="Vitesse moyenne." src="img/SpeedMiddle.png"/> <span style="font-size:10pt;">entre 3 et 6 </span> 
				<img title="Vitesse haute." src="img/SpeedMax.png"/> <span style="font-size:10pt;"><%out.print("<b>> </b>"); %>6 </span>  
    
		    
			    </TD>
			    
			</TR>
			</table>
					 
			</div>

		</div>
	</div>
				
		
<div   class="row">
		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<hr>
		<footer style="font-size:9pt;">
						<b>Copyright ©2014 HexoSkin Travail de bachelor. Tous droits
							réservés.</b> 
						<img title="Logo hes-so Valais" align="right"height="30px" src="img/hes_logo.jpg" />
		</footer>
		</div>
	</div>
		
	<span id="signinButton" style="display: none"> <span
		class="g-signin" data-callback="signinCallbacks"
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
