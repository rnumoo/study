<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">

    <head>
        
        <!-- css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/study/global.css">

        
        <!-- js :: lib -->
        <script src="${pageContext.request.contextPath}/js/study/jquery-1.11.3.min.js"></script>


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
                        <li><a href="#LINK">회원가입</a></li>
                        <li><a href="#LINK">로그인</a></li>
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



        <!-- s:container -->
        <div class="container">
            <div class="inner">
                <ul class="sub_nav">
                    <li>홈</li>
                    <li>알림마당</li>
                    <li>공지사항</li>
                </ul>
                
                <div class="titleBox"> 
                    <h1>공지사항</h1>
                </div>
                <div class="table_wrap">
                    <div class="search_area">
                        <div class="table_count">
                            <p>전체 <b>180</b>개</p>
                            <select>
                                <option>10</option>
                            </select>
                            <span>개씩 보기</span>
                        </div>
                        <div class="table_search">
                            <select class="select2">
                                <option>전체</option>
                            </select>
                            <div class="search_box"><input type="text" placeholder="검색어를 입력하세요."><a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/ico_search.png" alt="검색하기"></a></div>
                            <button class="btn06 btn_grey2 search_reset">초기화</button>
                        </div>
                    </div>
                    <table class="st03 notice_list">
                        <caption>공지사항 목록을 정렬하였으며 번호, 제목, 첨부파일, 작성자, 작성일자, 조회를 제공합니다.</caption>
                        <colgroup>
                            <col width="5%">
                            <col>
                            <col width="6.43%">
                            <col width="8.125%">
                            <col width="9.375%">
                            <col width="5%">
                        </colgroup>
                        
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>첨부파일</th>
                                <th>작성자</th>
                                <th>작성일자</th>
                                <th>조회</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="notice_top">
                                <td><span>공지</span></td>
                                <td><a href="#LINK">산업부, 2022년 탄소중립 R&amp;D 확대 편성 추진</a></td>
                                <td><img src="${pageContext.request.contextPath}/images/study/ico_list_file.png"></td>
                                <td>관리자</td>
                                <td>2021-07-01</td>
                                <td>0000</td>
                            </tr>
                            <tr class="notice_top">
                                <td><span>공지</span></td>
                                <td><a href="#LINK">산업부, 2022년 탄소중립 R&amp;D 확대 편성 추진</a></td>
                                <td><img src="${pageContext.request.contextPath}/images/study/ico_list_file.png"></td>
                                <td>관리자</td>
                                <td>2021-07-01</td>
                                <td>0000</td>
                            </tr>
                            <tr>
                                <td>0000</td>
                                <td><a href="#LINK">산업부, 2022년 탄소중립 R&amp;D 확대 편성 추진</a></td>
                                <td></td>
                                <td>관리자</td>
                                <td>2021-07-01</td>
                                <td>0000</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><a href="#LINK">산업부, 2022년 탄소중립 R&amp;D 확대 편성 추진</a></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <div class="page">
                        <div>
                            <a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/ago_prev.png" alt="처음으로"></a>
                            <a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/prev.png" alt="이전"></a>
                        </div>
                        <div>
                            <a href="#LINK" class="on">1</a>
                            <a href="#LINK">2</a>
                        </div>
                        <div>
                            <a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/next.png" alt="다음"></a>
                            <a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/ago_next.png" alt="마지막으로"></a>
                        </div>
                        <button class="add">등록</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- e:container -->



        <!-- s:footer -->
        <footer class="footer">
            <div class="footer_top">
                <div class="inner">
                    <div class="footer_Logo">
                        <a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/logo_motie.png" alt="산업통상자원부 로고"></a>
                        <a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/logo_kicox.png" alt="한국산업단지공단 로고"></a>
                        <a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/logo_gb.png" alt="새바람 행복경북 로고"></a>
                        <a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/logo_gumi.png" alt="예스구미 로고"></a>
                    </div>
                    <div class="footer_select">
                        <select class="W275">
                            <option>산하센터</option>
                        </select>
                        <select class="W200">
                            <option>유관기관</option>
                        </select>
                        <select class="W185">
                            <option>주요사이트 바로가기</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="footer_bot">
                <div class="inner">
                    <div class="footer_adress">
                        <img src="${pageContext.request.contextPath}/images/study/footer_logo.png" alt="구미전자정보기술원 로고">
                        <address>[39171] 경북 구미시 산동읍 첨단기업1로 17 구미전자정보기술원  <span>ㅣ</span>  대표전화T.054-479-2002  <span>ㅣ</span>  장비지원T.054-479-2176</address>
                        <p>Copyright 2018. Gumi Electronics &amp; Information Technology Research Institute. All Rights Reserved.</p>
                    </div>
                    <div class="footer_link">
                        <ul>
                            <li><a href="#LINK">이용약관</a></li>
                            <li><a href="#LINK"><b>개인정보처리방침</b></a></li>
                            <li><a href="#LINK">개인정보 수집 및 이용동의</a></li>
                            <li><a href="#LINK">이메일 무단수집 거부</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
        <!-- e:footer -->
        
    </body>
</html>