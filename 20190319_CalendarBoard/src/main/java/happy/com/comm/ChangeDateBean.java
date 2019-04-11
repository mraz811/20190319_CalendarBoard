package happy.com.comm;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ChangeDateBean {
	// dto형태이지만 기능을 가지고 있는 것이 bean.
	
	private String toDate;

	// set property와 get property를 반대로 적어도 상관은 없습니다. 
	// 우리는 의미 명확하게 set은 값 입력하는애, get은 값 가져오는 애로 사용하는 것 뿐. 
	
	public String getChangeDate() {
		// yyyy-MM-dd hh:mm:00
		// 지금은 타임 스탬프를 통해서 변경할 것입니다. 
		// toDate "yyyyMMddhhmm" 으로 되어있는 값을 입력을 받을 것.
		// substring으로 쪼개서 사용해야 합니다.
		// yyyy-MM-dd hh
		String m = toDate.substring(0,4) + "-" + // year
				toDate.substring(4,6)+ "-" + // month 
				toDate.substring(6,8)+" " + // day
				toDate.substring(8,10)+ ":" + // hour 
				toDate.substring(10)+":00"; // min+sec
		System.out.println(m+"변경된 mDate");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 hh시mm분");
//		Date d = new Date(m);
//		sdf.format(d);
//		Date는 이제 없어질 애라 Calendar로 대체해서 사용하면 됩니다. 아님 그냥 아래 쓰셈
		
		Timestamp tm = Timestamp.valueOf(m);
		return sdf.format(tm);
	}
	
	// 입력할 거니까 setter을 만듭니다
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	
	
	
	
}
