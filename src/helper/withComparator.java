package helper;

import java.util.Comparator;

/**
 * Class that sort a list of dates returned by datastore 
 * Created by Vincent Pont
 * 30.06.2014
 * Last modification 30.06.2014
 * Travail de bachelor 2014
 */


public class withComparator implements Comparator<Object> {

	@Override
	public int compare(Object o1, Object o2) {

		
		DatesComparator p1 = (DatesComparator)  o1 ;
		DatesComparator p2 = (DatesComparator)  o2 ;
			int r ;
			
			if((r = p1.getDate().compareTo(p2.getDate()))== 0)
				if((r = p1.getDate().compareTo(p2.getDate()))== 0)
					return 0 ;
				
		return r;
	}
	
}
