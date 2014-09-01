package servlets_GAE;

import helper.withComparator;

import java.io.IOException;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import restDatastore.RestInvokerDatastore;
import restHexoSkin.RestInvokerHexo;

/**
 * Author : Pont Vincent 
 * Class : Servlet to pass variables to training page
 * Last modification : 25.07.2014
 * Travail de bachelor 2014
 */

@SuppressWarnings("serial")
public class HexoSkin_Training_Servlet extends HttpServlet {
	
	private final String email = "vincentpont@gmail.com";
	private RestInvokerDatastore restDatastore = new RestInvokerDatastore();
	private final String url = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354" ;
	private RestInvokerHexo restHexo = new RestInvokerHexo(url);
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
	
		
		// Call method to get last date of workouts and pass it to the page
		String lastDateWorkout = restDatastore.getLastDateWorkout(email);


		// Set attribute and send it to index.jsp
		request.setAttribute("lastDateWorkout", lastDateWorkout);
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
	}
}
