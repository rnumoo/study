<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/EgovPageLink.do?link=study/inc/header" />
<script>

function fn_delete(){
	if (!confirm("삭제하시겠습니까?"))
		return;
	
	document.noticeDetail.action = "<c:url value='/notice/noticeDeleteAction.do'/>";
	document.noticeDetail.submit();	
}

function fn_backToList(){
	
	document.noticeDetail.action = "<c:url value='/notice/noticeList.do'/>";
	document.noticeDetail.submit();	
	
}
function fn_modify(){
	document.noticeDetail.action = "<c:url value='/notice/noticeUpdatePage.do'/>";
	document.noticeDetail.submit();
}

function fn_detail(no) {
	document.noticeDetail.bno.value = no;
	document.noticeDetail.action = "<c:url value='/notice/noticeView.do'/>";
	document.noticeDetail.submit();
}
</script>
<form name="noticeDetail" method="post">
	<input type="hidden" name="bno" value="${resultVO.bno}" />
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
                    <table class="st02">
                        <caption>공지사항을 정렬하였으며 제목, 작성자, 조회, 상단고정, 작성일자, 첨부파일, 내용을 제공합니다.</caption>
                        <colgroup>
                            <col width="7.81%">
                            <col>
                            <col width="7.81%">
                            <col width="26%">
                        </colgroup>
                        
                        <tr>
                            <th>제목</th>
                            <td colspan="3" class="bold">${resultVO.title}</td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td><c:out value="${resultVO.userId}"/></td>
                            <th>조회</th>
                            <td><c:out value="${resultVO.viewCnt}"/></td>
                        </tr>
                        <tr>
                 			<th>상단고정</th>
                            <c:choose>
                            	<c:when test="${resultVO.fix =='0'}">
                            		<td>고정안함</td>
                            	</c:when>
                            	<c:otherwise>
                            		<td>고정</td>
                            	</c:otherwise>
                            </c:choose>
                            <th>작성일자</th>
                            <td><c:out value="${resultVO.regDate}"/></td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td colspan="4" class="table_text"><c:out value="${resultVO.content}"/></td>
                        </tr>
                    </table>
                    
                  <div class="tableBtn_area">
                        <div class="leftBtn">
                            <a href="#LINK" class="btn10 btn_grey_line" onclick="fn_backToList()">목록</a>
                        </div>
                        <div class="rightBtn">
                            <button class="btn10 btn_red_line" onclick="fn_delete()">삭제</button>
                            <button class="btn10 btn_black3" onclick="fn_modify()"> 수정</button>
                        </div>
                    </div>
                    
                    <table class="remote_table">
                        <colgroup>
                            <col width="7.812%">
                            <col>
                        </colgroup>
                        <tr>
                            <th>다음글</th>
                            <td>
                                <c:choose>
                                    <c:when test="${empty next.title}">
                                         <a href="#LINK">다음글이 없습니다</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="#LINK" onclick="fn_detail('${next.bno}')"><c:out value="${next.title}"/></a>    
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>이전글</th>
                            <td>
                                <c:choose>
                                    <c:when test="${empty pre.title}">
                                         <a href="#LINK">이전글이 없습니다</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="#LINK" onclick="fn_detail('${pre.bno}')"><c:out value="${pre.title}"/></a>    
                                    </c:otherwise>
                                </c:choose>
                            </td>       
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!-- e:container -->
</form>

<c:import url="/EgovPageLink.do?link=study/inc/footer" />