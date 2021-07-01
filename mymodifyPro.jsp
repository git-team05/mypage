<%@page import="team05.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mymodifyPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="team05.member.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>
<% if(session.getAttribute("memId") == null) {%>
	<script type="text/javascript">
		alert("로그인 해주세요.");
		window.location="/team05/main/loginForm.jsp";
	</script>
<%} %>
<%
	String id = (String)session.getAttribute("memId");
	dto.setId(id);
	
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.updateMember(dto);
%>
<body>
	<br/> 
	<h1 align="center"> 회원 정보 수정</h1>
	<% if(result == 1) {%>
			<table>
				<tr> 
					<td> <b>회원 정보가 수정되었습니다.</b></td>
				</tr>
				<tr> 
					<td> <button onclick="window.location='/team05/main/main.jsp'">메인으로</button></td>
				</tr>
			</table>
		<%} else {%>
			<script>
				alert("회원 정보 수정 실패....");
				history.go(-1);	
			</script>
		<%} %>
</body>
</html>