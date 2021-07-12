<%@page import="team05.productorder.ProductorderDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myMain page</title>
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
	
	// 나의 주문중 배송중 인것의 수  paycon='finish' & delcon='shipping'
	int count1 = dao.getMyshippingCount(id);
	
	List myList1 = null; 
	// 배송중 리스트		 
	if(count1 >0) {
		myList1 = dao.getMyshipping(id); 
		System.out.println("count1 :" + count1);
	}
%>
<%	
	// 나의 주문중 배송 완료인것의 수  paycon ='finish' & delcon='shipsent' 
	int count2 = dao.getMyshipsentCount(id);
	
	List myList2 = null;
	// 배송 완료 리스트
	if(count2 >0 ){
		myList2 = dao.getMyshipsent(id);
		System.out.println("count2 :" + count2);
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
		<form>
			<table class="field">
				<tr>
					<td><img src="/team05/imgs/delSoon.jpg" /> </a></td>
					<td><img src="/team05/imgs/delivery.jpg" /> </a></td>
					<td><img src="/team05/imgs/delFinish.jpg" /> </a></td>
				</tr>
				<tr>
					<td>결제완료</td>
					<td>배송중</td>
					<td>배송완료</td>
				</tr>			
				<tr>
					<td><h3><%=count %>건</h3></td>
					<td><h3><%=count1 %>건</h3></td>
					<td><h3><%=count2 %>건</h3></td>
					
				</tr>
			</table>
		</form>	
	</div>	
</body>
</html>




