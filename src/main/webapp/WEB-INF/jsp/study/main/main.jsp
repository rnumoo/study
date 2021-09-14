<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/EgovPageLink.do?link=study/inc/header" />    
main page
<a href="<c:url value="/notice/noticeList.do"/>">게시판</a>
<c:import url="/EgovPageLink.do?link=study/inc/footer" />