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
<script type="text/javascript">
	
</script>
</head>
<% 
	String id = (String)session.getAttribute("memId");
	int orderNum = Integer.parseInt(request.getParameter("orderNum"));

	ProductorderDAO dao = ProductorderDAO.getInstance();
	ProductorderDTO myorderCheck = dao.getmyorderCheck(orderNum); 

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
     
%>
<body> 
	<br/>
	<h3 align="center"> 주문 상세 내역 </h3>
<%--	<input type="hidden" name="orderNum" value="<%=orderNum%>" />   --%>
		<table>
			<tr>
      			<td>주문번호</td><td> <%= myorderCheck.getOrderNum() %>번</td>
			</tr>
			<tr>
      			<td>상품번호 </td><td> <%= myorderCheck.getProNum() %>번</td>
			</tr>
			<tr>
      			<td>수량 </td><td> <%= myorderCheck.getQuantity()%>개</td>
			</tr>
			<tr>
      			<td>총 주문금액</td><td>  <%= myorderCheck.getOrderTotal()%>원</td>
			</tr>
			<tr>
      			<td>받으시는 분 </td><td> <%= myorderCheck.getReceiver()%>님</td>
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
			<tr>
				<td colspan="2" align="center"> 
					<input type="button" value="창닫기" onClick="window.close()">
					<td> <button onclick="window.location='/team05/product/productQnaForm.jsp?proNum=<%=myorderCheck.getProNum() %>'">환불신청</td> 
				</td>
			</tr>
		</table>
	</form>		
</body>
</html>