package content;


import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.util.ArrayList;



public class ContentDAO {



	private Connection conn;

	private ResultSet rs;



	public ContentDAO() {

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

	

	public int write(ContentDTO contentDTO) {

		PreparedStatement pstmt = null;

		try {

			String SQL = "INSERT INTO CONTENT VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, 0);";

			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, contentDTO.getUserID());

			pstmt.setString(2, contentDTO.getuserName());

			pstmt.setString(3, contentDTO.getclassName());

			pstmt.setInt(4, contentDTO.geteventYear());

			pstmt.setString(5, contentDTO.getSemesterDivide());

			pstmt.setString(6, contentDTO.getcontentDivide());

			pstmt.setString(7, contentDTO.getcontentTitle());

			pstmt.setString(8, contentDTO.getContent());
			
			return pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			try {

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e) {

				e.printStackTrace();

			}

		}

		return -1;

	}
	
	
	public ArrayList<ContentDTO> getList(String contentDivide, String searchType, String search, int pageNumber) {

		if(contentDivide.equals("전체")) {

			contentDivide = "";

		}

		ArrayList<ContentDTO> contentList = null;

		PreparedStatement pstmt = null;

		String SQL = "";

		try {

			if(searchType.equals("최신순")) {

				SQL = "SELECT * FROM CONTENT WHERE contentDivide LIKE ? AND CONCAT(userName, className, contentTitle, Content) LIKE ? ORDER BY contentID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;

			} else if(searchType.equals("추천순")) {

				SQL = "SELECT * FROM CONTENT WHERE contentDivide LIKE ? AND CONCAT(userName, className, contentTitle, Content) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;

			}

			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, "%" + contentDivide + "%");

			pstmt.setString(2, "%" + search + "%");

			rs = pstmt.executeQuery();

			contentList = new ArrayList<ContentDTO>();

			while(rs.next()) {

				ContentDTO content = new ContentDTO(

					rs.getInt(1),	

					rs.getString(2),

					rs.getString(3),

					rs.getString(4),

					rs.getInt(5),

					rs.getString(6),

					rs.getString(7),

					rs.getString(8),

					rs.getString(9),

					rs.getInt(10)
					);

				contentList.add(content);

			}

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			try {

				if(rs != null) rs.close();

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e) {

				e.printStackTrace();

			}

		}

		return contentList;

	}
	
	

	public int like(String contentID) {

		PreparedStatement pstmt = null;

		try {

			String SQL = "UPDATE CONTENT SET likeCount = likeCount + 1 WHERE contentID = ?";

			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, Integer.parseInt(contentID));

			return pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			try {

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e) {

				e.printStackTrace();

			}

		}

		return -1;

	}

	

	public int delete(String contentID) {

		PreparedStatement pstmt = null;

		try {

			String SQL = "DELETE FROM CONTENT WHERE contentID = ?";

			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, Integer.parseInt(contentID));

			return pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			try {

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e) {

				e.printStackTrace();

			}

		}

		return -1;

	}

	

	public String getUserID(String contentID) {

		PreparedStatement pstmt = null;

		try {
			System.out.println(contentID);
			String SQL = "SELECT userID FROM CONTENT WHERE contentID = ?";

			pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, Integer.parseInt(contentID));

			rs = pstmt.executeQuery();

			while(rs.next()) {

				return rs.getString(1);

			}

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			try {

				if(pstmt != null) pstmt.close();

				if(conn != null) conn.close();

			} catch (Exception e) {

				e.printStackTrace();

			}

		}

		return null;

	}


}
