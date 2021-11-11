<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="${pageContext.request.contextPath}/js/study/lib/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath}/js/study/lib/didlogin.js"></script>
<script src="${pageContext.request.contextPath}/js/study/lib/jquery.qrcode.min.js"></script>
<script src="${pageContext.request.contextPath}/js/study/lib/jsencrypt.min.js"></script>

<head>
    <title>대구ID Login</title>
</head>
<body>
    <input type="hidden" name="DID" id="DID">
    <input type="hidden" name="Name" id="Name">
    <input type="hidden" name="Gender" id="Gender">
    <input type="hidden" name="BirthDate" id="BirthDate">
    <input type="hidden" name="PhoneNumber" id="PhoneNumber">
    <input type="hidden" name="isForeigner" id="isForeigner">
    <input type="hidden" name="CI" id="CI">
    <div id="qrCodeArea"></div>
</body>
<script type="text/javascript">
	var option = {
	    siteId:"IGai4mkyg1poQFs1O8MzX9W",
	    origin:"*",
	    requiredVC:"DaeguMasterVC",
	    subVC:""
	}
	
	$(document).ready(function(){
	    didLogin.setOption(option);
	    createQrcode();
	    didLogin.callback(window.opener.didLoginAction);

	    //didLogin.callback(function(e){
	    //    var crypt = new JSEncrypt();
	    //    crypt.setPrivateKey("MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJQ/OsXSsd/2ew4j4ixXFAZjt/j/MwKHpzKFLMcjkyP8TOcYs8635wKqjQTxPq5TWG0J7BfpMoylA1UXb7xnqJ/AzoTxT8jwJQ5j+VASACr2Ejx6882soH++kwBpHgxeYg0A4worqMSsW1MfcNuiNcB4FnauUn/0F7cqVJOTKd3hAgMBAAECgYBCE4jDweyskbU5kT7vWoS/cFUA8+atmv8oInnZ7P5ZjMxOORFz8z5RTul6KXkxxE5mk4SbB8MTMz2wALk59c4PbMvMXlNyJKnW8UW2yCS/WGV66Rr9E5BI2AMSbcFbQSlnoKi62brds6DYvN5iXBHPsj2OL0ApXQoucG68kVtgHQJBAPKMrepOyXobY4y3TsGE8ANZDG24vL4jTJq6NwQOVxzvgXFEmC3hus+iBJGkCs22NPNGw7uV98BbiPVKQsLHfPMCQQCcd8wfw2kQbh8pfeWIyMbsMiSuDDjPl+rGSPWyiRHA1SPXMt1qChqxc7pIAz7vS+bfVuLRYNkrVaX6GiAoDJ7bAkEAmWDyvZ+S8t+NBTgJ2oBZUpSmMmBHIqmp0JJ/JdZ3qfmezmTFIwaCnrhi0UJ9/nYBZ/HQ5rfAEukPY6XRL+D8lwJAcFSpHRyjLwKAKL+TrFHITgXpw3JOzuqXyGbUzaoOLsxWAMcpollCtKcK02xRIGbzht/P0tWe07eXgyiCcX4uBQJBANnox/vourI0HFQcSMbnFBwHltaZdENc9ctTH16H2YsC2eUOw6gz6w0ErqnGFwihIvrAEQbbh9Jf15z910+BOag=");
	    	//var dec = crypt.decrypt(e.name);
	    	/*
	    	$("#DID").val(e.did);
	    	$("#BirthDate").val(e.birthdate);
	    	$("#PhoneNumber").val(e.phoneNumber);
	    	$("#Gender").val(e.gender);
	    	$("#CI").val(e.ci);
	    	$("#Name").val(e.name);
	    	$("#isForeigner").val(e.isForeigner);
	    	*/
	    //	window.opener.document.getElementById("DID").value = e;
	    	/*
	    	window.opener.document.getElementById("BirthDate").value = e.birthdate;
	    	window.opener.document.getElementById("PhoneNumber").value = e.phoneNumber;
	    	window.opener.document.getElementById("Gender").value = e.gender;
	    	window.opener.document.getElementById("CI").value = e.ci;
	    	window.opener.document.getElementById("Name").value = e.name;
	    	window.opener.document.getElementById("isForeigner").value = e.isForeigner;
	    	*/
	    //	window.opener.gotoLoginResult();
	    	//opener.location.href = "<c:url value='/login/loginResult.do'/>";
	    //});
	})
	
	function createQrcode(){
		var qrcode = didLogin.getQrData();
		$('#qrCodeArea').qrcode({
			size: 200,
			background: '#fff',
			quiet:1,
			text:qrcode
		});
	}
</script>

