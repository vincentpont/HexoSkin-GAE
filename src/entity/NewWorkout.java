package entity;

/**
 * Created by : Vincent Pont
 * Date : 28.06.2014
 * Class to map the data from the dataStore
 * Travail de bachelor 2014
 * 
 */

public class NewWorkout {

	private String time;
	private String distance;
	private String calories;
	private String speed ;
	private String meterMin;
	
	// Constructor
	public NewWorkout(String time, String distance, String calories,
			String speed, String meterMin) {

		this.time = time;
		this.distance = distance;
		this.calories = calories;
		this.speed = speed;
		this.meterMin = meterMin;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getDistance() {
		return distance;
	}

	public void setDistance(String distance) {
		this.distance = distance;
	}

	public String getCalories() {
		return calories;
	}

	public void setCalories(String calories) {
		this.calories = calories;
	}

	public String getSpeed() {
		return speed;
	}

	public void setSpeed(String speed) {
		this.speed = speed;
	}

	public String getMeterMin() {
		return meterMin;
	}

	public void setMeterMin(String meterMin) {
		this.meterMin = meterMin;
	}
	
	
	
	
	
}
