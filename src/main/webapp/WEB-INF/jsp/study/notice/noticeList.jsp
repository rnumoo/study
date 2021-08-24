<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/EgovPageLink.do?link=study/inc/header" />

<script>
	<%-- 글 목록 페이지에서 한페이지에 보여질 글 갯수 변경하거나 검색, 페이지 이동으로 인한 변경사항이 있을 때 --%>
	function fn_egov_select_List(pageNo) {
		document.noticeList.pageIndex.value = pageNo;
		document.noticeList.action = "<c:url value='/notice/noticeList.do'/>";
		document.noticeList.submit();
	}
	
	<%-- 글 내용 확인하기 위해 클릭했을 때 --%>
	function fn_detail(no) {
		document.noticeList.bno.value = no;
		document.noticeList.action = "<c:url value='/notice/noticeView.do'/>";
		document.noticeList.submit();
	}
	
	<%-- 검색어 초기화 버튼 클릭 시 --%>
	function fn_reset_searchWrd(){
		document.noticeList.searchCnd1.value = 0;
		document.noticeList.searchWrd.value = "";
	}
</script>

<form name="noticeList" method="post">
	<%-- pagiIndex --%>
	<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}" />
	<%-- bno --%>
	<input type="hidden" name="bno" />

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
						<p>
							전체 <b>${paginationInfo.totalRecordCount}</b>개
						</p>
						<select name="recordCountPerPage" onchange="fn_egov_select_List('1')" class="selectText width80">
							<option value="10"
								<c:out value="${paginationInfo.recordCountPerPage == 10 ? 'selected' : ''}"/>>10</option>
							<option value="20"
								<c:out value="${paginationInfo.recordCountPerPage == 20 ? 'selected' : ''}"/>>20</option>
							<option value="40"
								<c:out value="${paginationInfo.recordCountPerPage == 40 ? 'selected' : ''}"/>>40</option>
							<option value="60"
								<c:out value="${paginationInfo.recordCountPerPage == 60 ? 'selected' : ''}"/>>60</option>
							<option value="100"
								<c:out value="${paginationInfo.recordCountPerPage == 100 ? 'selected' : ''}"/>>100</option>
						</select> <span>개씩 보기</span>
					</div>
					<div class="table_search">
						<select name="searchCnd1">
							<option value="0">전체</option>
							<option value="1">제목</option>
							<option value="2">내용</option>
						</select>
						<div class="search_box">
							<input type="text" name="searchWrd" value="<c:out value="${searchVO.searchWrd}"/>" placeholder="검색어를 입력하세요.">
							<a href="#LINK"><img src="${pageContext.request.contextPath}/images/study/ico_search.png"
								alt="검색하기" onclick="fn_egov_select_List('1')"></a>
						</div>
						<button class="btn06 btn_grey2 search_reset" onclick="fn_reset_searchWrd()">초기화</button>
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
						<c:forEach items="${fix}" var="resultList" varStatus="status">
							<tr class="notice_top">
								<td><span>공지</span></td>
								<td><a href="#LINK" onclick="fn_detail('${resultList.bno}')"><c:out value="${resultList.title}" /></a></td>
								<td></td>
								<td><c:out value="${resultList.userId}" /></td>
								<td><c:out value="${resultList.regDate}" /></td>
								<td><c:out value="${resultList.viewCnt}" /></td>
							</tr>
						</c:forEach>
						<c:forEach items="${list}" var="resultList" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.index) }" /></td>
								<td><a href="#LINK" onclick="fn_detail('${resultList.bno}')"><c:out value="${resultList.title}" /></a></td>
								<td></td>
								<td><c:out value="${resultList.userId}" /></td>
								<td><c:out value="${resultList.regDate}" /></td>
								<td><c:out value="${resultList.viewCnt}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div class="page">
					<ui:pagination paginationInfo="${paginationInfo}" jsFunction="fn_egov_select_List" />
		        	<button class="add" onclick="location.href='<c:url value="/notice/noticeWritePage.do"/>'" type="button">등록</button>
				</div>
			</div>
		</div>
	</div>
	<!-- e:container -->
</form>
<c:import url="/EgovPageLink.do?link=study/inc/footer" />