package likey;



public class LikeyDTO {



	String userID;

	int contentID;

	String userIP;

	

	public String getUserID() {

		return userID;

	}

	public void setUserID(String userID) {

		this.userID = userID;

	}

	public int getEvaluationID() {

		return contentID;

	}

	public void setEvaluationID(int evaluationID) {

		this.contentID = evaluationID;

	}

	public String getUserIP() {

		return userIP;

	}

	public void setUserIP(String userIP) {

		this.userIP = userIP;

	}

	

	public LikeyDTO(String userID, int evaluationID, String userIP) {

		this.userID = userID;

		this.contentID = evaluationID;

		this.userIP = userIP;

	}



}
