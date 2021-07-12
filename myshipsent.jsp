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
		<tr>
			<td>주문배송현황</td> </br>
			<td>결제완료</td>
			<td>배송중</td>
			<td>배송완료</td>
		</tr>
	</div>
	<div>
		<tr>
			<td>배송완료</td>
		</tr>
	</div>	
</body>
</html>