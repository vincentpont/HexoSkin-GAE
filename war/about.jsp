<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>



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
			document.getElementById('signinButton').setAttribute('style',
					'display: none');
			window.location = "login.jsp";
		}
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
					<li class="active"><a href="index.jsp">Dashboard</a></li>
					<li><a href="compare.jsp">Comparer</a></li>
					<li><a href="map.jsp">Carte</a></li>
					<li><a href="historique.jsp">Historiques</a></li>
				</ul>
			</div>



			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main" style="font-size:12pt;" >
				<h1 class="page-header">A propos</h1>

				<p> Mapper l'effort grâce à HexoSkin.</p>
				<p> Travail de bachelor 2014  </p>
				<p> Étudiant : Vincent Point </p>
				<p> Professeur responsable : Monsieur Michael Schumacher</p>
				<p> HES-SO Valais </p>


				<br>
				<div class="row"></div>
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
