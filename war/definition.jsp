<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>



<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Vincent Pont">
<link rel="shortcut icon" href="img/icoFav.png">


<title>HexoSkin-Definition</title>

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
					<li><a href="training">Entra�nement</a></li>
					<li><a href="compare">Comparer</a></li>
					<li><a href="historique.jsp">Historique</a></li>
				</ul>
				
				<ul class="nav nav-sidebar">
					<li><a href="statistic">Statistique</a></li>
				    <li><a href="definition.jsp">D�finitions</a></li>
		        </ul>
			</div>



			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"
				style="font-size: 12pt;">
				<h1 class="page-header">D�finitions 
				<span style="font-size: 25pt;"
						class="glyphicon glyphicon-search"></span>
				</h1>

				<h4>Quelques d�finitions pour le sportif amateur</h4>
<br>


				<table class="table">
	<thead>
					<TR style="font-size: 14pt;">
						<TH>Donn�e</TH>
						<TH>D�finition</TH>
						<TH>Rapport (repos/effort)</TH>
					</TR>
 </thead>
 <tbody>
					<TR style="font-size: 11pt;">

						<TD><span class="glyphicon glyphicon-stats"></span> <b>Volume
								ti.</b></TD>

						<TD>est le volume pulmonaire normale repr�sentant le volume
							de l'air d�plac� entre l'inhalation et l'exhalation.</TD>

						<TD>0.5 litre au repos et 3.0 litre pendant effort.</TD>
					</TR>
					<TR style="font-size: 11pt;">
						<TD><span class="glyphicon glyphicon-transfer"></span> <b>Fr�quence
								respi.</b></TD>

						<TD>est le nombre de cycles respiratoire (inspiration et
							expiration) par minute.</TD>

						<TD>12-20 respi/min et 30 respi/min pendant effort.</TD>
					</TR>
					<TR style="font-size: 11pt;">
						<TD><span class="glyphicon glyphicon-sort-by-attributes"></span>
							<b>Ventilation</b></TD>

						<TD>est le renouvellement de l'air contenu dans les poumons
							par l'action des muscles respiratoires (diaphragme).</TD>

						<TD>6.0 litre/min au repos et 90 litre/min pendant effort</TD>

					</TR>
					</tbody>
				</table>


			</div>

		</div>

		<div style="bottom: 0; position: absolute; width: 100%;" class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<hr>
				<footer style="font-size: 9pt;">					
						<b>Copyright �2014 HexoSkin Travail de bachelor. Tous droits
							r�serv�s.</b> 
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
