<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>

<%@ page import="content.ContentDAO"%>

<%@ page import="likey.LikeyDTO"%>

<%@ page import="java.io.PrintWriter"%>

<%
	String userID = null;

	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}

	if(userID == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인을 해주세요.');");

		script.println("location.href = 'userLogin.jsp'");

		script.println("</script>");

		script.close();

		return;

	}

	request.setCharacterEncoding("UTF-8");

	String contentID = null;
	System.out.println("사용자 123333333333333333333: " + request.getParameter("contentID"));
	if(request.getParameter("contentID") != null) {

		contentID = (String) request.getParameter("contentID");
		System.out.println("contentID는 null이 아님");

	}else{
		System.out.println("contentID는 null임");
		contentID = (String) request.getParameter("contentID");
		System.out.println("contentID: " + contentID);
	}

	ContentDAO contentDAO = new ContentDAO();

	if(userID.equals(contentDAO.getUserID(contentID))) {

		int result = new ContentDAO().delete(contentID);
		

		if (result == 1) {

			session.setAttribute("userID", userID);
		
			PrintWriter script = response.getWriter();
		
			script.println("<script>");
		
			script.println("alert('삭제가 완료되었습니다.');");
		
			script.println("location.href='index.jsp'");
		
			script.println("</script>");
		
			script.close();
		
			return;} 
		else {

			PrintWriter script = response.getWriter();
		
			script.println("<script>");
		
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
		
			script.println("history.back();");
		
			script.println("</script>");
		
			script.close();
		
			return;}

	} 
	
	
	else {
		
		System.out.println("삭제 오류: " + userID.equals(contentDAO.getUserID(contentID)));
		System.out.println("사용자 contentID: " + contentID);
		System.out.println("사용자 아이디: " + userID);
		System.out.println("내용 아이디: " + contentDAO.getUserID(contentID));

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('자신이 쓴 글만 삭제 가능합니다.');");

		script.println("history.back();");

		script.println("</script>");

		script.close();}
%>
