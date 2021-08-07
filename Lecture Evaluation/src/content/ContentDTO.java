package content;



public class ContentDTO {



	int contentID;// 내용 아이디

	String userID;//작성자 아이디

	String userName ;//학생이름

	String className ; //학과이름

	int eventYear ; //발생연도

	String semesterDivide; //발생 학기

	String contentDivide ; //주제 구분

	String contentTitle ; //민원 제목

	String Content; // 평가 내용

	int likeCount;

	

	public int getcontentID() {

		return contentID;

	}

	public void setcontentID(int contentID) {

		this.contentID = contentID;

	}

	public String getUserID() {

		return userID;

	}

	public void setUserID(String userID) {

		this.userID = userID;

	}

	public String getuserName() {

		return userName;

	}

	public void setuserName(String userName) {

		this.userName = userName;

	}

	public String getclassName() {

		return className;

	}

	public void setclassName(String className) {

		this.className = className;

	}

	public int geteventYear() {

		return eventYear;

	}

	public void seteventYear(int eventYear) {

		this.eventYear = eventYear;

	}

	public String getSemesterDivide() {

		return semesterDivide;

	}

	public void setSemesterDivide(String semesterDivide) {

		this.semesterDivide = semesterDivide;

	}

	public String getcontentDivide() {

		return contentDivide;

	}

	public void setcontentDivide(String contentDivide) {

		this.contentDivide = contentDivide;

	}

	public String getcontentTitle() {

		return contentTitle;

	}

	public void setcontentTitle(String contentTitle) {

		this.contentTitle = contentTitle;

	}

	public String getContent() {

		return Content;

	}

	public void setContent(String Content) {

		this.Content = Content;

	}

	
	public int getLikeCount() {

		return likeCount;

	}

	public void setLikeCount(int likeCount) {

		this.likeCount = likeCount;

	}
	
	public ContentDTO() {

	}

	

	public ContentDTO(int contentID, String userID, String userName, String className, int eventYear,

			String semesterDivide, String contentDivide, String contentTitle, String Content,

		     int likeCount) {

		super();

		this.contentID = contentID;

		this.userID = userID;

		this.userName = userName;

		this.className = className;

		this.eventYear = eventYear;

		this.semesterDivide = semesterDivide;

		this.contentDivide = contentDivide;

		this.contentTitle = contentTitle;

		this.Content = Content;

		this.likeCount = likeCount;

	}


}

