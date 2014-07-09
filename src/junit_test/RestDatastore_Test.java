package junit_test;

import static org.junit.Assert.*;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import restDatastore.RestInvokerDatastore;

/**
 * Class that test the methods under RestInvokerDatastore This class test the
 * requests REST and indirectly the authentication of the Datastore.
 * 
 * @author Vincent Pont Date de création : 30.06.2014 Dernière modification :
 *         08.07.2014
 * 
 */
public class RestDatastore_Test {

	private String date = "2014.07.07.19:40";
	private String email = "vincentpont@gmail.com";
	private RestInvokerDatastore restDatastore = new RestInvokerDatastore();

	/**
	 * 
	 * Method that get one workout by email and date and we check if in the
	 * object we have the date that say we have the entire workout in it.
	 * 
	 * @throws UnsupportedEncodingException
	 */
	@Test
	public void testGetDataWorkoutByEmailAndDate()
			throws UnsupportedEncodingException {

		// Test if we get the workout
		// but not effective beacause even we don't have a resul Google send
		// some useless information in the json
		assertNotNull(restDatastore.getDataWorkoutByEmailAndDate(date, email));

		// So we test that in the list created with the json at the index 0 we
		// have the date so we have the workout
		List<String> list = restDatastore.getDataWorkoutByEmailAndDate(date,
				email);
		if (list.get(0).equals(date)) {
			// Ok
		} else {
			fail();
		}
	}

	/**
	 * Method that test if we get the values from the map Latitude, longitude,
	 * altitude, speed
	 * 
	 * @throws UnsupportedEncodingException
	 */
	@Test
	public void testGetDataMap() throws UnsupportedEncodingException {

		restDatastore.getDataMap(email, date);

		// We check if the list are not null
		assertNotNull(restDatastore.getListAltitudes());
		assertNotNull(restDatastore.getListLatitudes());
		assertNotNull(restDatastore.getListLongitudes());
		assertNotNull(restDatastore.getListVitesses());

	}

	/**
	 * Method that test if we get all the dates from workouts
	 * 
	 * @throws UnsupportedEncodingException
	 */
	@Test
	public void testGetAllWorkoutDates() throws UnsupportedEncodingException {

		List<String> list = restDatastore.getAllWorkoutDates(email);

		// We check if the list is not null so contains the dates
		assertNotNull(list);
	}

	@Test
	public void testConvertListToStringBuffer() {

		List<String> list = new ArrayList<String>();
		list.add("45.24132423");
		list.add("48.24332426");
		list.add("49.24332323");

		restDatastore.convertListToStringBuffer(list);
	}

	/**
	 * Method that test if when we substring the String list is correctly
	 * transformed into a list of Double without non desired characters
	 * 
	 */
	@Test
	public void testSubstringLists() {

		String listSpeed = "[0,0,6.76,8.86,7.63,9.54,8.56,8.05,8.2,7.9,7.97,7.58,6.14,6.44,6.84,6.7,5.49,7.28,6.26,6.64,6.48,6.95,6.06,4.33,5.98,0]";
		List<Double> listDoubleSpeed = new ArrayList<Double>();
		listDoubleSpeed = restDatastore.substringLists(listSpeed);

		// Test if the list is in Double after calling the methods
		try {
			Double d = (Double) listDoubleSpeed.get(0);
		} catch (ClassCastException e) {
			fail();
			System.out.println("Was not a List<Integer>");
		}

		// Test if we have data in it
		assertNotNull(listDoubleSpeed);

	}

	@Test
	public void testGetAltitudeAverage() {

		List<Double> listDouble = new ArrayList<Double>();
		listDouble.add(5.00);
		listDouble.add(20.00);
		String res = "12.50";

		// Test if the same result expected
		assertEquals(res, restDatastore.getAltitudeAverage(listDouble));

		// Test if resul returned is not null
		assertNotNull(restDatastore.getAltitudeAverage(listDouble));

	}

}
