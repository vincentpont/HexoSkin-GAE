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
		 * JSONObject json =
		 * rest.getDataWorkoutByEmailAndDate("2014.06.25.17:39"
		 * ,"vincentpont@gmail.com"); System.out.println(json.toString());
		 */

		
		  List list = rest.getAllWorkoutByEmail("vincentpont@gmail.com");
		  //System.out.println(json.toString());
		  
		  Iterator<String> iterator = list.iterator(); while
		  (iterator.hasNext()) { System.out.println(iterator.next()); }
		 

		/*
		  List list = rest.getAllWorkoutDates("vincentpont@gmail.com");
		  
		  Iterator<String> iterator = list.iterator(); while
		  (iterator.hasNext()) { System.out.println(iterator.next()); }
		 */

		
		/*
		List list = rest.getDataMap("vincentpont@gmail.com");

		String StringLatitudes;
		String StringLongitudes;
		String StringVitesses;
		String StringAltitudes;

		StringLatitudes = rest.getStringLatitudes();
		StringLongitudes = rest.getStringLongitudes();
		StringVitesses = rest.getStringVitesses();
		StringAltitudes = rest.getStringAltitudes();

		System.out.println(StringLatitudes);
		System.out.println(StringLongitudes);
		System.out.println(StringVitesses);
		System.out.println(StringAltitudes);
		*/
	}

}
