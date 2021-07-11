<%@page import="team05.productorder.MypaymentDTO"%>
<%@page import="team05.product.ProductDTO"%>
<%@page import="team05.productorder.ProductorderDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="team05.productorder.ProductorderDAO"%>
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
	// 나의 주문수
	ProductorderDAO dao = ProductorderDAO.getInstance();
	System.out.println(id);
	int count = dao.getMypayCount(id);
	 
	List myList = null;
	if(count >0) {
		myList = dao.getMypayment(id);
		System.out.println("count : " + count);
	}
	
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
		<h2 align="center"> 주문 배송 현황 </h2>
		<%if(count == 0) { %>
			<table>
				<tr>
					<td> 주문 내역이 없습니다. </td>
				</tr>	
			</table>
		<%}else if(count > 0){ %>
			<table>
				<tr>
					<td></td>
					<td>주문번호</td>
					<td>상품명</td>
					<td>결제 금액</td>
					<td></td>
				</tr>
				<%for(int i = 0; i < myList.size(); i++) {
					MypaymentDTO mypay = (MypaymentDTO)myList.get(i);
				%>
					<tr>
						<td>
							<a href="/team05/product/productContent.jsp?">
							<img src="/team05/imgs/<%=mypay.getThumbImg() %>" /> </a>
						</td>
						<td><%=mypay.getOrderNum() %></td>
						<td><%=mypay.getProName()%></td>
						<td><%=mypay.getOrderTotal()%></td>
						<td> <input type="button" value="주문조회" onclick="window.open('myorderCheck.jsp?orderNum=<%=mypay.getOrderNum() %>','주문조회','width=500px, height=600px')"></td>
						<%-- <td> <button onclick="window.location='myorderCheck.jsp?orderNum=<%=mypay.getOrderNum() %>'">주문조회</td>  --%>
					</tr>
				<% } %>	
			</table>	
	</div>
<% } %>		
</body>
</html>
