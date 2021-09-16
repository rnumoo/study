<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/EgovPageLink.do?link=study/inc/header" />

<!-- s:container -->
<body>
        <div style="width:400px; margin:auto;">
            <h1>비밀번호 변경</h1>
        </div>
        <div style="width:400px; margin:auto;">
            <p>소중한 개인정보를 안전하게 보호하기 위해 비밀번호 변경을 안내 드립니다.</p>
            <div>
            	<form id="changePwForm" name="changePwForm" method="post">
            	<input type="hidden" id="userPw" name="userPw" value="">
            	<input type="hidden" id="userPwNew" name="userPwNew" value="">
            	<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
	  			<input type="hidden" id="RSAExponent" value="${RSAExponent}"/> 
                <div>
                	<table style="border:1px solid black; width:400px; margin:auto;">
                		<tr>
                			<td style="border:1px solid black; width=200px">현재 비밀번호</td>
                			<td style="border:1px solid black;" width="200">
                				<input type="password" class="inputPw" id="inputPw" maxlength="20" autocomplete="off">
                			</td>
                		</tr>
                		<tr>
                			<td style="border:1px solid black;" width="100">새 비밀번호</td>
                			<td style="border:1px solid black;" width="200">
                				<input type="password" class="inputPwNew" id="inputPwNew" maxlength="20" autocomplete="off">
                			</td>
                			
                		</tr>
                		<tr>
                			<td style="border:1px solid black;" width="100">새 비밀번호 확인</td>
                			<td style="border:1px solid black;" width="200">
                				<input type="password" class="inputPwNewConf" id="inputPwNewConf" maxlength="20" autocomplete="off">
                			</td>
                		</tr>
                	</table>
                </div>
                </form>
            </div>
            <button type="button" style="background-color:blue; display:inline-block; width:100px; height:30px;" onclick="fn_changePwAction();"><p style="color:white;">변경하기</p></button>
        </div>
</body>
<script type="text/javascript">

function fn_changePwAction() {
	var frm = document.changePwForm;
	
	if ($("#inputPw").val() == "" || $("#inputPwNew").val() == "" || $("#inputPwNewConf").val() == "") {
		alert("모든 항목을 입력해 주세요.");
		return;
	}
	
	if ($("#inputPwNew").val() != $("#inputPwNewConf").val()) {
		alert("새 비밀번호와 새 비밀번호 확인에 입력된 정보가 일치하지 않습니다.");
		return;
	}
		
	if ($("#inputPw").val().length < 8 || $("#inputPw").val().length > 20 || $("#inputPwNew").val().length < 8 || $("#inputPwNew").val().length > 20 || $("#inputPwNewConf").val().length < 8 || $("#inputPwNewConf").val().length > 20) {
		alert("비밀번호는 8~20자로 입력해주세요.");
        return;
    }
		
	// rsa 암호화
	var rsa = new RSAKey();
	rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
	    
	$("#userPw").val(rsa.encrypt($("#inputPw").val()));
	$("#userPwNew").val(rsa.encrypt($("#inputPwNew").val()));
	
	$.ajax({
		url: "changePwAction.do",
		type: "post",
		dataType: "json",
		data: {"userPw": $("#userPw").val(), "userPwNew": $("#userPwNew").val()},
		success: function(data) {
			if (data.success) {
				alert(data.changePwSucMsg);
				
				frm.method = "post";
				frm.action = "<c:url value='/main.do'/>"
				frm.submit();
			} else {
				alert(data.changePwFailMsg);
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
<!-- e:container -->

<c:import url="/EgovPageLink.do?link=study/inc/footer" />