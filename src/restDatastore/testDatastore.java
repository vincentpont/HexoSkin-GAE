package restDatastore;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class testDatastore {

	public static void main(String[] args) throws UnsupportedEncodingException,
			JSONException {

		RestInvokerDatastore rest = new RestInvokerDatastore();

		System.out.println("Data from entity newSeance :");
		System.out.println("");


	/*
		  List list = rest.getAllWorkoutByEmail("vincentpont@gmail.com");
		  //System.out.println(json.toString());
		  
		  Iterator<String> iterator = list.iterator(); while
		  (iterator.hasNext()) { System.out.println(iterator.next()); }
*/	 

		/*
		  List list = rest.getAllWorkoutDates("vincentpont@gmail.com");
		  
		  Iterator<String> iterator = list.iterator(); while
		  (iterator.hasNext()) { System.out.println(iterator.next()); }
		 */

		
		// Get listofDouble data map, Get average speed
		
		rest.getDataMap("vincentpont@gmail.com", "2014.07.06.00:28");

		Iterator<Double> iterator = rest.getListLatitudes().iterator(); 
		while(iterator.hasNext()) {
			System.out.println(iterator.next());
			}
	
		
		
		
	}

}
