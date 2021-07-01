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
		<tr>
			<td>비밀번호 변경</td> </br>
			<td>현재 비밀번호 </td> </br>
			<td>새 비밀번호</td> </br>
			<td>새 비밀번호 확인</td> </br>
		</tr>
	</div>	
</body>
</html>