package restHexoSkin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;



public class testHexoSkin {

	public static void main(String[] args) {
				
		// Voir les séances réalisées
		String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";

		RestInvokerHexo rest = new RestInvokerHexo(s1);
		
		 	/*
		 List<String> list = rest.returnAllValueFromJson("2014-07-07", "52");
		 
		 Iterator<String> iterator = list.iterator(); 
		 while (iterator.hasNext()) {
		 System.out.println(iterator.next()); 
		 }
		 
		 
		 String average = rest.getAverageFromList(list);
		 System.out.println("Moyenne :" + average);
		 
		
		 System.out.println(rest.returnIdOfWorkout("2014-07-07"));
		 */
		
		// Delete
		
			
	}

}
