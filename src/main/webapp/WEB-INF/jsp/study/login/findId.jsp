<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="${pageContext.request.contextPath}/js/study/lib/jquery-1.11.3.min.js"></script>

<!-- s:container -->
        <div> 
            <h1>아이디/비밀번호 찾기</h1>
        </div>
        <div>
        	<a href="${pageContext.request.contextPath}/login/findId.do"><button type="button">아이디 찾기</button></a>
        	<a href="${pageContext.request.contextPath}/login/findPw.do"><button type="button">비밀번호 찾기</button></a>
        </div>
        <div>
        	<form id="findIdForm" name="findIdForm" method="post">
        	<input type="hidden" id="userName" name="userName" value="">
        	<input type="hidden" id="userMail" name="userMail" value="">
        	<input type="hidden" id="userId" name="userId" value="">
        	<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
	  		<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
	  		<table>
	  			<tr>
	  				<td width="100">이름</td>
	  				<td width="200"><input type="text" id="inputName" name="inputName"></td>
	  			</tr>
	  			<tr>
	  				<td width="100">이메일 주소</td>
	  				<td width="200"><input type="text" id="inputMail" name="inputMail"></td>
	  			</tr>
	  		</table>
        	</form>
            <div>
            	<table width="300">
            		<tr>
            			<td><button type="button" style="background-color:gray;" onclick="window.close();"><p style="color:white;">닫기</p></button></td>
            			<td align="right"><button type="button" onclick="fn_findIdAction();" style="background-color:blue;"><p style="color:white;">찾기</p></button></td>
            		</tr>
            	</table>
            </div>
        </div>
<!-- e:container -->

<script type="text/javascript">

function fn_findIdAction() {
	var frm = document.findIdForm;
	
	if ($("#inputName").val() == "") {
		alert("이름을 입력해주세요.");
		return;
	}
	
	if ($("#inputMail").val() == "") {
		alert("이메일 주소를 입력해주세요.");
		 return;
	}
	
	var rsa = new RSAKey();
	rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
	
	$("#userName").val(rsa.encrypt($("#inputName").val()));
	$("#userMail").val(rsa.encrypt($("#inputMail").val()));
	
	$.ajax({
		url: "findIdAction.do",
		type: "post",
		dataType: "json",
		data: {"userName": $("#userName").val(), "userMail": $("#userMail").val()},
		success: function(data) {
			if (data.success) {
				alert("아이디 찾기 성공");
				
				$("#userId").val(data.userId)
				
				frm.method = "post";
				frm.action = "<c:url value='/login/findIdResult.do'/>"
				frm.submit();
			} else {
				alert(data.findIdFailMsg);
			}
		},
		error: function(request, status, error){
			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n"+"error: " + error);
		}
	});
}

</script>

<script src="${pageContext.request.contextPath}/js/study/rsa/rsa.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/jsbn.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/prng4.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/rng.js"></script>

