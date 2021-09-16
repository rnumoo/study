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
            <h1>로그인</h1>
            <p>시스템 이용을 위해 로그인 하시기 바랍니다.</p>
        </div>
        <div>
        	<form id="loginForm" name="loginForm" method="post">
        	<input type="hidden" id="userId" name="userId" value="">
        	<input type="hidden" id="userPw" name="userPw" value="">
        	<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
	  		<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
	  		<table>
	  			<tr>
	  				<td width="100">아이디</td>
	  				<td width="200"><input type="text" id="inputId" name="inputId"></td>
	  				<td width="100" rowspan="2" ><button type="button" style="background-color:blue;" onclick="fn_loginAction();"><p style="color:white;">로그인</p></button></td>
	  			</tr>
	  			<tr>
	  				<td width="100">비밀번호</td>
	  				<td width="200"><input type="password" id="inputPwd" name="inputPwd"></td>
	  			</tr>
	  			<tr>
	  				<td colspan="2"><input type="checkbox" id="id_remember">
            		<label for="id_remember">로그인 정보 기억하기</label></td>
	  			</tr>
	  		</table>
        	</form>
            <div>
            	<table>
            		<tr>
            			<td width="300">회원가입 후 이용이 가능합니다.</td>
            			<td><a href="<c:url value="/login/userSignUp.do"/>"><button type="button" style="background-color:gray;"><p style="color:white;">회원가입</p></button></a></td>
            		</tr>
            		<tr>
            			<td>시스템 이용 문의사항 (T)053-000-0000</td>
            			<td><button type="button" onclick="fn_findIdPw();" style="background-color:gray;"><p style="color:white;">아이디/비밀번호 찾기</p></button></td>
            		</tr>
            	</table>
            </div>
        </div>
<!-- e:container -->

<script type="text/javascript">

function fn_loginAction() {
	var frm = document.loginForm;
	
	if (frm.inputId.value == "") {
		alert("아이디를 입력해주세요.");
		return;
	}
	
	if (frm.inputPwd.value == "") {
		alert("비밀번호를 입력해주세요.");
		 return;
	}
	
	// rsa 암호화
    var rsa = new RSAKey();
    rsa.setPublic($("#RSAModulus").val(),$("#RSAExponent").val());
    
	$("#userId").val(rsa.encrypt($("#inputId").val()));
	$("#userPw").val(rsa.encrypt($("#inputPwd").val()));
	$("#inputPwd").val("");
	
	var userId = $("#userId").val();
	var userPw = $("#userPw").val();
	
	$.ajax({
		url: "loginAction.do",
		type: "post",
		dataType: "json",
		data: {"userId": userId, "userPw": userPw},
		success: function(data) {
			if (data.success) {
				alert("로그인 성공");
				
				frm.method = "post";
				frm.action = "<c:url value='/main.do'/>"
				frm.submit();
			} else {
				alert(data.loginFailMsg);
			}
		},
		error: function(request, status, error){
			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n"+"error: " + error);
		}
	});
}

function fn_findIdPw(){
var frm = document.loginForm;
	
	window.open("findId.do", "findId", "width=500, height=500, left=600, top=200");
}

</script>

<script src="${pageContext.request.contextPath}/js/study/rsa/rsa.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/jsbn.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/prng4.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/rng.js"></script>

