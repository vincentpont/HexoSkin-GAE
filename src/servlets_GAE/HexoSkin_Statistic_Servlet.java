package servlets_GAE;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.labs.repackaged.org.json.JSONObject;

import restDatastore.RestInvokerDatastore;
import restHexoSkin.RestInvokerHexo;

@SuppressWarnings("serial")
public class HexoSkin_Statistic_Servlet extends HttpServlet {

	private final String email = "vincentpont@gmail.com";
	String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";
	private final RestInvokerDatastore data = new RestInvokerDatastore();
	private final RestInvokerHexo hexo = new RestInvokerHexo(s1);
	private int countWorkout = 0;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//  *** Count number of workout 

		List<String> listWorkouts = data.getAllWorkoutByEmail(email);
		countWorkout = listWorkouts.size() / 5; // divide by 5 because we have 5
												// data each workout

		request.setAttribute("countWorkout", countWorkout);


		
		//  *** Calories burned total
		
		Double totalCalorie = 0.0;
		int j = 3; // first value at position 3

		for (int i = 0; i < listWorkouts.size(); i++) {

			if (j <= listWorkouts.size()) {
				totalCalorie += Double.parseDouble(listWorkouts.get(j));
			}
			j += 5;
		}

		request.setAttribute("totalCalorie", totalCalorie);
		
		
		//  *** Distance total
		Double totalDistance = 0.0;
		int k = 2; // first value at position 3


		for (int i = 0; i < listWorkouts.size(); i++) {

			if (k <= listWorkouts.size()) {
				totalDistance += Double.parseDouble(listWorkouts.get(k));
			}
			k += 5;
		}

		request.setAttribute("totalDistance", totalDistance);
		
		//  *** Pas total
		int pasTotal = 0 ;
		List<String> listDate = data.getAllWorkoutDates(email);
		String restHexoDate = "";

		for (int i = 0; i < listDate.size(); i++) {

			 restHexoDate = listDate.get(i).substring(0, 10);
			 restHexoDate = restHexoDate.replace('.', '-');
			 List<String> listAllValue = hexo.returnAllValueFromJson(restHexoDate, "52");
			 pasTotal += Integer.parseInt(listAllValue.get(listAllValue.size()-1)); // Get only last value for total

			}

		request.setAttribute("pasTotal", pasTotal);
		
		
		request.getRequestDispatcher("statistic.jsp").forward(request, response);

	}
}
