<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<td> 
			<a href="/team05/main/main.jsp"> LOGO </a> &nbsp
	    </td>
		<td> 
			<a href="/team05/product/groupMain.jsp"> 공동구매  </a> &nbsp
	    </td>
		<td> 
			<a href="/team05/comming/commingSoonMain.jsp"> 오픈예정  </a> &nbsp
	    </td>
		<td> 
			<a href="/team05/admin/opensellMain.jsp"> 공구요청  </a> &nbsp
	    </td>
    	<input type="text" name="search" />
     	<input type="submit" value="검색" /> &nbsp	
		<td align="right">
			<% if(session.getAttribute("memId") == null) {%>
				<a href="/team05/main/loginForm.jsp" > 로그인 </a>
			<%}else{ %>
				<a href="/team05/main/logout.jsp" > 로그아웃 </a>
			<%} %>
		</td>
	</div>
</body>
</html>