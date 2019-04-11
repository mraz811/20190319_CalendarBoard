package happy.com.comm;

import java.util.List;

import happy.com.dto.CalDto;

public class Util {

	// 한자리의 숫자를 두자리의 문자로 변경 3월(3->03)
	public static String isTwo(String month) {
		return month.length()<2? "0"+month : month; 
	}
	
	// 달력의 토요일 일요일 평일의 글색깔 변경
	public static String fontColor(int date, int dayofWeek) {
		String color = "";
		int dayCal = (dayofWeek-1+date)%7; // 해당 요일
		
		if(dayCal==0) {
			color = "forestgreen"; // 토요일
		} else if(dayCal==1) {
			color = "red";
		} else {
			color="black";
		}
		return color;
	}
	
	// clist는 년월의 모든 일정 게시글을 가지고 있다.
	// 달력을 다 찍으면 안되고, p태그로 아예 만들어서 보내줄 예정 (화면에서 하면 복잡하니까)
	public static String getCalView(int i, List<CalDto> clist) {
		//mdate라는 애가 yyyyMMddHHMI 형식으로 되어있다. 우리가 받아온 int i 날자값은 숫자로 되어있다.
		String d = isTwo(String.valueOf(i)); // 2자리로 변경
		String res = ""; // 결과값 반환되는 그릇
		
		// json이나 xml로 가져올 때는 5년치 한번에 가져올 수 있지만, 지금은 서버가 다운될 수 있으니.. 달씩 끊어서 가져올거
		for(CalDto dto : clist) {
			if(dto.getmDate().substring(6, 8).equals(d)) { // yyyyMMddHHMI 에서 dd만 짤라옴
				// 일만 가지고 와서
				res += "<p>"+
				"<a href='./CalController.do?command=detail&seq="+dto.getSeq()+"'>"+
						((dto.getTitle().length()>6)? dto.getTitle().substring(0, 6)+"...": dto.getTitle())+
					"</a></p>";
				
			}
		}
		
		
		return res;
	}
	
}
