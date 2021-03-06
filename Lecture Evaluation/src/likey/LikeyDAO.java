package likey;



import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.SQLException;



public class LikeyDAO {



	private Connection conn;



	public LikeyDAO() {

		try {

			String dbURL = "jdbc:mysql://localhost:3306/Project?characterEncoding=UTF-8&serverTimezone=UTC";

			String dbID = "root";

			String dbPassword = "rantmtmfh";

			Class.forName("com.mysql.cj.jdbc.Driver");

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {

			e.printStackTrace();

		}

	}

	

	public int like(String userID, String contentID, String userIP) {

		String SQL = "INSERT INTO LIKEY VALUES (?, ?, ?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, userID);

			pstmt.setString(2, contentID);

			pstmt.setString(3, userIP);

			return pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return -1; // 추천 중복 오류

	}

	

}
