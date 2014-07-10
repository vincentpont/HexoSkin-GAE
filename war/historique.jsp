<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>


<!-- Import restInvoker class -->
<%@ page import="restDatastore.RestInvokerDatastore"%>
<%@ page import="java.util.Iterator, java.util.List"%>

  <script src="https://apis.google.com/js/plusone.js" type="text/javascript"></script>
  <script src="https://apis.google.com/js/client:plusone.js" type="text/javascript"></script>
  
  <script src="bootstrap-3.1.1/js/sorttable.js"></script>
  
  <script type="text/javascript">
  /*
   * Déclenché lorsque l'utilisateur accepte la connexion, annule ou ferme la
   * boîte de dialogue d'autorisation.
   */
  function loginFinishedCallback(authResult) {
    if (authResult) {
      if (authResult['error'] == undefined){
        gapi.auth.setToken(authResult); // Stocker le jeton renvoyé.
        toggleElement('signin-button'); // Masquer le bouton de connexion lorsque l'ouverture de session réussit.
        getEmail();                     // Déclencher une requête pour obtenir l'adresse e-mail.
      } else {
        console.log('An error occurred');
      }
    } else {
      console.log('Empty authResult');  // Un problème s'est produit
    }
  }

  /*
   * Initie la requête au point de terminaison userinfo pour obtenir l'adresse
   * e-mail de l'utilisateur. Cette fonction dépend de gapi.auth.setToken, qui doit contenir un
   * jeton d'accès OAuth valide.
   *
   * Une fois la requête achevée, le rappel getEmailCallback est déclenché et reçoit
   * le résultat de la requête.
   */
  function getEmail(){
    // Charger les bibliothèques OAuth2 pour activer les méthodes userinfo.
    gapi.client.load('oauth2', 'v2', function() {
          var request = gapi.client.oauth2.userinfo.get();
          request.execute(getEmailCallback);
        });
  }

  function getEmailCallback(obj){
    var el = document.getElementById('email');
    var email = '';

    if (obj['email']) {
      email = 'Email: ' + obj['email'];
    }

    //console.log(obj);

    el.innerHTML = email;
    document.location.href ="historique.jsp?email="+e;
    toggleElement('email');
  }

  function toggleElement(id) {
    var el = document.getElementById(id);
    if (el.getAttribute('class') == 'hide') {
      el.setAttribute('class', 'show');
    } else {
      el.setAttribute('class', 'hide');
    }
  }

	function logout() {
		document.location.href = "https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://8-dot-logical-light-564.appspot.com/login.jsp";
	}

  
  </script>

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

<script type="text/javascript">
	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	google.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = google.visualization.arrayToDataTable([
				[ 'Year', 'Sales', 'Expenses' ], [ '2004', 1000, 400 ],
				[ '2005', 1170, 460 ], [ '2006', 660, 1120 ],
				[ '2007', 1030, 540 ] ]);

		var options = {
			title : 'Company Performance',
			hAxis : {
				title : 'Year',
				titleTextStyle : {
					color : 'red'
				}
			}
		};

		var chart = new google.visualization.ColumnChart(document
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
				[ 'Year', 'Sales', 'Expenses' ], [ '2004', 1000, 400 ],
				[ '2005', 1170, 460 ], [ '2006', 660, 1120 ],
				[ '2007', 1030, 540 ] ]);

		var options = {
			title : 'Company Performance'
		};

		var chart = new google.visualization.LineChart(document
				.getElementById('chart_div4'));
		chart.draw(data, options);
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
					<li><a href="compare.jsp">Comparer</a></li>
					<li class="active"><a href="historique.jsp">Historique</a></li>
				</ul>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">Historique des séances</h1>
<br>
<br>
				<div class="table-responsive">
					<table class="table table-hover sortable">
						<thead>
							<tr>
								<th title="Date"> <span style="font-size:18pt;" class="glyphicon glyphicon-calendar"> Date</span> </th>
								<th title="Temps"> <span style="font-size:18pt;" class="glyphicon glyphicon-time"> Time</span> </th>
								<th title="Distance en mètre"> <span style="font-size:18pt;" class="glyphicon glyphicon-sort"> Distance</span> </th>
								<th title="Calories brûlées"> <span style="font-size:18pt;" class="glyphicon glyphicon-fire"> Calories</span> </th>
								<th title="Vitesse moyenne en km/h"> <span style="font-size:18pt;" class="glyphicon glyphicon-flash"> Vitesse</span> </th>
								<th title="Détail"> <span style="font-size:18pt;" class="glyphicon"> Détail</span> </th>
							</tr>
						</thead>
						<tbody style="font-size:12pt; font-family:Verdana;">
							
							<%
								RestInvokerDatastore rest =  new RestInvokerDatastore();
							    List<String> list = rest.getAllWorkoutByEmail("vincentpont@gmail.com");
								
							    // To know number of workout for my table 
								int countRows = rest.countRows;
							    int rows = 0 ; // data
							    int dateCount = 0 ;
							    		
							    // Number of rows
							    for(int i = 0 ; i < countRows ; i++){	
							     Iterator<String> iterator = list.iterator(); %>
							     <TR>

								<% 
								// Write data in rows, each time 5 data per rows
								    for(int j = 0 ; j < 5 ;j++) { %>
							     	<% out.print("<TD>" + list.get(rows) + "</TD>");
							     	rows++;
									}
								// Insert button for details
									for(int l = 0 ; l < 1 ;l++) { %>
									<TD>
									<form action="index.jsp" method="get">
							     	<input type='hidden' name='date' value='<%= list.get(dateCount) %>'>  
									<button title="Détail" type="submit" class="btn btn-success">
									<span style="font-size:14pt;" class="glyphicon glyphicon-search"></span>
									</button>
									</form> 
							     	</TD>
							     <%	}
									dateCount += 5; //every 5 data we have the date
								%> 
							     </TR>
								<% } %>
								
						</tbody>
					</table>
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
	


	
	<span id="signin-button" style="display:none">
     <span class="g-signin" data-callback="loginFinishedCallback"
      data-approvalprompt="force"
      data-clientid="799362622292-cisd7bgllvoo1pckcsm38smvl9ec1m60.apps.googleusercontent.com"
      data-scope="https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email"
      data-height="short"
      data-cookiepolicy="single_host_origin"
      >
    </span>
  </span>

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
