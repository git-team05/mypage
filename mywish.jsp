<%@page import="team05.jjim.JjimDTO"%>
<%@page import="java.util.List"%>
<%@page import="team05.jjim.JjimDAO"%>
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

	//나의 찜 수
	JjimDAO dao = JjimDAO.getInstance();
	System.out.println(id);
	int count = dao.JjimCount(id); 
	
	List mywishList = null;
	if(count >0) {
		mywishList = dao.getMywish(id); 
		System.out.println("count : " + count );
	}
%>
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
		<h2 align="center"> 찜한 상품 </h2>
		<%if(count == 0) { %>
			<table>
				<tr>
					<td> 주문 내역이 없습니다.</td>
				</tr>
			</table>
		<%}else if(count >0) { %>
			<table>
				<tr>	
					<td> </td>
					<td> 일련번호</td>
					<td> 판매상태</td>
					<td> 상품번호</td>

				</tr>
				<%for(int i =0; i< mywishList.size(); i++) {
					JjimDTO mywish = (JjimDTO)mywishList.get(i);
				%>
					<tr>
						<td>
							
						</td>
						<td><%= mywish.getNum() %></td>
						<td><%= mywish.getType() %></td>
						<td><%= mywish.getPronum() %></td>
						<td><button onclick="window.location='/team05/product/productContent.jsp?pronum=<%=mywish.getPronum()%>'">공구참여</button></td>
					</tr>
				<% } %>
			</table>	
	</div>	
<% } %>
</body>
</html>