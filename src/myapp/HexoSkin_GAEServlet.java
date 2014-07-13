package myapp;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import restDatastore.RestInvokerDatastore;
import restHexoSkin.RestInvokerHexo;

public class HexoSkin_GAEServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
	
		
		String dateStr = "hello";
		
		request.setAttribute("dateStr", dateStr);
		//getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
		
			
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
	
	}
}
