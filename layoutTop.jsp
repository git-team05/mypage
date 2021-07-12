<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>layoutTop</title>
	<link href="/team05/main/main.css" rel="stylesheet" type="text/css" >			
</head>
<body>
	<table>
		<tr>
			<td>
			<a href="/team05/main/main.jsp">로고</a>
			<a href="/team05/product/groupMain.jsp">공동구매</a>
			<a href="/team05/comming/commingSoonMain.jsp">오픈예정</a>
			<a href="/team05/admin/opensellMain.jsp">공구요청</a>
			</td>
			
			<%-- 상품명/태그 검색 --%>
			<td>
			<form action="/team05/product/groupSearch.jsp">
				<select name="sel">
					<option value="proName">상품명</option>
					<option value="tags">태그</option> 
				</select>
					<input type="text" name="search" />
					<input type="submit" value="검색" />
			</form>
			</td>
			
			<td>
			<%if(session.getAttribute("memId") == null && session.getAttribute("selId")== null) { // 비로그인 상태%>
				<a href="/team05/main/signupKinds.jsp" >회원가입</a> <!-- 회원가입 페이지로 이동 -->
				<a href="/team05/main/loginForm.jsp">𝙻𝚘𝚐𝚒𝚗</a> <!-- 로그인 페이지로 이동 -->
			<%}else if(session.getAttribute("memId") != null) { // 일반회원 로그인시%>
				<a><%= session.getAttribute("memId") %> 님 환영합니다.</a>
				<a href="/team05/mypage/myMain.jsp" >𝚖𝚢 𝚙𝚊𝚐𝚎</a> <!-- 마이 페이지로 이동 -->
				<a href="/team05/main/logout.jsp">𝚕𝚘𝚐𝚘𝚞𝚝</a> <!-- 로그아웃 페이지로 이동 -->
			<%}else if(session.getAttribute("selId") != null) { // 판매자 회원 로그인시%>
				<a><%= session.getAttribute("selId") %> 님 환영합니다.</a>
				<a href="/team05/seller/sellerMain.jsp" > 판매자 페이지 </a> <!-- 마이 페이지로 이동 -->
				<a href="/team05/main/logout.jsp">𝚕𝚘𝚐𝚘𝚞𝚝</a> <!-- 로그아웃 페이지로 이동 -->
			<%} %>
			</td>
		</tr>		
	</table>
</body>
</html>