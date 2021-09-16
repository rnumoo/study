<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/EgovPageLink.do?link=study/inc/header" />

<!-- s:container -->
        <div> 
            <h1>회원가입</h1>
        </div>
        <div>
            <p>정확한 정보를 입력해주십시오. 타 정보 무단 도용 또는 허위 정보 입력 시 회원가입 승인이 되지 않으며 불이익을 받으실 수 있습니다.</p>
            <div>
            	<form id="joinForm" name="joinForm" method="post">
            	<input type="hidden" id="isIdConf" name="isIdConf" value="N">
            	<input type="hidden" id="userPh" name="userPh" value="">
            	<input type="hidden" id="userMail" name="userMail" value="">
            	<input type="hidden" id="userId" name="userId" value="">
            	<input type="hidden" id="userName" name="userName" value="">
            	<input type="hidden" id="userPw" name="userPw" value="">
            	<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
	  			<input type="hidden" id="RSAExponent" value="${RSAExponent}"/> 
                <div>
                	<table style="border:1px solid black;">
                		<tr>
                			<td style="border:1px solid black;" width="100">아이디</td>
                			<td style="border:1px solid black;" width="200">
                				<input type="text" class="inputId" id="inputId" maxlength="50" autocomplete="off">
                    			<button type="button" style="background-color:blue; display:inline-block; width:100px; height:30px;" onclick="fn_idConfirm();"><p style="color:white;">중복확인</p></button>
                			</td>
                			<td style="border:1px solid black;" width="100">이름</td>
                			<td style="border:1px solid black;" width="200"><input type="text" class="inputName" id="inputName" maxlength="50" autocomplete="off"></td>
                		</tr>
                		<tr>
                			<td style="border:1px solid black;" width="100">비밀번호</td>
                			<td style="border:1px solid black;" width="200">
                				<input type="password" class="inputPw" id="inputPw" maxlength="20" autocomplete="off">
                			</td>
                			<td style="border:1px solid black;" width="100">비밀번호 확인</td>
                			<td style="border:1px solid black;" width="200"><input type="password" class="inputPw" id="inputPwConf" maxlength="20" autocomplete="off"></td>
                		</tr>
                		<tr>
                			<td style="border:1px solid black;" width="100">휴대폰번호</td>
                			<td style="border:1px solid black;" width="200">
                				<input type="text" id="userTelNum" maxlength="11">
                			</td>
                			<td style="border:1px solid black;" width="100">이메일 주소</td>
                			<td style="border:1px solid black;" width="200"><input type="text" class="inputMail" id="inputMail" name="inputMail" maxlength="50" autocomplete="off"></td>
                		</tr>
                	</table>
                </div>
                </form>
            </div>
            <button type="button" style="background-color:blue; display:inline-block; width:100px; height:30px;" onclick="fn_userSignupAction();"><p style="color:white;">가입</p></button>
        </div>

<script type="text/javascript">

$(document).ready(function(){
	$("#userId").change(function() {
		$("#isIdConf").val("N");
	});
});

function fn_userSignupAction() {
	var signupForm = document.joinForm;
	
	if ($("#inputId").val() == "") {
		alert("아이디를 입력해주세요.");
		return;
	}
	
	if ($("#isIdConf").val() != "Y") {
		alert("아이디 중복체크를 해주세요.");
		return;
	}
	
	if ($("#inputName").val() == "") {
		alert("사용자 이름을 입력해주세요.");
		return;
	}
	
	if ($("#inputPw").val() == "" || $("#inputPwConf").val() == "") {
		alert("비밀번호를 입력해주세요.");
		return;
	} else {
		if ($("#inputPw").val() != $("#inputPwConf").val()) {
			alert("비밀번호 확인에 입력된 정보가 입력된 비밀번호와 일치하지 않습니다.");
			return;
		}
		
		if ($("#inputPw").val().length < 8 || $("#inputPw").val().length > 20) {
			alert("비밀번호는 8~20자로 입력해주세요.");
            return;
        }
		
	}
	
	if ($("#userTelNum").val() == "") {
		alert("휴대폰 번호를 입력해주세요.");
		return;
	} else {
		$("#userPh").val($("#userTelNum").val())
	}
	
	if($("#inputMail").val() == "") {
		alert("이메일을 입력해주세요.");
		return;
	} else {
		$("#userMail").val($("#inputMail").val());
	}
	
	// rsa 암호화
    var rsa = new RSAKey();
    rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
    
    $("#userId").val(rsa.encrypt($("#inputId").val()));
    $("#userName").val(rsa.encrypt($("#inputName").val()));
	$("#userPw").val(rsa.encrypt($("#inputPw").val()));
	$("#userPh").val(rsa.encrypt($("#userPh").val()));
	$("#userMail").val(rsa.encrypt($("#userMail").val()));
	
	signupForm.method = "post";
	signupForm.action = "<c:url value='/login/userSignUpAction.do'/>"
	signupForm.submit();
	
}

function fn_idConfirm() {
	var userId = $("#inputId").val();
	
	if (userId == "") {
		alert("아이디를 입력해주세요.");
		return;
	}
	
	$.ajax({
		url: "idConfirm.do",
		type: "post",
		dataType: "json",
		data: {"userId": userId},
		success: function(data) {
			if (data.success) {
				alert("사용할 수 있는 아이디입니다.");
				$("#isIdConf").val("Y");
			} else {
				alert("이미 존재하는 아이디입니다.");
				$("#inputId").val("");
				$("#inputId").focus();
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