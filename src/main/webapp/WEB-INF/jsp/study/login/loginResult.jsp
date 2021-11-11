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
    <div>
        <table style="border:1px solid black;">
            <tr>
                <td style="border:1px solid black;" width="100">DID</td>
                <td style="border:1px solid black;" width="800">
                	<input type="text" id="DID" name="DID" style="width:100%;" value="${didLoginVO.getDID() }" readonly>
                </td>
                <td style="border:1px solid black;" width="100">Name</td>
                <td style="border:1px solid black;" width="200">
                    <input type="text" id="Name" name="Name" style="width:100%;" value="${didLoginVO.getName() }" readonly>
                </td>
           </tr>
           <tr>
                <td style="border:1px solid black;" width="100">Gender</td>
                <td style="border:1px solid black;" width="200">
                	<input type="text" id="Gender" name="Gender" style="width:100%;" value="${didLoginVO.getGender() }" readonly>
                </td>
                <td style="border:1px solid black;" width="100">BirthDate</td>
                <td style="border:1px solid black;" width="200">
                    <input type="text" id="BirthDate" name="BirthDate" style="width:100%;" value="${didLoginVO.getBirthDate() }" readonly>
                </td>
           </tr>
           <tr>
                <td style="border:1px solid black;" width="100">PhoneNumber</td>
                <td style="border:1px solid black;" width="200">
                	<input type="text" id="PhoneNumber" name="PhoneNumber" style="width:100%;" value="${didLoginVO.getPhoneNumber() }" readonly>
                </td>
                <td style="border:1px solid black;" width="100">isForeigner</td>
                <td style="border:1px solid black;" width="200">
                    <input type="text" id="isForeigner" name="isForeigner" style="width:100%;" value="${didLoginVO.getIsForeigner() }" readonly>
                </td>
           </tr>
           <tr>
                <td style="border:1px solid black;" width="100">CI</td>
                <td style="border:1px solid black;" width="800">
                    <input type="text" id="CI" name="CI" style="width:100%;" value="${didLoginVO.getCI() }" readonly>
                </td>
           </tr>
           <tr>
                <td><button type="button" onclick="fn_gotoNoticeList();" style="background-color:gray;"><p style="color:white;">게시판</p></button></td>
           </tr>
        </table>
    </div>
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
	    didLogin.callback(function(e){
	        var crypt = new JSEncrypt();
	        crypt.setPrivateKey("MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJQ/OsXSsd/2ew4j4ixXFAZjt/j/MwKHpzKFLMcjkyP8TOcYs8635wKqjQTxPq5TWG0J7BfpMoylA1UXb7xnqJ/AzoTxT8jwJQ5j+VASACr2Ejx6882soH++kwBpHgxeYg0A4worqMSsW1MfcNuiNcB4FnauUn/0F7cqVJOTKd3hAgMBAAECgYBCE4jDweyskbU5kT7vWoS/cFUA8+atmv8oInnZ7P5ZjMxOORFz8z5RTul6KXkxxE5mk4SbB8MTMz2wALk59c4PbMvMXlNyJKnW8UW2yCS/WGV66Rr9E5BI2AMSbcFbQSlnoKi62brds6DYvN5iXBHPsj2OL0ApXQoucG68kVtgHQJBAPKMrepOyXobY4y3TsGE8ANZDG24vL4jTJq6NwQOVxzvgXFEmC3hus+iBJGkCs22NPNGw7uV98BbiPVKQsLHfPMCQQCcd8wfw2kQbh8pfeWIyMbsMiSuDDjPl+rGSPWyiRHA1SPXMt1qChqxc7pIAz7vS+bfVuLRYNkrVaX6GiAoDJ7bAkEAmWDyvZ+S8t+NBTgJ2oBZUpSmMmBHIqmp0JJ/JdZ3qfmezmTFIwaCnrhi0UJ9/nYBZ/HQ5rfAEukPY6XRL+D8lwJAcFSpHRyjLwKAKL+TrFHITgXpw3JOzuqXyGbUzaoOLsxWAMcpollCtKcK02xRIGbzht/P0tWe07eXgyiCcX4uBQJBANnox/vourI0HFQcSMbnFBwHltaZdENc9ctTH16H2YsC2eUOw6gz6w0ErqnGFwihIvrAEQbbh9Jf15z910+BOag=");
	    	//var dec = crypt.decrypt(e.name);
	    	opener.location.href = "<c:url value='/login/loginResult.do'/>";
	    });
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
	
	function fn_gotoNoticeList() {
	    location.href = "<c:url value='/notice/noticeList.do'/>";
	}
</script>

