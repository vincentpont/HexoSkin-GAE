<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
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
	function signinCallback(authResult) {
    	  if (authResult['access_token']) {
        		// Logged
        	  } else if (authResult['error']) {
          	document.getElementById('signinButton').setAttribute('style', 'display: none');
        		window.location = "login.jsp";
        	  }
	}
</script>

<!-- Google charts </body> -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		function drawChart() {
		  var data = google.visualization.arrayToDataTable([
		    ['Year', 'Sales', 'Expenses'],
		    ['2004',  1000,      400],
		    ['2005',  1170,      460],
		    ['2006',  660,       1120],
		    ['2007',  1030,      540]
		  ]);
		  var options = {
		    title: 'Company Performance'
		    
		  };
		  var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
		
		  chart.draw(data, options);
		
		
		 var hideSal = document.getElementById("hideSales");
		 hideSal.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    view.hideColumns([1]); 
		    chart.draw(view, options);
		 }
		 
		 var hideExp = document.getElementById("hideExpenses");
		 hideExp.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    view.hideColumns([2]); 
		    chart.draw(view, options);
		 }		 
		 
		 // See all
		 var seeAll = document.getElementById("seeAll");
		 seeAll.onclick = function()
		 {
		    view = new google.visualization.DataView(data);
		    view.setColumns([0,1,2]);
		    chart.draw(view, options);
		 }
		 

}
</script>



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
				.getElementById('chart_div3'));
		chart.draw(data, options);
	}
</script>




<script>
function logout() {
	document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://8-dot-logical-light-564.appspot.com/login.jsp";
}
</script>

<script>

// Not used bug
function selectElement(values)
{   
	var values = values.value;
	if(values != null){
		document.getElementById("selecte1").value = values;
		document.getElementsByName("date1").value = values;
	}
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
					<form action="compare.jsp" method="get">
				    <select id="selecte1" name="date1" class="form-control" style="font-size:14pt;">
					    <option value="">-- Choisissez une date-- </option>
					    <%for(int i = 0 ; i<listDates1.size() ;i++){%>
					        <option value="<% out.print(listDates1.get(i)); %>"> <%out.print(listDates1.get(i));%> </option>
					    <%} %>
					</select>
					
<br>
<button type='submit' class="btn btn-success" > Afficher </button>
<br>
<br>

				 <%
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
					else if(request.getParameter("date1") == null || request.getParameter("date1").isEmpty()){
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
					<TD title="Temps" class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-time"></span> 
					  <span style="font-size:12pt; font-family:Verdana;"> &nbsp; <% out.print(listWorkout1.get(1)); %> </span>
					
					</TD> 
						
					<TD  title="Distance en mètre"  class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort"></span> 
					 <span style="font-size:12pt; font-family:Verdana;"> &nbsp;  <% out.print(listWorkout1.get(2)); %>  </span>
								
					</TD>
						
					<TD title="Calories brûlées" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-fire"></span>	
					 <span style="font-size:12pt; font-family:Verdana;"> &nbsp; <% out.print(listWorkout1.get(3)); %> </span>
					
					</TD>
						
					<TD title="Vitesse moyenne en km/h" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-flash"></span>	
					 <span style="font-size:12pt; font-family:Verdana;">  <% out.print(listWorkout1.get(4)); %> </span>	
					
					</TD>
						
					<TD title="Altitude moyenne en mètre" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(rest.getAltitudeAverage(listAltitude)); %> </span>	
					
					</TD>
				</TR>
 		    
		<TR>

					<TD title="Pulsation moyenne" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-heart"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(0.0);  %> </span>	
					
					</TD> 
					
					<TD  title="Total pas"  class="info">
					<span style="font-size:14pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:12pt; font-family:Verdana;"> &nbsp; <% out.print(0.0);  %> </span>	
								
					</TD>
					
					<TD title="Volume Tidal moyen en mL/inspiration" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<%  out.print(0.0);  %> </span>	
					
					</TD>
					
					<TD title="Respiration min moyenne" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(0.0);   %> </span>	
					
					</TD>
					
					<TD title="Ventilation moyenne mL/min)" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<%  out.print(0.0);  %>  </span>	
					
					</TD>
				</TR>
				</table>
		
					

				
<br>
<br>
				    <h3>Graphiques </h3>
<br>
						   <div id="chart_div" style="width: 400px; height: 300px;"></div>
						 <button title="Cacher sales" class="btn btn-default" type="button" id="hideSales"  > <span class="glyphicon glyphicon-eye-close"></span>  &nbsp;Sales</button>
   						<button title="Cacher expense" class="btn btn-default" type="button" id="hideExpenses"  >  <span class="glyphicon glyphicon-eye-close"></span>  &nbsp; Expence</button>
   						<button  title="Voir tout" class="btn btn-default" type="button" id="seeAll"  > <span class="glyphicon glyphicon-eye-open"></span> &nbsp;Tout</button>

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

<% 
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
					else if(request.getParameter("date2") == null || request.getParameter("date2").isEmpty()){
						dateToShow2 = rest.getLastDateWorkout("vincentpont@gmail.com");
						listWorkout2 = rest.getDataWorkoutByEmailAndDate(dateToShow2,
								"vincentpont@gmail.com");
						// Get data for altitude
						rest.getDataMap("vincentpont@gmail.com", dateToShow2); 
					}
				
					List<Double> listAltitude2 = rest.getListAltitudes();
				%>  		

<br>
			    <span title="Date" style="font-size:20pt;" class="glyphicon glyphicon-calendar"></span>  &nbsp;
			    <span title="Date" style="font-size:14pt;" > <% out.print(dateToShow2.substring(0, 10));  %> à  <% out.print(dateToShow2.substring(11, 16));  %>  </span>
<br>	
<br>		

 <table class="table">
				<TR>
					<TD title="Temps" class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-time"></span> 
					  <span style="font-size:12pt; font-family:Verdana;"> &nbsp; <% out.print(listWorkout2.get(1)); %> </span>
					
					</TD> 
						
					<TD  title="Distance en mètre"  class="success">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort"></span> 
					 <span style="font-size:12pt; font-family:Verdana;"> &nbsp;  <% out.print(listWorkout2.get(2)); %>  </span>
								
					</TD>
						
					<TD title="Calories brûlées" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-fire"></span>	
					 <span style="font-size:12pt; font-family:Verdana;"> &nbsp; <% out.print(listWorkout2.get(3)); %> </span>
					
					</TD>
						
					<TD title="Vitesse moyenne en km/h" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-flash"></span>	
					 <span style="font-size:12pt; font-family:Verdana;">  <% out.print(listWorkout2.get(4)); %> </span>	
					
					</TD>
						
					<TD title="Altitude moyenne en mètre" class="success">
					<span style="font-size:14pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(rest.getAltitudeAverage(listAltitude2)); %> </span>	
					
					</TD>
				</TR>
 		    
		<TR>
					<TD title="Pulsation moyenne" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-heart"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(0.0);  %> </span>	
					
					</TD> 
					
					<TD  title="Total pas"  class="info">
					<span style="font-size:14pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:12pt; font-family:Verdana;"> &nbsp; <% out.print(0.0);  %> </span>	
								
					</TD>
					
					<TD title="Volume Tidal moyen en mL/inspiration" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<%  out.print(0.0);  %> </span>	
					
					</TD>
					
					<TD title="Respiration min moyenne" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<% out.print(0.0);   %> </span>	
					
					</TD>
					
					<TD title="Ventilation moyenne mL/min)" class="info">
					<span  style="font-size:14pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:12pt; font-family:Verdana;"> &nbsp;<%  out.print(0.0);  %>  </span>	
					
					</TD>
				</TR>
				</table>
						
<br>
<br>	

				
				    <h3 >Graphiques </h3>
					
<br>

						<div id="chart_div3" style="width: 400px; height: 300px;"> </div>
						
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
