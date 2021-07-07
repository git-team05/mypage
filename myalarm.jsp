<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team05.alarm.MyalarmDTO"%>
<%@page import="team05.product.ProductDTO"%>
<%@page import="team05.alarm.AlarmDTO"%>
<%@page import="java.util.List"%>
<%@page import="team05.alarm.AlarmDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
	String id = (String)session.getAttribute("memId");

	// 나의 알림 신청 수 count
	AlarmDAO dao = AlarmDAO.getInstance();
	System.out.println(id); 
	int count = dao.AlarmCount(id);
	
	// 내가 알림 신청한 내역
	List myalarmList = null;
	if(count > 0) { 
		myalarmList = dao.getMyalarm(id);
		System.out.println("count : " + count);
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<body>
<body>
	<div>
		<tr>
			<td colspan="2">
				<jsp:include page="mylayoutTop.jsp"></jsp:include>
			</td>
		</tr>
	</div>
	<div>	
		<tr>
			<td width="15%">
		    	<jsp:include page="mylayoutLeft.jsp"></jsp:include>
		    </td>
		</tr>
	</div>
	<div>
		<br/>
		<h2 align="center"> 오픈예정 공구알림 </h2>
		<% if (count == 0) { %>
			<table>
				<tr>
					<td>신청한 알림이 없습니다.</td>
				</tr>
			</table>
		<%} else if (count > 0) { %>	
		<table>
			<tr>
				<td></td>
				<td> 상품번호 </td>
				<td> 상품명 </td>
				<td> 판매시작일 </td>
			</tr>
			<% for (int i =0; i<myalarmList.size(); i++) {
				MyalarmDTO myalarm = (MyalarmDTO)myalarmList.get(i);
			%>
				<tr>
					<td>
						<a href="/team05/product/productContent.jsp?">
						<img src="/team05/imgs/<%=myalarm.getThumbImg()%>" /></a>
					</td>
					<td><%=myalarm.getProNum() %></td>
					<td><%=myalarm.getProName() %></td> 
					<td><%=myalarm.getStartDate() %></td> 
				</tr>
			<%} %>	
		</table>	
	</div>	
<%} %>	
</body>
</html>
