package helper;

/**
 * Class that help to sort a list of String Dates
 * 
 * Created by Vincent Pont on 30.06.2014
 * Last modification 30.06.2014
 * Travail de bachelor 2014
 */

public class DatesComparator {

	private String dateString;

	public DatesComparator() {

	}

	public DatesComparator(String date) {
		this.dateString = date;
	}


	public String getDate() {
		return dateString;
	}

	public void setDate(String date) {
		this.dateString = date;
	}

	@Override
	public String toString() {
		return dateString;
	}

}
