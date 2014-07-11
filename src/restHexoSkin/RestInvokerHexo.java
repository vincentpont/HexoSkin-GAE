package restHexoSkin;

import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;



/**
 * Author : Pont Vincent Date : 09.06.2014 Last modification : 03.07.2014
 * Travail de bachelor
 */

public class RestInvokerHexo {

	private String url;
	private String idWorkout;
	private JSONObject json;
	private String userpass;
	private String basicAuth;
	private String urlIDAndDatatype;
	private final String username = "bruno.alves@hevs.ch";
	private final String password = "$hes-so2014!";

	// Constructor emtpy
	public RestInvokerHexo(){
		
	}
	
	public RestInvokerHexo(String url) {
		this.url = url;
		userpass = username + ":" + password;
		basicAuth = "Basic "
				+ new String(new Base64().encode(userpass.getBytes()));
		getJSONObjectData();

	}
	

	// Get data in JSON
	public JSONObject getJSONObjectData() {

		try {

			URL url = new URL(this.url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");
			conn.setRequestProperty("Authorization", basicAuth);


			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed, HTTP error code : "
						+ conn.getResponseCode() + " "
						+ conn.getResponseMessage());
			}

			BufferedReader br = new BufferedReader(new InputStreamReader(
					(conn.getInputStream())));

			String jsonText = readAll(br);

			try {
				json = new JSONObject(jsonText);
			} catch (JSONException e) {
				e.printStackTrace();
			}

			// Disconnect
			conn.disconnect();

		} catch (IOException e) {

			e.printStackTrace();

		}
		return json;

	}

	/**
	 * Method that return the json from a jsonArray
	 * 
	 * @return JSONArray
	 */
	public JSONArray getJSONArrayData() {

		JSONArray jsonArray = null;

		try {

			URL url = new URL(this.url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");
			conn.setRequestProperty("Authorization", basicAuth);

			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed, HTTP error code : "
						+ conn.getResponseCode() + " "
						+ conn.getResponseMessage());
			}

			BufferedReader br = new BufferedReader(new InputStreamReader(
					(conn.getInputStream())));

			String jsonText = readAll(br);

			try {
				jsonArray = new JSONArray(jsonText);

			} catch (JSONException e) {

				e.printStackTrace();
			}

			// Disconnect
			conn.disconnect();

		} catch (IOException e) {

			e.printStackTrace();

		}
		return jsonArray;

	}

	/**
	 * Method that return the id of the Workout passing a date in param
	 * 
	 * @param  String date
	 * @return String id We take only the 10 characters beacause hexoskin don't
	 *        use the same format (am/pm)
	 */
	public String returnIdOfWorkout(String date) {

		try {

			// Decompose the jsonObject jsonArray in a list
			JSONArray jsonMainArr = json.getJSONArray("objects");
			for (int i = 0; i < jsonMainArr.length(); i++) {
				JSONObject childJSONObject = jsonMainArr.getJSONObject(i);
				// Check the date between android and hexoskin
				if (childJSONObject.getString("start_date").substring(0, 10)
						.equals(date)) {
					idWorkout = childJSONObject.getString("id");
				}

			}

		} catch (JSONException e) {
			e.printStackTrace();
		}

		return idWorkout;
	}

	/**
	 * Method that return a list of all values in a specified datatype
	 * 
	 * @param date
	 * @param dataType
	 * @return List of String containing all values
	 */
	public List<String> returnAllValueFromJson(String date, String dataType) {

		String idWorkout = returnIdOfWorkout(date);
		this.urlIDAndDatatype = "https://api.hexoskin.com/api/v1/data/?datatype="
				+ dataType + "&record=" + idWorkout;

		this.url = urlIDAndDatatype;
		JSONArray jsonArray = new JSONArray();
		jsonArray = getJSONArrayData();
		String jsonString = "";

		try {
			JSONObject jsonObject = jsonArray.getJSONObject(0);
			jsonString = jsonObject.getString("data");

		} catch (JSONException e) {
			e.printStackTrace();
		}

		List<String> list = new ArrayList<String>();

		String values = "";
		int j = 0;

		for (int i = 0; i < jsonString.length(); i++) {

			// First position, if we find the first ','
			if (jsonString.charAt(i) == ',' && jsonString.charAt(i - 13) == '[') {
				j = i + 1;
			}

			// Second position,Position near the values
			if (jsonString.charAt(i) == ',' && jsonString.charAt(i - 1) == ']') {
				values = jsonString.substring(j, i - 1);
				list.add(values);
			}

		}

		// Add last value
		list.add(returnLastValueFromJson(jsonString));

		return list;

	}
	
	/**
	 * Method to convert ml to l and with two decimals
	 * 
	 * @param String average from a list
	 * @return String convert
	 */
	public String changeMltoLwith2Decimals(String average){

		
		DecimalFormat df = new DecimalFormat("####0.00");
		double valueDouble = Double.parseDouble(average);
		valueDouble = valueDouble/1000 ;
		
		return df.format(valueDouble) ;
		
	}

	/**
	 * Method that with a string return the last value
	 * 
	 * @param String jsonString
	 * @return String values
	 */
	public String returnLastValueFromJson(String jsonString) {

		String values = "";
		int j = 0;
		Boolean find = false;

		for (int i = jsonString.length() - 1; i > 1; i--) {

			// -3 because of the 3 characters at the end
			j = jsonString.length() - 3;

			if (find == false) {
				if (jsonString.charAt(i) == ',') {
					values = jsonString.substring(i + 1, j); // +1 Because of
																// the ','
					find = true;
				}
			}

		}
		return values;

	}

	/**
	 * Method to get the average of a list of datatype
	 * 
	 * @param list of Strings
	 * @return String average of this list into two decimals
	 */
	public String getAverageFromList(List<String> list){
		
		Double average = 0.0 ;
		int count = 0;
		DecimalFormat df = new DecimalFormat("####0.00");
		
		Iterator<String> iterator = list.iterator(); 
		 
		while (iterator.hasNext()) {
		 average += Double.parseDouble(iterator.next());
		 count++;
		}

		// Si on a pas de données pour pas qu'on divise par 0
		if(count == 0 ){
			count = 1; 
		}
			
		return df.format(average / count);
	}
	
	/**
	 * Method to delete a workout by passing an ID
	 * 
	 * 
	 */
	public void deleteWorkoutById(String id){
		
		// Delete une séance
		try {

			URL url = new URL("https://api.hexoskin.com/api/v1/record/"+id+"/");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("DELETE");
			conn.setRequestProperty("Accept", "application/json");
			conn.setRequestProperty("Authorization", basicAuth);


			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed, HTTP error code : "
						+ conn.getResponseCode() + " "
						+ conn.getResponseMessage());
			}

			// Disconnect
			conn.disconnect();

		} catch (IOException e) {

			e.printStackTrace();

		}
		
	}

	/**
	 * Method to read all from reader
	 * 
	 * @Param : Reader
	 * 
	 * @Return : String
	 */
	private String readAll(Reader rd) throws IOException {
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = rd.read()) != -1) {
			sb.append((char) cp);
		}
		return sb.toString();
	}

}
