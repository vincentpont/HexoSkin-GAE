package myapp;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import restDatastore.RestInvokerDatastore;
import restHexoSkin.RestInvokerHexo;

@SuppressWarnings("serial")
public class HexoSkin_GAEServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String dateStr = "2014.07.07.19:40";
		request.setAttribute("dateStr", dateStr);
		request.getSession().setAttribute("dateStr",dateStr);
		
		this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
		

		
		
	}
}
