<%@page import="team05.productorder.ProductorderDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="team05.productorder.ProductorderDAO"%>
<%@page import="team05.productorder.MypaymentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
	int orderNum = Integer.parseInt(request.getParameter("orderNum"));

	ProductorderDAO dao = ProductorderDAO.getInstance();
	ProductorderDTO myorderCheck = dao.getmyorderCheck(orderNum); 

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    
%>
<body>
	<br/>
	<h4 align="center"> 주문 상세 내역 </h4>
		<table>
			<tr>
      			<td>주문번호</td><td> <%= myorderCheck.getOrderNum() %></td>
			</tr>
			<tr>
      			<td>상품번호 </td><td> <%= myorderCheck.getProNum() %></td>
			</tr>
			<tr>
      			<td>수량 </td><td> <%= myorderCheck.getQuantity()%></td>
			</tr>
			<tr>
      			<td>총 주문금액</td><td>  <%= myorderCheck.getOrderTotal()%></td>
			</tr>
			<tr>
      			<td>받으시는 분 </td><td> <%= myorderCheck.getReceiver()%></td>
			</tr>
			<tr>
      			<td>우편번호 </td><td> <%= myorderCheck.getRecZipcode()%></td>
			</tr>
			<tr>
      			<td>주소 </td><td> <%= myorderCheck.getRecAddress()%></td>
			</tr>
			<tr>
      			<td>상세주소 </td><td> <%= myorderCheck.getRecAddressDetail()%></td>
			</tr>
			<tr>
      			<td>전화번호 </td><td> <%= myorderCheck.getRecPhone()%></td>
			</tr>
			<tr>
      			<td>배송상태 </td><td> <%= myorderCheck.getDelCon()%></td>
			</tr>
			<tr>
      			<td>결제상태 </td><td> <%= myorderCheck.getPayCon()%></td>
			</tr>
			<tr>
      			<td>주문일 </td><td> <%= sdf.format(myorderCheck.getReg())%></td>
			</tr>		
		</table>	
		<div align="center"><p>
			<tr>
				<td><input type="button" value="창닫기" onClick="window.close()"></td>
				<td><button onclick="window.location='/team05/product/productQnaForm.jsp'">주문 취소</button>
			</tr>
		</div>
</body>
</html>