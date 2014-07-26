package restHexoSkin;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;

import restDatastore.RestInvokerDatastore;



public class testHexoSkin {

	public static void main(String[] args) throws UnsupportedEncodingException {
				
		// Voir les séances réalisées
		String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";

		RestInvokerHexo rest = new RestInvokerHexo(s1);
		RestInvokerDatastore data = new RestInvokerDatastore();
		
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
		rest.deleteWorkoutById("36747");
		
		/*
		//  *** Pas total
		int pasTotal = 0 ;
		List<String> listDate = data.getAllWorkoutDates("vincentpont@gmail.com");
		
		 Iterator<String> iterator = listDate.iterator(); 
		 while (iterator.hasNext()) {
		 System.out.println(iterator.next()); 
		 }
		
		String restHexoDate = "";

		for (int i = 0; i < listDate.size(); i++) {

		 restHexoDate = listDate.get(i).substring(0, 10);
		 restHexoDate = restHexoDate.replace('.', '-');
		 System.out.println("date sub "+ restHexoDate);
		 List<String> listAllValue = rest.returnAllValueFromJson(restHexoDate, "52");
		 pasTotal += Integer.parseInt(listAllValue.get(listAllValue.size()-1)); // Get only last value for total

		}
			System.out.println("pasTotal " + pasTotal);
		*/	
	}

}
