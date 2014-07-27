package servlets_GAE;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import restDatastore.RestInvokerDatastore;


/**
 * Author : Pont Vincent 
 * Class : Servlet to pass variables to profile page
 * Last modification : 25.07.2014
 * Travail de bachelor 2014
 */

@SuppressWarnings("serial")
public class HexoSkin_Profile_Servlet extends HttpServlet {

	private final String email = "vincentpont@gmail.com";
	private RestInvokerDatastore restDatastore = new RestInvokerDatastore();
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
	   /*
		* Call user by email 
		*/
		
		List<String> listUser = restDatastore.getUser(email);
		request.setAttribute("listUser", listUser);
		request.getRequestDispatcher("profile.jsp").forward(request, response);
			
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
			// ALWAYS NULL
		
			if( request.getParameter("Sexe") != null && request.getParameter("Age") != null
					&&  request.getParameter("Weight") !=null){
			String sexe = (String) request.getParameter("Sexe");
			String age = (String) request.getParameter("Age");
			String weight = (String) request.getParameter("Weight");
			
			restDatastore.updateUser(email, sexe, age, weight);
			}
			
			// redirection
			doGet(request,response);

	}
	
	
	
}
