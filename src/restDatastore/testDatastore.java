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
/*
		System.out.println("Data from entity newSeance :");
		System.out.println("");
		
		List list = rest.getUser("vincentpont@gmail.com");

		  Iterator<String> iterator = list.iterator(); 
		  while(iterator.hasNext()) {
			  System.out.println(iterator.next()); 
			  }
		  
		  */
		  rest.updateUser("vincentpont@gmail.com" , "homme", "24", "90");

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
		 
		  System.out.println(rest.getLastDateWorkout("vincentpont@gmail.com"));
*/
		
		// Get listofDouble data map, Get average speed
		
		/*
		String date = rest.getLastDateWorkout("vincentpont@gmail.com");
		System.out.println(date);
		rest.getDataMap("vincentpont@gmail.com", "2014.07.07.19:40");
		Iterator<Double> iterator = rest.getListLatitudes().iterator(); 
		while(iterator.hasNext()) {
			System.out.println(iterator.next());
			}
	
		List list = rest.getDataWorkoutByEmailAndDate("2014.07.07.19:40", "vincentpont@gmail.com");
		
		Iterator<String> iterator2 = list.iterator(); 
		while(iterator2.hasNext()) {
			System.out.println(iterator2.next());
			}
		
		*/
		

	}

}
