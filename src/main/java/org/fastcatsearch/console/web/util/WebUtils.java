package org.fastcatsearch.console.web.util;

public class WebUtils {
	
	public static String getMaskedPassword(String password){
		if(password == null){
			return "";
		}
		String masked = "";
		for (int i = 0; i < password.length(); i++) {
			//맨앞 2자리와 끝 1자리만 보여준다.
			if(i < 2 || i == password.length() - 1){
				masked += password.charAt(i);
			}else{
				masked += "*";
			}
		}
		return masked;
		
	}
}
