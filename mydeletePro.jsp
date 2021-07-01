<%@page import="team05.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%if(session.getAttribute("memId")==null){ %>
	<script type="text/javascript">
		alert("로그인 해주세요.");
		window.location="/team05/main/loginForm.jsp";
	</script> 
<%} %>
<%
	String id = (String)session.getAttribute("memId");
	String pw = request.getParameter("pw");
	
	System.out.println("deletePro id :" + id);
	System.out.println("deletePro pw :" + pw);
	
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.deleteMember(id,pw);
	
	if(result == 1) {
		session.invalidate();
		Cookie[]coos = request.getCookies();
		if(coos != null) {
			for (Cookie c : coos) {
				if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoCh")) {
					c.setMaxAge(0);
					response.addCookie(c);
				}
			}
		}
	%>	
<body>
	<br/>
	<h1 align="center"> 회원 탈퇴 </h1>
	<table>
		<tr> 
			<td> 회원 정보가 삭제 되었습니다.</td>
		</tr>
		<tr> 
			<td> <button onclick="window.location='/team05/main/main.jsp'"> 메인으로 </button></td>
		</tr>
	</table>	
</body>
<%}else{ %>
	<script>
		alert("비밀번호가 맞지 않습니다. 다시 시도해주세요...");
		history.go(-1);
	</script>
<%} %>
</html>