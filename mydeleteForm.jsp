<%@page import="team05.member.MemberDTO"%>
<%@page import="team05.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 탈퇴 페이지</title>
</head>
<% 
	if(session.getAttribute("memId")==null) {%>
	<script>
		alert("로그인 해주세요");
		window.location="/team05/main/loginForm.jsp";
	</script>
<% }else{
	String id = (String)session.getAttribute("memId");
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMember(id);
%>	
<body>
	<br/>
	<h1 align="center"> 회원 탈퇴 </h1>
	<form action="mydeletePro.jsp" method="post">
		<table>
			<tr> 
				<td> 탈퇴를 원하시면 비밀번호를 입력하세요. <br/> 
					<input type="password" name="pw"/> 
				</td>
			</tr>
			<tr> 
				<td> 
					<input type="submit" value="회원탈퇴"/> 
					<input type="button" value="취소" onclick="window.location='/team05/mypage/myMain.jsp'"/> 
				</td>
			</tr>
		</table>
	</form>
</body>
<%} %>
</html>