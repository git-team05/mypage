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

	// 나의 주문수 paycon='finish'
	ProductorderDAO dao = ProductorderDAO.getInstance();
	System.out.println(id);
	int count = dao.getMypayCount(id);
	 
	List myList = null;
	if(count >0) {
		// o.delcon = 'delSoon' and o.paycon = 'finish'
		myList = dao.getMypayment(id);
		System.out.println("count : " + count);
	}
%>
<%	
	
	// 나의 주문중 배송중 인것의 수  paycon='finish' & delcon='delivery'
	int count1 = dao.getMyshippingCount(id);
	
	List myList1 = null; 
	// 배송중 리스트		 
	if(count1 >0) {
		myList1 = dao.getMyshipping(id); 
		System.out.println("count1 :" + count1);
	}
%>
<%	
	// 나의 주문중 배송 완료인것의 수  paycon ='finish' & delcon='delFinish' 
	int count2 = dao.getMyshipsentCount(id);
	
	List myList2 = null;
	// 배송 완료 리스트
	if(count2 >0 ){
		myList2 = dao.getMyshipsent(id);
		System.out.println("count2 :" + count2);
	}
%> 
<body>
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
		<h2 align="center"> 주문 배송 현황 </h2>
		<tr>
			<td>결제 완료</td>
		</tr>
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
		<%} %>
			<tr>
				<td>배송중</td>
			</tr>	
			<%if(count1 == 0) { %>
				<table>
					<tr>
						<td> 배송중 상품이 없습니다. </td>
					</tr>	
				</table>
			<%}else if(count1 > 0){ %>
				<table>
					<tr>
						<td></td>
						<td>주문번호</td>
						<td>상품명</td>
						<td>결제 금액</td>
						<td></td>
					</tr>
					<%for(int i = 0; i < myList1.size(); i++) {
						MypaymentDTO mypay1 = (MypaymentDTO)myList1.get(i);
					%>
						<tr>
							<td>
								<a href="/team05/product/productContent.jsp?">
								<img src="/team05/imgs/<%=mypay1.getThumbImg() %>" /> </a>
							</td>
							<td><%=mypay1.getOrderNum() %></td>
							<td><%=mypay1.getProName()%></td>
							<td><%=mypay1.getOrderTotal()%></td>
							<td> <input type="button" value="주문조회" onclick="window.open('mydeliveryCheck.jsp?orderNum=<%=mypay1.getOrderNum() %>','주문조회','width=500px, height=600px')"></td>
							<%-- <td> <button onclick="window.location='myorderCheck.jsp?orderNum=<%=mypay.getOrderNum() %>'">주문조회</td>  --%>
						</tr>
					<% } %>	
				</table>
			<%} %>	
			<tr>
				<td>배송완료</td>
			</tr>	
			<%if(count2 == 0) { %>
				<table>
					<tr>
						<td> 배송 완료된 상품이 없습니다. </td>
					</tr>	
				</table>
			<%}else if(count2 > 0){ %>
				<table>
					<tr>
						<td></td>
						<td>주문번호</td>
						<td>상품명</td>
						<td>결제 금액</td>
						<td></td>
					</tr>
					<%for(int i = 0; i < myList2.size(); i++) {
						MypaymentDTO mypay2 = (MypaymentDTO)myList2.get(i);
					%>
						<tr>
							<td>
								<a href="/team05/product/productContent.jsp?">
								<img src="/team05/imgs/<%=mypay2.getThumbImg() %>" /> </a>
							</td>
							<td><%=mypay2.getOrderNum() %></td>
							<td><%=mypay2.getProName()%></td>
							<td><%=mypay2.getOrderTotal()%></td>
							<td> <input type="button" value="주문조회" onclick="window.open('mydelFinishCheck.jsp?orderNum=<%=mypay2.getOrderNum() %>','주문조회','width=600px, height=700px')"></td>
							<%-- <td> <button onclick="window.location='myorderCheck.jsp?orderNum=<%=mypay.getOrderNum() %>'">주문조회</td>  --%>
						</tr>
					<% } %>	
				</table>
			
	</div>		
</body>
<%} %>	
</html>
