package restHexoSkin;



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
		rest.deleteWorkoutById("36642");
			
	}

}
