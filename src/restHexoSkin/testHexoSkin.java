package restHexoSkin;

import java.io.UnsupportedEncodingException;

public class testHexoSkin {


	public static void main(String[] args) throws UnsupportedEncodingException {
			

		// To test methods
		// ...
		
		 String url = "https://api.hexoskin.com/api/v1/record/?startTimestamp__gte=1404205354" ;
		 RestInvokerHexo restHexo = new RestInvokerHexo(url);
		
		 restHexo.deleteWorkoutById("40827");

	}

}
