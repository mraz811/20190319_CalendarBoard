package happy.com.dto;

import java.io.Serializable;
import java.util.Date;

public class CalDto implements Serializable {

	private static final long serialVersionUID = 5079161996868126215L;
	
	private int seq;
	private String id;
	private String title;
	private String content;
	private String mDate;
	private Date regDate;
	 
	public CalDto() { 
		super();
		// TODO Auto-generated constructor stub
	}
	  
	public CalDto(int seq, String id, String title, String content, String mDate, Date regDate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.mDate = mDate;
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "CalDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", mDate=" + mDate
				+ ", regDate=" + regDate + "]";
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getmDate() {
		return mDate;
	}

	public void setmDate(String mDate) {
		this.mDate = mDate;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	
	
}
