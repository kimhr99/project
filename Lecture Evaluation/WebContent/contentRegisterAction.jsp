<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="content.ContentDTO"%>

<%@ page import="content.ContentDAO"%>

<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");



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

	String userName = null;

	String className = null;

	int eventYear = 0;

	String semesterDivide = null;

	String contentDivide = null;

	String contentTitle = null;

	String Content = null;

	if(request.getParameter("userName") != null) {

		userName = (String) request.getParameter("userName");
		

	}

	if(request.getParameter("className") != null) {

		className = (String) request.getParameter("className");
		
	}

	if(request.getParameter("eventYear") != null) {

		try {

		eventYear = Integer.parseInt(request.getParameter("eventYear"));
	

		} catch (Exception e) {

	System.out.println("발생 연도 데이터 오류");

		}

	}

	if(request.getParameter("semesterDivide") != null) {

		semesterDivide = (String) request.getParameter("semesterDivide");
		

	}

	if(request.getParameter("contentDivide") != null) {

		contentDivide = (String) request.getParameter("contentDivide");
		
	}

	if(request.getParameter("contentTitle") != null) {

		contentTitle = (String) request.getParameter("contentTitle");
		
	}

	if(request.getParameter("Content") != null) {

		Content = (String) request.getParameter("Content");
		
	}

	

	if (userName == null || className == null || eventYear == 0 || semesterDivide == null ||

	contentDivide == null || contentTitle == null || Content == null || contentTitle.equals("") || Content.equals("")) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('입력이 안 된 사항이 있습니다.');");

		script.println("history.back();");

		script.println("</script>");

		script.close();

		return;

	} else {

		ContentDAO contentDAO = new ContentDAO();

		int result = contentDAO.write(new ContentDTO(0, userID, userName, className, eventYear,

		semesterDivide, contentDivide, contentTitle, Content, 0));

		if (result == -1) {

	PrintWriter script = response.getWriter();

	script.println("<script>");

	script.println("alert('평가 등록에 실패했습니다.');");

	script.println("history.back();");

	script.println("</script>");

	script.close();

	return;

		} else {

	PrintWriter script = response.getWriter();

	script.println("<script>");

	script.println("location.href = './index.jsp';");

	script.println("</script>");

	script.close();

	

		}

	}
%>
