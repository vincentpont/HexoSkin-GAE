<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="restHexoSkin.RestInvokerHexo"%>
<%@ page import="java.util.List;"%>

<!-- Import script file for login, maps and charts -->
<script src="js/login.js"></script>
<script src="js/index.js"></script>

<!--  Get Variable from Servlet or in Param -->
<%  
final String lastDateWorkout = (String) request.getAttribute("lastDateWorkout"); 
final String email = "vincentpont@gmail.com";
final String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";
final RestInvokerHexo restHexo = new RestInvokerHexo(s1); 
final RestInvokerDatastore restData = new RestInvokerDatastore(); 
String paramDate = "";

// Test if we have something in param 
if(request.getParameter("date") != null){
	paramDate = request.getParameter("date");	
}


String restHexoDate1 = "" ;
List<String> list ;

// Test if we have something in param 
if(request.getParameter("date") != null){
	restData.getDataMap(email, paramDate); 
	list = restData.getDataWorkoutByEmailAndDate(paramDate, email);
	restHexoDate1 = paramDate.substring(0, 10);
	restHexoDate1 = restHexoDate1.replace('.', '-');
	
}
 // If not we show the last workout
else{ 
	restData.getDataMap(email, lastDateWorkout); 
	list = restData.getDataWorkoutByEmailAndDate(lastDateWorkout, email);
	restHexoDate1 = lastDateWorkout.substring(0, 10);
	restHexoDate1 = restHexoDate1.replace('.', '-');
}


List<String> listPulsations = restHexo.returnAllValueFromJson(restHexoDate1, "19"); 
List<String> listVolumeTidals = restHexo.returnAllValueFromJson(restHexoDate1, "37"); 
List<String> listRespirationFreqs = restHexo.returnAllValueFromJson(restHexoDate1, "33"); 
List<String> listVentilations = restHexo.returnAllValueFromJson(restHexoDate1, "36"); 

List<Double> listVitesses = restData.getListVitesses();
List<Double> listAltitudes = restData.getListAltitudes();


StringBuffer stringBufferPulsation = new StringBuffer();
StringBuffer stringBufferVitesses = new StringBuffer();
StringBuffer stringBufferVolumeTidal = new StringBuffer();
StringBuffer stringBufferRespirationFreq = new StringBuffer();
StringBuffer stringBufferVentilations = new StringBuffer();
StringBuffer stringBufferAltitudes = new StringBuffer();

stringBufferPulsation = restData.convertListToStringBufferInteger(listPulsations);
stringBufferVitesses = restData.convertListToStringBufferInteger(listVitesses);
stringBufferVolumeTidal = restData.convertListToStringBufferInteger(listVolumeTidals);
stringBufferRespirationFreq = restData.convertListToStringBufferInteger(listRespirationFreqs);
stringBufferVentilations = restData.convertListToStringBufferInteger(listVentilations);
stringBufferAltitudes = restData.convertListToStringBufferInteger(listAltitudes);

String timeTotal  = (String) list.get(1);

%>

<!-- Google Charts -->

<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<script type="text/javascript">


	google.load("visualization", "1.1", {
		packages : [ "corechart" ]
	});
		
    var arrayVitesses = [ <%= stringBufferVitesses.toString() %> ];
    var arrayAltitudes = [ <%= stringBufferAltitudes.toString() %> ];
  	var arrayPulsation = [ <%= stringBufferPulsation.toString() %> ];
    var arrayVolumeTidal = [ <%= stringBufferVolumeTidal.toString() %> ];
    var arrayRespiration = [ <%= stringBufferRespirationFreq.toString() %> ];
    var arrayVentilation = [ <%= stringBufferVentilations.toString() %> ];
    var timeTotal =  '<%=timeTotal%>';
    var multiple;

    // Call method
	modifyListFirstTime();
    
	// Draw chart
	google.setOnLoadCallback(drawChart);
 
</script>

	<%
	// Test if we have something in param 
	if(request.getParameter("date") != null){
		restData.getDataMap(email, paramDate); 
	} // If not we show the last workout
	else{
		restData.getDataMap(email, lastDateWorkout); 
	}
	
	List<Double> listLatitude = restData.getListLatitudes();
	List<Double> listLongitude = restData.getListLongitudes();
	List<Double> listSpeed = restData.getListVitesses();
	List<Double> listAltitude = restData.getListAltitudes();

	StringBuffer stringBufferLat = new StringBuffer();
	StringBuffer stringBufferLong = new StringBuffer();
	StringBuffer stringBufferSpeed = new StringBuffer();
	StringBuffer stringBufferAlti = new StringBuffer();
	
	// Convert to stringbuffer to pass the list in javascript array
	stringBufferLat = restData.convertListToStringBuffer(listLatitude);
	stringBufferLong = restData.convertListToStringBuffer(listLongitude);
	stringBufferSpeed = restData.convertListToStringBuffer(listSpeed);
	stringBufferAlti = restData.convertListToStringBuffer(listAltitude);
	%>
	
	<!-- Google MAPS -->
<script
	src="https://maps.googleapis.com/maps/api/js?v=3?key={AIzaSyA9MSARpM9GdjunV4sR5mxpOuD3pfkyldc}">
</script>
<script 
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization">
</script>
	
<script>

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

<title>HexoSkin-Training</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-3.1.1/dist/css/bootstrap.min.css">
<link href="bootstrap-3.1.1/dist/css/dashboard.css" rel="stylesheet">

<!-- Import login.js -->
<script src="js/login.js"></script>

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
				<a class="navbar-brand" href="training">HexoSkin</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="profile">Profil</a></li>
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
					<li><a href="statistic">Statistiques</a></li>
				    <li><a href="definition.jsp">Définitions</a></li>
		        </ul>
			</div>

			<%
				List<String> listWorkout  ;
				String dateToShow = "";
				// Test if we have something in param 
				if(request.getParameter("date") != null){
					dateToShow = paramDate;
					listWorkout = restData.getDataWorkoutByEmailAndDate(paramDate,
							email);
				}
			     // If not we show the last workout
				else{
					dateToShow = lastDateWorkout;
					listWorkout = restData.getDataWorkoutByEmailAndDate(lastDateWorkout,
							email);
				}
			%>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			
			<!-- Test if the user had clicked in history or not to change the corresponding title -->
			<% if (request.getParameter("date") != null ){
				out.print("<h3 class='page-header'>Entraînement du</h3>");
			}
			else{
				out.print("<h3 class='page-header'>Dernier entraînement</h3>");
			}
			%>

			    <span title="Date" style="font-size:20pt;" class="glyphicon glyphicon-calendar"></span>  &nbsp;
				<span title="Date" style="font-size:14pt;" > <% out.print(dateToShow.substring(0, 10));  %> à  <% out.print(dateToShow.substring(11, 16));  %>  </span>

				<table class="table">
				<TR>
					<TD title="Temps total" class="success">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-time"></span> 
						<span style="font-size:14pt; font-family:Verdana;"> <% out.print(listWorkout.get(1)); %> </span>
					</TD> 
						
					<TD  title="Distance en mètres"  class="success">				
						<span  style="font-size:21pt;" class="glyphicon glyphicon-sort"></span> 
						 <span style="font-size:14pt; font-family:Verdana;">  <% out.print(listWorkout.get(2)); %> </span>
					</TD>
						
					<TD title="Calories brûlées" class="success">
						<span style="font-size:21pt;" class="glyphicon glyphicon-fire"></span>	
						 <span style="font-size:14pt; font-family:Verdana;">&nbsp; 
						  <% out.print(listWorkout.get(3)); %></span>
					</TD>
						
					<TD title="Vitesse moyenne en km/h" class="success">
						<span style="font-size:21pt;" class="glyphicon glyphicon-flash"></span>	
						 <span style="font-size:14pt; font-family:Verdana;">&nbsp;  <% out.print(listWorkout.get(4)); %> </span>	
											
					</TD>
						
					<TD title="Altitude moyenne en mètres" class="success">
						<span style="font-size:21pt;" class="glyphicon glyphicon-signal"></span>	
						 <span style="font-size:14pt; font-family:Verdana;">&nbsp; <% out.print(restData.getAltitudeAverage(listAltitude)); %> </span>				
					</TD>
				</TR>
		
			<%	
			String restHexoDate2 = "" ;
			
			// Test if we have something in param 
			if(request.getParameter("date") != null){
				restHexoDate2 = paramDate.substring(0, 10);
				restHexoDate2 = restHexoDate2.replace('.', '-');
			}
		     // If not we show the last workout
			else{
				restHexoDate2 = lastDateWorkout.substring(0, 10);
				restHexoDate2 = restHexoDate2.replace('.', '-');
			}
			
			List<String> listPulsation = restHexo.returnAllValueFromJson(restHexoDate2, "19");
			List<String> listSteps = restHexo.returnAllValueFromJson(restHexoDate2, "52");
			List<String> listBreathing = restHexo.returnAllValueFromJson(restHexoDate2, "33");
			List<String> listVentilation = restHexo.returnAllValueFromJson(restHexoDate2, "36");
			List<String> listVolumeTidal = restHexo.returnAllValueFromJson(restHexoDate2, "37");
			
			String avgTidal  = restHexo.getAverageFromList(listVolumeTidal);
			String volumTidal = restHexo.changeMltoLwith2Decimals(avgTidal);
			
			String avgVentilation  = restHexo.getAverageFromList(listVentilation);
			String ventilation = restHexo.changeMltoLwith2Decimals(avgVentilation);

			%>
			
				<TR>
					<TD title="Pulsation min moyenne" class="info">
						<span  style="font-size:21pt;" class="glyphicon glyphicon-heart"></span>						
						<span style="font-size:14pt; font-family:Verdana;">
						<% out.print(restHexo.getAverageFromList(listPulsation));  %> </span>	
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
						<span style="font-size:14pt; font-family:Verdana;">&nbsp; <% out.print(restHexo.getAverageFromList(listBreathing));   %> </span>	
					</TD>
					
					<TD title="Ventilation moyenne l/min" class="info">
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
							<button title="Afficher les vitesses." style="margin-top:12pt;" type='button' class="btn btn-warning btn-sm" onclick="addSpeed();"><span class="glyphicon glyphicon-flash"></span></button>
							<button title="Montrer si la vitesse est constante." style="margin-top:12pt;"  type='button' class="btn btn-warning btn-sm" onclick="addConstanceSpeed();"><b>Constance</b></button>
							</TD>
						</TR>
										
						<TR>						
							<TD>
							<button title="Afficher toutes les pulsations." style="margin-top:12pt;" type='button' class="btn btn-danger btn-sm" onclick="addHeartRate();"><span class="glyphicon glyphicon-heart"></span></button>	
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
			<h5> <b> Légende </b>  </h5>
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
										<button style="margin-left:190px;" title="Cacher la vitesse." class="btn btn-default btn-sm" type="button" id="hideSpeed"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Vitesse</button>
										<button  title="Cacher l'altitue." class="btn btn-default btn-sm" type="button" id="hideAltitude"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Altitude</button>				   					
				   						<button  title="Cacher la pulsation." class="btn btn-default btn-sm" type="button" id="hidePulsation"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Pulsation</button>
										<button  title="Cacher le volume tidal." class="btn btn-default btn-sm" type="button" id="hideTidal"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Volume ti. </button>
										<button  title="Cacher la respiration." class="btn btn-default btn-sm" type="button" id="hideRespiration"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Repiration</button>
										<button  title="Cacher la ventilation." class="btn btn-default btn-sm" type="button" id="hideVentilation"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Ventilation</button>
				   						<button  title="Voir tout." class="btn btn-default btn-sm" type="button" id="seeAll"> &nbsp; <span class="glyphicon glyphicon-eye-open"></span> &nbsp;</button>
										</TD>
									</TR>
								</table>

					</div>
					 
			

		</div>
	</div>
	

<div class="row">
		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<hr>
		<footer style="font-size:9pt;">
						<b>Copyright ©2014 HexoSkin Travail de bachelor. Tous droits
							réservés.</b> 
						<img title="Logo hes-so Valais" align="right"height="30px" src="img/hes_logo.jpg" />
		</footer>
		</div>
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
