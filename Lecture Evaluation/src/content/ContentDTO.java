package content;



public class ContentDTO {



	int contentID;// ���� ���̵�

	String userID;//�ۼ��� ���̵�

	String userName ;//�л��̸�

	String className ; //�а��̸�

	int eventYear ; //�߻�����

	String semesterDivide; //�߻� �б�

	String contentDivide ; //���� ����

	String contentTitle ; //�ο� ����

	String Content; // �� ����

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

