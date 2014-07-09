package junit_test;

import restHexoSkin.RestInvokerHexo;
import static org.junit.Assert.*;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;

/**
 * Class that test the methods under RestInvokerHexo 
 * This class test the requests REST and indirectly the authentication of the API HexoSkin.
 * 
 * @author Vincent Pont 
 * Date de création : 30.06.2014 
 * Dernière modification :  08.07.2014
 * 
 */
public class RestInvokerHexo_Test {


	private final String url = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354" ;
	private RestInvokerHexo restHexo = new RestInvokerHexo(url);

	/**
	 * Method that test if we return a json object with all the workouts done.
	 * 
	 */
	@Test
	public void testGetJSONObjectData() {
		
		// Test if we get something, so we are authenticated and our login accepted
		assertNotNull(restHexo.getJSONObjectData());
	}


	/**
	 * Method that test if we return a json object with in param the datatype (steps).
	 * This method test too indirectly returnLastValueFromJson() called in returnAllValueFromJson() method.
	 * 
	 */
	@Test
	public void testReturnAllValueFromJson() {
				
		// Test if we get something = authenticated and we can retrieve data from datatype 52 (steps)
		assertNotNull(restHexo.returnAllValueFromJson("2014-07-07", "52"));
		
		
	}
	
	/**
	 * Method that test if the id returned is corresponding with the date and is not null
	 * 
	 */
	@Test
	public void returnIdOfWorkout() {
		
		// Test if we return the correct id with the date
		String result = "36446";
		// Test if the ID returned is correct
		assertEquals(result,restHexo.returnIdOfWorkout("2014-07-07"));
		assertNotNull(result,restHexo.returnIdOfWorkout("2014-07-07"));
		
	}

	/**
	 * Method that test if the method works we the value entered and if the result is not null.
	 * With this test I found an error quickly and I resolve it to have better average.
	 * (count = 1 if we don't have data if not raise an error divide by zero).
	 */
	@Test
	public void testGetAverageFromList() {

		List<String> listString = new ArrayList<String>();
		listString.add("10.0");
		listString.add("20.0");
		String res = "15.00";

		// Test if the same result expected
		assertEquals(res, restHexo.getAverageFromList(listString));
		
		// Test if resul returned is not null
		assertNotNull(restHexo.getAverageFromList(listString));
	}

}
