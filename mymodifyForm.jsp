<%@page import="team05.member.MemberDTO"%>
<%@page import="team05.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mymodifyForm</title>
	<script>
		function check () {
			var inputs = document.inputForm;
			if(!inputs.pw.value) {
				alert("비밀번호를 입력하세요");
				return false;
			}
			if(!inputs.pwCh.value) {
				alert("비밀번호 확인란을 입력하세요");
				return false;
			}
			if (inputs.pw.value !=inputs.pwCh.value) {
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}
		}
	</script>
</head>
<%
	String id = (String)session.getAttribute("memId");

	MemberDAO dao = MemberDAO.getInstance(); 
	MemberDTO member = dao.getMember(id);
%>
<body>
	<tr>
		<td colspan="2">
			<jsp:include page="layoutTop.jsp"></jsp:include>
		</td>
	</tr>
	<tr>
		<td width="15%">
		    <jsp:include page="mylayoutLeft.jsp"></jsp:include>
		</td>
	</tr>
	<br/>
	<h1 align="center"> 회원 정보 수정</h1>
	
	<form action="mymodifyPro.jsp" method ="post" name="inputForm" onsubmit="return check()" > 
	<table>
		<tr>
            <td>아이디</td>
            <td>
               <%= member.getId() %>
            </td>
         </tr>
         <tr>
            <td>비밀번호</td>
            <td>
               <input type="password" name="pw" value="<%= member.getPw() %>"/> 
            </td>
         </tr>
         <tr>
            <td>비밀번호 확인</td>
            <td>
               <input type="password" name="pwCh" /> 
            </td>
         </tr>
         <tr>
            <td>이름</td>
            <td>
               <%=member.getName() %> 
            </td>
         </tr>
         <tr>
            <td>이메일</td>
            <td>
               <input type="text" name="email" value="<%=member.getEmail()%>"/> 
            </td>
         </tr>
         <tr>
            <td>전화번호</td>
            <td>
               <input type="text" name="phone" value="<%=member.getPhone()%>"/> 
            </td>
         </tr>
         <tr>
            <td colspan="2" align="center">
				<input type = "submit" value = "수정"/>
				<input type = "reset" value = "재작성"/>
				<input type = "button" value = "취소" onclick="window.location='/team05/mypage/myMain.jsp'"/>
			</td>
         </tr>
	</table> 
	</form>        
</body>
</html>