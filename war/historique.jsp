<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>


<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="java.util.Iterator, java.util.List"%>

<!-- Google account get account -->
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

<!-- Google account test token -->
<script type="text/javascript">
	function signinCallback(authResult) {
		if (authResult['access_token']) {
			// Logged
		} else if (authResult['error']) {
			document.getElementById('signinButton').setAttribute('style',
					'display: none');
			window.location = "login.jsp";
		}
	}

	/**
	 * Method to logout the user
	 */
	function logout() {
		document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://9-dot-logical-light-564.appspot.com/login.jsp";
	}
</script>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Vincent Pont">
<link rel="shortcut icon" href="img/icoFav.png">


<title>HexoSkin-Historique</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-3.1.1/dist/css/bootstrap.min.css">
<link href="bootstrap-3.1.1/dist/css/dashboard.css" rel="stylesheet">

<!-- To sort the table -->
<script src="bootstrap-3.1.1/js/sorttable.js"></script>

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
				<ul class="nav nav-sidebar">
					<li><a href="dashboard">Dashboard</a></li>
					<li><a href="compare">Comparer</a></li>
					<li class="active"><a href="historique.jsp">Historique</a></li>
					<li><a href="definition.jsp">Définitions</a></li>
				</ul>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">Historique des séances</h1>
				<br> <br>
				<div class="table-responsive">
					<table class="table table-hover sortable">
						<thead>
							<tr>
								<th title="Date"><span style="font-size: 18pt;"
									class="glyphicon glyphicon-calendar"> Date</span></th>
								<th title="Temps"><span style="font-size: 18pt;"
									class="glyphicon glyphicon-time"> Time</span></th>
								<th title="Distance en mètre"><span
									style="font-size: 18pt;" class="glyphicon glyphicon-sort">
										Distance</span></th>
								<th title="Calories brûlées"><span style="font-size: 18pt;"
									class="glyphicon glyphicon-fire"> Calories</span></th>
								<th title="Vitesse moyenne en km/h"><span
									style="font-size: 18pt;" class="glyphicon glyphicon-flash">
										Vitesse</span></th>
								<th title="Détail"><span style="font-size: 18pt;"
									class="glyphicon"> Détail</span></th>
							</tr>
						</thead>
						<tbody style="font-size: 12pt; font-family: Verdana;">

							<%
								RestInvokerDatastore rest = new RestInvokerDatastore();
								List<String> list = rest
										.getAllWorkoutByEmail("vincentpont@gmail.com");

								// To know number of workout for my table 
								int countRows = rest.countRows;
								int rows = 0; // data
								int dateCount = 0;

								// Number of rows
								for (int i = 0; i < countRows; i++) {
									Iterator<String> iterator = list.iterator();
							%>
							<TR>

								<%
									// Write data in rows, each time 5 data per rows
										for (int j = 0; j < 5; j++) {
								%>
								<%
									out.print("<TD>" + list.get(rows) + "</TD>");
											rows++;
										}
										// Insert button for details
										for (int l = 0; l < 1; l++) {
								%>
								<TD>
									<form action="index.jsp" method="get">
										<input type='hidden' name='date'
											value='<%=list.get(dateCount)%>'>
										<button title="Détail" type="submit" class="btn btn-success">
											<span style="font-size: 14pt;"
												class="glyphicon glyphicon-search"></span>
										</button>
									</form>
								</TD>
								<%
									}
										dateCount += 5; //every 5 data we have the date
								%>
							</TR>
							<%
								}
							%>

						</tbody>
					</table>
				</div>
			</div>

		</div>

		<div style="bottom: 0; position: absolute; width: 100%;" class="row">
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


	<!-- Bootstrap core JavaScript -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="bootstrap-3.1.1/dist/js/bootstrap.min.js"></script>
	<script src="bootstrap-3.1.1/docs/assets/js/docs.min.js"></script>


</body>
</html>
