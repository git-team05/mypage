<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<%--
	<script>
	
		function check () {
			var inputs = document.inputForm;
			if(!inputs.pw.value) {
				alert("현재 비밀번호를 입력하세요");
				return false;
			}
			if(!inputs.pwCh.value) {
				alert("새 비밀번호를 입력하세요");
				return false;
			}
			
		}
	</script>
	--%>
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
	<br/>
	<h2 align="center"> 비밀번호 변경 </h2>
		<form action="pwchangePro.jsp" method ="post" name="inputForm" onsubmit="return check()">
			<table>	
				<tr>
					<td>현재 비밀번호 </td>
					<td><input type="password" name="pw"/></td></br>
				</tr>
				<tr>
					<td>새 비밀번호</td>
					<td><input type="password" name="pw" /> </td></br>
				</tr>
				<tr>
					<td>새 비밀번호 확인</td>
					<td><input type="password" name="pw"/> </td></br>
				</tr>
				<tr>
	            	<td colspan="2" align="center">
						<input type = "submit" value = "변경"/>
						<input type = "button" value = "취소" onclick="window.location='/team05/mypage/myMain.jsp'"/>
					</td>
	        	 </tr>
	        </table>	 
        </form>	 
	</div>	
</body>
</html>