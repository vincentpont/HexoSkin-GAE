<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%@ page import="java.util.List;"%>



<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Vincent Pont">
<link rel="shortcut icon" href="img/icoFav.png">


<title>HexoSkin-Profil</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="bootstrap-3.1.1/dist/css/bootstrap.min.css">
<link href="bootstrap-3.1.1/dist/css/dashboard.css" rel="stylesheet">

<!-- Import login.js -->
<script src="js/login.js"></script>
<script src="js/profile.js"></script>

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


			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">
					Profil <span style="font-size: 25pt;"
						class="glyphicon glyphicon-user"></span>
				</h1>

				<div class="col-md-6">

					<br>


<%
	List listUser = (List) request.getAttribute("listUser");
%>

	<form method="post" action="profile" onSubmit="return checkform(this);">
		<div class="form-group">
			<label for="email">Email address</label> <input width="100px"
				type="email" disabled class="form-control" name="Email" id="email"
				value='<%=listUser.get(0)%>'>
		</div>
		<div class="form-group">
			<label for="sexe">Sexe</label> <input width="100px" type="text"
				class="form-control" name="Sexe" id="sexe" value='<%=listUser.get(1)%>'>
		</div>
		<div class="form-group">
			<label for="age">Age</label> <input width="100px" type="text"
				class="form-control" name="Age" id="age" value='<%=listUser.get(2)%>'>
		</div>
		<div class="form-group">
			<label for="poids">Poids</label> <input width="100px" type="text"
				class="form-control" name="Weight" id="poids" value='<%=listUser.get(3)%>'>
		</div>
		<button type='submit' class="btn btn-success" onClick="">
			<b> Sauvegarder </b>
		</button>
	</form>
				</div>


				<div class="col-md-6">

					<!-- 
					<div class="form-group">
						<label for="exampleInputFile">Ajouter une image</label> <input
							width="100px" type="file" id="exampleInputFile">
						<p class="help-block">Taille de 100*100 .</p>
					</div>
 -->
				</div>

			</div>

		</div>

		<div style="bottom: 0; position: absolute; width: 100%;" class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<hr>
				<footer style="font-size: 9pt;">
					<b>Copyright ©2014 HexoSkin Travail de bachelor. Tous droits
						réservés.</b> <img title="Logo hes-so Valais" align="right"
						height="30px" src="img/hes_logo.jpg" />
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
