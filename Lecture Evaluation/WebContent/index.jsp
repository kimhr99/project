<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="user.UserDAO"%>

<%@ page import="content.ContentDAO"%>

<%@ page import="content.ContentDTO"%>

<%@ page import="java.util.ArrayList"%>

<%@ page import="java.net.URLEncoder"%>

<!doctype html>

<html>

  <head>

    <title>대구대 신문고</title>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- 부트스트랩 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/bootstrap.min.css">

    <!-- 커스텀 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/custom.css">

  </head>

  <body>

<%

	request.setCharacterEncoding("UTF-8");

	String contentDivide = "전체";

	String searchType = "최신순";

	String search = "";

	int pageNumber = 0;

	if(request.getParameter("contentDivide") != null) {

		contentDivide = request.getParameter("contentDivide");

	}

	if(request.getParameter("searchType") != null) {

		searchType = request.getParameter("searchType");

	}

	if(request.getParameter("search") != null) {

		search = request.getParameter("search");

	}

	if(request.getParameter("pageNumber") != null) {

		try {

	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));

		} catch (Exception e) {

	System.out.println("검색 페이지 번호 오류");

		}

	}

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

	}

	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);

	if(emailChecked == false) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("location.href = 'emailSendConfirm.jsp'");

		script.println("</script>");

		script.close();		

		return;

	}
%>	

    <nav class="navbar navbar-expand-lg navbar-light bg-light">

      <a class="navbar-brand" href="index.jsp">대구대 신문고</a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">

        <span class="navbar-toggler-icon"></span>

      </button>

      <div class="collapse navbar-collapse" id="navbar">

        <ul class="navbar-nav mr-auto">

          <li class="nav-item active">

            <a class="nav-link" href="index.jsp">메인</a>

          </li>

          <li class="nav-item dropdown">

            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">

              회원 관리

            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">

<%
	if(userID == null) {
%>

              <a class="dropdown-item" href="userLogin.jsp">로그인</a>

              <a class="dropdown-item" href="userRegister.jsp">회원가입</a>

<%
	} else {
%>

              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
             

<%
	}
%>

            </div>

          </li>
          
          <li class="nav-item active">

            <a class="nav-link" href="hotLike.jsp">핫게시물</a>

          </li>

        </ul>
        
  
        <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">

          <input type="text" name="search" class="form-control mr-sm-2" placeholder="내용을 입력하세요.">

          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>

        </form>

      </div>

    </nav>

    <div class="container">

      <form method="get" action="./index.jsp" class="form-inline mt-3">

        <select name="contentDivide" class="form-control mx-1 mt-2">

          <option value="전체">전체</option>

          <option value="시설" <%if(contentDivide.equals("시설")) out.println("selected");%>>시설</option>

          <option value="강의" <%if(contentDivide.equals("강의")) out.println("selected");%>>강의</option>
          
          <option value="교직원" <%if(contentDivide.equals("교직원")) out.println("selected");%>>교직원</option>

          <option value="기타" <%if(contentDivide.equals("기타")) out.println("selected");%>>기타</option>

        </select>

        <select name="searchType" class="form-control mx-1 mt-2">

          <option value="최신순">최신순</option>

          <option value="추천순" <%if(searchType.equals("추천순")) out.println("selected");%>>추천순</option>

        </select>

        <input type="text" name="search" class="form-control mx-1 mt-2" value="<%=search%>" placeholder="내용을 입력하세요.">

        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
        
      
     
        <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
        
    
        
      	<a class="btn btn-danger ml-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>

      </form>

<%
	ArrayList<ContentDTO> contentList = new ArrayList<ContentDTO>();

	contentList = new ContentDAO().getList(contentDivide, searchType, search, pageNumber);

	if(contentList != null)

	for(int i = 0; i < contentList.size(); i++) {

		if(i == 5) break;

		ContentDTO content = contentList.get(i);
		
%>	

      <div class="card bg-light mt-3">

        <div class="card-header bg-light">

          <div class="row">

            <div class="col-8 text-left"><%=content.getuserName()%>&nbsp;<small><%=content.getclassName()%></small></div>


          </div>

        </div>

        <div class="card-body">

          <h5 class="card-title">

            <%=content.getcontentTitle()%>&nbsp;<small>(<%=content.geteventYear()%>년 <%=content.getSemesterDivide()%>)</small>

          </h5>

          <p class="card-text"><%=content.getContent()%></p>

          <div class="row">

            <div class="col-9 text-left">

             <span style="color: green;">(추천: <%=content.getLikeCount()%>)</span>
             
             <a onclick="return confirm('댓글을 다시겠습니까?')" href="./comment.jsp">댓글</a>
              
            </div>

            <div class="col-3 text-right">

              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?contentID=<%=content.getcontentID()%>">추천</a>

			  <a onclick="return confirm('비추천하시겠습니까?')" href="./hateAction.jsp?contentID=<%=content.getcontentID()%>">비추천</a>

              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?contentID=<%=content.getcontentID()%>">삭제</a>

            </div>

          </div>
          
          <div 	id = "comments">
          	
          </div>
          
		

        </div>

      </div>

<%

	}

%>

    </div>

    <ul class="pagination justify-content-center mt-3">

      <li class="page-item">

<%

	if(pageNumber <= 0) {

%>     

        <a class="page-link disabled">이전</a>

<%

	} else {

%>

		<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(contentDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a>

<%

	}

%>

      </li>

      <li class="page-item">

<%

	if(contentList.size() < 6) {

%>     

        <a class="page-link disabled">다음</a>

<%

	} else {

%>

		<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(contentDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>

<%

	}

%>

      </li>

    </ul>

    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">

      <div class="modal-dialog">

        <div class="modal-content">

          <div class="modal-header">

            <h5 class="modal-title" id="modal">평가 등록</h5>

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

              <span aria-hidden="true">&times;</span>

            </button>

          </div>

          <div class="modal-body">

            <form action="./contentRegisterAction.jsp" method="post">

              <div class="form-row">

                <div class="form-group col-sm-6">

                  <label>학생명</label>
                  
                  <select name="userName" class="form-control">
           
					<option value="<%=userID %>" selected><%=userID %></option>
					
					<option value="익명">익명</option>

                  </select>
                  
                 
                </div>

                <div class="form-group col-sm-6">

                  <label>학과명</label>
                  

                  <input type="text" name="className" class="form-control" maxlength="20">

                </div>

              </div>

              <div class="form-row">

                <div class="form-group col-sm-4">

                  <label>발생 년도</label>

                  <select name="eventYear" class="form-control">

                    <option value="2011">2011</option>

                    <option value="2012">2012</option>

                    <option value="2013">2013</option>

                    <option value="2014">2014</option>

                    <option value="2015">2015</option>

                    <option value="2016">2016</option>

                    <option value="2017">2017</option>

                    <option value="2018" selected>2018</option>

                    <option value="2019">2019</option>

                    <option value="2020">2020</option>

                    <option value="2021">2021</option>

                    <option value="2022">2022</option>

                    <option value="2023">2023</option>

                  </select>

                </div>

                <div class="form-group col-sm-4">

                  <label>발생 학기</label>

                  <select name="semesterDivide" class="form-control">

                    <option name="1학기" selected>1학기</option>

                    <option name="여름학기">여름학기</option>

                    <option name="2학기">2학기</option>

                    <option name="겨울학기">겨울학기</option>

                  </select>

                </div>

                <div class="form-group col-sm-4">

                  <label>주제 구분</label>

                  <select name="contentDivide" class="form-control">

                    <option name="시설" selected>시설</option>

                    <option name="강의">강의</option>
                    
                    <option name="교직원">교직원</option>

                    <option name="기타">기타</option>

                  </select>

                </div>

              </div>

              <div class="form-group">

                <label>제목</label>

                <input type="text" name="contentTitle" class="form-control" maxlength="20">

              </div>

              <div class="form-group">

                <label>내용</label>

                <textarea type="text" name="Content" class="form-control" maxlength="2048" style="height: 180px;"></textarea>

              </div>

              

              <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>

                <button type="submit" class="btn btn-primary">등록하기</button>

              </div>

            </form>

          </div>

        </div>

      </div>

    </div>

    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">

      <div class="modal-dialog">

        <div class="modal-content">

          <div class="modal-header">

            <h5 class="modal-title" id="modal">신고하기</h5>

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

              <span aria-hidden="true">&times;</span>

            </button>

          </div>

          <div class="modal-body">

            <form method="post" action="./reportAction.jsp">

              <div class="form-group">

                <label>신고 제목</label>

                <input type="text" name="reportTitle" class="form-control" maxlength="20">

              </div>

              <div class="form-group">

                <label>신고 내용</label>

                <textarea type="text" name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>

              </div>

              <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>

                <button type="submit" class="btn btn-danger">신고하기</button>

              </div>

            </form>

          </div>

        </div>

      </div>

    </div>

    <!-- 제이쿼리 자바스크립트 추가하기 -->

    <script src="./js/jquery.min.js"></script>

    <!-- Popper 자바스크립트 추가하기 -->

    <script src="./js/popper.min.js"></script>

    <!-- 부트스트랩 자바스크립트 추가하기 -->

    <script src="./js/bootstrap.min.js"></script>

  </body>

</html>
