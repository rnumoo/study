<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">

<head>
    <!-- <meta http-equiv="imagetoolbar" content="no"> -->
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title></title>

    <!-- css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/study/global.css">

    <!-- js :: lib -->
    <script src="${pageContext.request.contextPath}/js/study/lib/jquery-1.11.3.min.js"></script>

    <!-- js -->
    <script src="${pageContext.request.contextPath}/js/study/gnb.js"></script>
    <script src="${pageContext.request.contextPath}/js/study/design.js"></script>

</head>

<body>
<!-- s:header -->
<header class="header">
    <div class="skip">
        <a href="#LINK">본문 바로가기</a>
    </div>

    <div class="inner">
        <a href="#LINK" class="logo"><img src="${pageContext.request.contextPath}/images/study/logo.png" alt="구미전자정보기술원 구미형 소재·부품 융합얼라이언스 로고"></a>
        <div class="gnb_area">
            <ul class="submenu">
            	<c:if test="${ not empty userLoginVO || not empty didLoginVO}">
            		<li><a href="<c:url value="/login/changePw.do"/>">비밀번호 변경</a></li>
            		<li><a href="<c:url value="/login/logout.do"/>">로그아웃</a></li>
            	</c:if>
            	<c:if test="${ empty userLoginVO && empty didLoginVO }">
            		<li><a href="<c:url value="/login/userSignUp.do"/>">회원가입</a></li>
                	<li><a href="<c:url value="/login/login.do"/>">로그인</a></li>
            	</c:if>
            </ul>
            <div class="gnb_box">
                <ul class="gnb">
                    <li><a href="#LINK">융합얼라이언스</a>
                        <ul class="lnb">
                            <li><a href="#LINK">미래유망산업소개</a></li>
                            <li><a href="#LINK">시험분석 코디네이팅</a></li>
                        </ul>
                    </li>
                    <li><a href="#LINK">협의체</a>
                        <ul class="lnb">
                            <li><a href="#LINK">협의체소개</a></li>
                            <li><a href="#LINK">협의체 네트워킹</a></li>
                        </ul>
                    </li>
                    <li><a href="#LINK">기업지원</a>
                        <ul class="lnb">
                            <li><a href="#LINK">사업공고</a></li>
                            <li><a href="#LINK">행사안내</a></li>
                            <li><a href="#LINK">기술이전</a></li>
                            <li><a href="#LINK">개방형 혁신랩</a></li>
                        </ul>
                    </li>
                    <li><a href="#LINK">공동활용장비</a>
                        <ul class="lnb">
                            <li><a href="#LINK">장비검색/예약</a></li>
                            <li><a href="#LINK">장비이용안내</a></li>
                            <li><a href="#LINK">담당자안내</a></li>
                            <li><a href="#LINK">성적서 진위여부 확인</a></li>
                        </ul>
                    </li>
                    <li><a href="#LINK">알림마당</a>
                        <ul class="lnb">
                            <li><a href="#LINK">공지사항</a></li>
                            <li><a href="#LINK">홍보자료</a></li>
                            <li><a href="#LINK">FAQ</a></li>
                        </ul>
                    </li>
                    <li><a href="#LINK">마이페이지</a>
                        <ul class="lnb">
                            <li><a href="#LINK">회원정보</a></li>
                            <li><a href="#LINK">기관/기업정보</a></li>
                            <li><a href="#LINK">관심장비</a></li>
                            <li><a href="#LINK">장비예약정보</a></li>
                            <li><a href="#LINK">장비결제정보</a></li>
                            <li><a href="#LINK">행사예약정보</a></li>
                            <li><a href="#LINK">기술이전상담내역</a></li>
                            <li><a href="#LINK">혁신랩예약정보</a></li>
                        </ul>
                    </li>
                </ul>

                <button type="button" class="ham_sitemap"><img src="${pageContext.request.contextPath}/images/study/btn_ham.png" alt="사이트맵버튼"></button>
            </div>
        </div>
    </div>
</header>
<!-- e:header -->
