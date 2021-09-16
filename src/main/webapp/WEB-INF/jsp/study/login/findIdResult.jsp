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
        <div>*가입하신 아이디는 아래와 같습니다.</div>
        <div>
        	<form id="findIdResultForm" name="findIdResultForm" method="post">
        	<input type="hidden" id="userId" name="userId" value="${loginVO.userId}">
	  		<table>
	  			<tr>
	  				<td width="100">아이디</td>
	  				<td width="200"><c:out value="${loginVO.userId}"/></td>
	  			</tr>
	  		</table>
        	</form>
            <div>
            	<table width="300">
            		<tr>
            			<td><button type="button" style="background-color:gray;" onclick="window.close();"><p style="color:white;">닫기</p></button></td>
            		</tr>
            	</table>
            </div>
        </div>
<!-- e:container -->

<script src="${pageContext.request.contextPath}/js/study/rsa/rsa.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/jsbn.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/prng4.js"></script>
<script src="${pageContext.request.contextPath}/js/study/rsa/rng.js"></script>

