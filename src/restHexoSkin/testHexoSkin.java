package restHexoSkin;

import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;



public class testHexoSkin {

	public static void main(String[] args) {
				
		// Voir les séances réalisées
		String s1 = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354";

		RestInvokerHexo rest = new RestInvokerHexo(s1);
		
		 	
		 List list = rest.returnAllValueFromJson("2014-07-07", "52");
		 
		 Iterator<String> iterator = list.iterator(); 
		 while (iterator.hasNext()) {
		 System.out.println(iterator.next()); 
		 }
		 
		 /*
		 String average = rest.getAverageFromList(list);
		 System.out.println("Moyenne pulsation " + average);
		 
		
		 System.out.println(rest.returnIdOfWorkout("2014.06.08"));
		 */

		 
	}

}
