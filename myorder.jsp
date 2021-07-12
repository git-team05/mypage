<%@page import="team05.productorder.MypaymentDTO"%>
<%@page import="java.util.List"%>
<%@page import="team05.productorder.ProductorderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취소  / 환불 내역</title>
</head>
<%
	String id = (String)session.getAttribute("memId");
	ProductorderDAO dao = ProductorderDAO.getInstance();
	System.out.println(id);
	// 내 주문중 취소내역 count 
	int count = dao.getMycancelCount(id);
	// 내 주문중 취소 내역 보여주기
	List mycancelList = null; 
	if(count >0) { 
		mycancelList = dao.getMycancel(id);
		System.out.println("count :" + count);
	} 
	
	// 내 주문중 환불내역 count
	int count1 = dao.getMyrefundCount(id);
	// 내 주문중 환불 내역 보여주기
	List myrefundList = null;
	if(count1 >0) {
		myrefundList = dao.getMyrefund(id);
		System.out.println("count1 :" + count1);
	}
%> 
<body> 
	<div>
		<tr>
			<td colspan="2">
				<jsp:include page="layoutTop.jsp"></jsp:include>
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
		<h2 align="center"> 취소 / 환불 현황 </h2>	
		<tr>
			<td>취소 내역</td>
		</tr>	
		<%if(count == 0) { %>
			<table>
				<tr>
					<td>취소 내역이 없습니다.</td>
				</tr>
			</table>
		<%}else if(count >0) {%>
			<table>
				<tr>
					<td></td>
					<td>주문번호</td>
					<td>상품번호</td>
					<td>상품명</td>
					<td>결제금액</td>
				</tr>
				<%for(int i=0; i<mycancelList.size(); i++) {
					MypaymentDTO mycancel = (MypaymentDTO)mycancelList.get(i);
				%>
					<tr>
						<td>
							<a href="/team05/product/productContent.jsp?">
							<img src="/team05/imgs/<%=mycancel.getThumbImg() %>" /> </a>
						</td>
						<td><%=mycancel.getOrderNum() %></td>
						<td><%=mycancel.getProNum()%></td>
						<td><%=mycancel.getProName()%></td>
						<td><%=mycancel.getOrderTotal()%>원</td>
					</tr>
				<% } %>	
			</table>	
		<%} %>	
		<tr>
			<td>환불 내역</td>
		</tr>	
		<%if(count1 == 0) { %>
			<table>
				<tr>
					<td>환불 내역이 없습니다.</td>
				</tr>
			</table>
		<%}else if(count1 >0) {%>
			<table>
				<tr>
					<td></td>
					<td>주문번호</td>
					<td>상품번호</td>
					<td>상품명</td>
					<td>결제금액</td>
				</tr>
				<%for(int i=0; i<myrefundList.size(); i++) {
					MypaymentDTO myrefund= (MypaymentDTO)myrefundList.get(i);
				%>
					<tr>
						<td>
							<a href="/team05/product/productContent.jsp?">
							<img src="/team05/imgs/<%=myrefund.getThumbImg() %>" /> </a>
						</td>
						<td><%=myrefund.getOrderNum() %></td>
						<td><%=myrefund.getProNum()%></td>
						<td><%=myrefund.getProName()%></td>
						<td><%=myrefund.getOrderTotal()%>원</td>
					</tr>
				<% } %>	
			</table>
		<%} %>			
	</div>	
</body>
</html>