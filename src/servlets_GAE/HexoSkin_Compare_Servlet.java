package servlets_GAE;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import restDatastore.RestInvokerDatastore;
import restHexoSkin.RestInvokerHexo;

/**
 * Author : Pont Vincent 
 * Class : Servlet to pass variables to compare page
 * Last modification : 25.07.2014
 * Travail de bachelor 2014
 */

@SuppressWarnings("serial")
public class HexoSkin_Compare_Servlet extends HttpServlet {
	
	
	private final String email = "vincentpont@gmail.com";
	private RestInvokerDatastore restDatastore = new RestInvokerDatastore();
	private final String url = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354" ;
	private RestInvokerHexo restHexo = new RestInvokerHexo(url);
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
			
		   /*
			* Last date workout
			*/
		
			// Call method to get last date of workouts and pass it to the page

			String lastDateWorkout = restDatastore.getLastDateWorkout(email);
			
			// If nothing in param we give the last date
			if(request.getParameter("date1") != null){
				String dateParam = request.getParameter("date");
				request.setAttribute("lastDateWorkout", dateParam);
			}
			else{
				// Set attribute and send it to index.jsp
				request.setAttribute("lastDateWorkout", lastDateWorkout);
			}
			
			// If nothing in param we give the last date
			if(request.getParameter("date2") != null){
				String dateParam = request.getParameter("date");
				request.setAttribute("lastDateWorkout", dateParam);
			}
			else{
				// Set attribute and send it to index.jsp
				request.setAttribute("lastDateWorkout", lastDateWorkout);
			}
			
			// Set attribute and send it to index.jsp
			request.setAttribute("lastDateWorkout", lastDateWorkout);
			request.getRequestDispatcher("compare.jsp").forward(request, response);
		
			
	}

}
