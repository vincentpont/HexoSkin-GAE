<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
				.getElementById('chart_div4'));
		chart.draw(data, options);
	}
</script>


<script>
function logout() {
	document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://8-dot-logical-light-564.appspot.com/login.jsp";
}
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
				<div class="row">
					<h1 class="page-header">Comparatif séances
				    <span  style="font-size:30pt;" class="glyphicon glyphicon-eye-open"></span>
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
																
				    <select name="listDates1" class="form-control" style="font-size:14pt;">
					    <%while (iterator1.hasNext()){%>
					        <option><%out.print(iterator1.next());%></option>
					    <%}%>
					</select>
<br>
<br>		
 <br>				    
				    
				<div class="row">
				<div  title="Temps" class="col-md-2">
					  <span  style="font-size:18pt;" class="glyphicon glyphicon-time"></span> 
					  <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(0.0); %> </span>
					 </div>

					<div title="Distance" class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-sort"></span> 
					 <span style="font-size:14pt; font-family:Verdana;"> &nbsp;  <% out.print(0.0); %>  </span>
					
					</div>

					<div title="Calories brûlées" class="col-md-2">
					<span style="font-size:18pt;" class="glyphicon glyphicon-fire"></span>	
					 <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(0.0); %> </span>
					</div>

					<div title="Vitesse moyenne" class="col-md-2">
					<span style="font-size:18pt;" class="glyphicon glyphicon-flash"></span>	
					 <span style="font-size:14pt; font-family:Verdana;">  <% out.print(0.0); %> </span>	
					</div>
					
				    <div title="Mètre/min moyen" class="col-md-2">
					<span style="font-size:18pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(0.0); %> </span>	
					</div>

       </div> 
 <br>      
       				<div class="row" >
				
					<div title="Pulsation" class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-heart"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(0.0);  %> </span>	
					</div>

					<div title="Steps" class="col-md-2">
					<span style="font-size:18pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(0.0);  %> </span>	
					</div>
					
					<div title="Cadence Steps/min" class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<%  out.print(0.0);  %> </span>	
					</div>
					
					<div title="Breathing Rate" class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(0.0);   %> </span>	
					</div>
					
				    <div title="Minute Ventilation " class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<%  out.print(0.0);  %>  </span>	
					</div>
					

				</div>
<br>
<br>
				    <h3>Graphiques </h3>
<br>
						<div id="chart_div1" style="width: 500px; height: 400px;"></div>
						<div id="chart_div2" style="width: 500px; height: 400px;"></div>
					</div>
					<div class="col-md-6">
					
					
					<% // Récupère une liste de ttes les dates
					List listDates2 = rest.getAllDatesWorkoutSorted("vincentpont@gmail.com");
					Iterator iterator2 = listDates2.iterator();
					%>
				
					
					<select name="listDates2" class="form-control" style="font-size:14pt;">
					    <%while (iterator2.hasNext()){%>
					        <option><%out.print(iterator2.next());%></option>
					    <%}%>
					</select>
<br>
<br>							
<br>				    
				    
				<div class="row">
				<div  title="Temps" class="col-md-2">
					  <span style="font-size:18pt;" class="glyphicon glyphicon-time"></span> 
					  <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(0.0); %> </span>
					 </div>

					<div title="Distance" class="col-md-2">
					 <span style="font-size:18pt;" class="glyphicon glyphicon-sort"></span> 
					 <span style="font-size:14pt; font-family:Verdana;"> &nbsp;  <% out.print(0.0); %>  </span>
					
					</div>

					<div title="Calories brûlées" class="col-md-2">
					 <span style="font-size:18pt;" class="glyphicon glyphicon-fire"></span>	
					 <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(0.0); %> </span>
					</div>

					<div title="Vitesse moyenne" class="col-md-2">
					 <span style="font-size:18pt;" class="glyphicon glyphicon-flash"></span>	
					 <span style="font-size:14pt; font-family:Verdana;">  <% out.print(0.0); %> </span>	
					</div>
					
				    <div title="Mètre/min moyen" class="col-md-2">
					<span style="font-size:18pt;" class="glyphicon glyphicon-signal"></span>	
				    <span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(0.0); %> </span>	
					</div>

       </div> 
 <br>      
       				<div class="row" >
				
					<div title="Pulsation" class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-heart"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(0.0);  %> </span>	
					</div>

					<div title="Steps" class="col-md-2">
					<span style="font-size:18pt;" class="glyphicon glyphicon-road"></span>						
				    <span style="font-size:14pt; font-family:Verdana;"> &nbsp; <% out.print(0.0);  %> </span>	
					</div>
					
					<div title="Cadence Steps/min" class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-stats"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<%  out.print(0.0);  %> </span>	
					</div>
					
					<div title="Breathing Rate" class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-transfer"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<% out.print(0.0);   %> </span>	
					</div>
					
				    <div title="Minute Ventilation " class="col-md-2">
					<span  style="font-size:18pt;" class="glyphicon glyphicon-sort-by-attributes"></span>						
					<span style="font-size:14pt; font-family:Verdana;"> &nbsp;<%  out.print(0.0);  %>  </span>	
					</div>
				</div>
<br>
<br>	
				
				    <h3>Graphiques </h3>
					
<br>

					<div id="chart_div3" style="width: 500px; height: 400px;"></div>
					<div id="chart_div4" style="width: 500px; height: 400px;"></div>
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
