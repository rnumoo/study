<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/EgovPageLink.do?link=study/inc/header" />
<script>

function fn_save(){
	var url = "";
	
	if("${flag}" == "write"){
		url = "<c:url value='/notice/noticeWriteAction.do'/>"
	}else{
		url = "<c:url value='/notice/noticeUpdateAction.do'/>"
	}

	if(!validation()){
		return;
	}
	
	if(!confirm("저장하시겠습니까?")){
		return;
	}
	
	document.frm.action = url;
	document.frm.submit();
}

function validation(){
	
	if(document.frm.title.value == ""){
		alert("제목을 입력해주세요.");
		document.frm.title.focus();
		return;
	}
	
	if(document.frm.content.value == ""){
		alert("내용을 입력해주세요.");
		document.frm.content.focus();
		return;
	}
	
	if(document.frm.userId.value == ""){
		alert("작성자를 입력해주세요.");
		document.frm.userId.focus();
		return;
	}

	return true;
}

function fn_cancel(){
	if (!confirm("저장되지 않은 데이터는 지워집니다. 계속하시겠습니까?"))
		return;
	var url = "<c:url value='/notice/noticeList.do'/>";	
		
	document.frm.action = url;
	document.frm.submit();	
}
function fn_checked(obj){
	var checked = obj.checked;
	if(checked) {
		obj.value = "1";
	} else {
		obj.value = "0";
	}
} 
</script>
<form name="frm" method="post" enctype="multipart/form-data" action="<c:url value='/notice/noticeWriteAction.do'/>">
	<input type="hidden" name="returnUrl" value="<c:url value='/notice/noticeWriteAction.do'/>"/>
	<input type="hidden" name="atchPosblFileNumber" id="atchPosblFileNumber" value="3" />
	<c:if test="${flag eq 'update' }"><input type="hidden" name="bno" value="${resultVO.bno}"/></c:if> 
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
                        <caption>협의체 네트워킹을 정렬하였으며 제목, 협의체, 작성자, 첨부파일, 내용을 제공합니다.</caption>
                        <colgroup>
                            <col width="7.81%">
                            <col>
                            <col width="7.81%">
                            <col width="18.25%">
                        </colgroup>
                        
                        <tr>
                            <th>제목</th>
                            <td colspan="3">
                                <input type="text" class="inputW1000" name="title" value="<c:out value="${resultVO.title}"/>">
                            </td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td>
                                <input type="text" name="userId" value="<c:out value="${resultVO.userId}"/>">
                            </td>
                            <th>상단고정</th>
                            <td>
                            	<c:choose>
                            		<c:when test="${resultVO.fix eq '1'}">
                            			<input type="checkbox" id="fix" name="fix" onchange="fn_checked(this)" checked>
		                                <label for="fix"></label>
                            		</c:when>
                            		<c:otherwise>
		                                <input type="checkbox" id="fix" name="fix" onchange="fn_checked(this)" >
		                                <label for="fix"></label>
	                                </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td colspan="3" class="file">
								<c:if test="${not empty resultVO.atchFileId}">
									<c:import charEncoding="utf-8" url="/cmm/fms/selectFileInfsForUpdate.do" >
										<c:param name="param_atchFileId" value="${resultVO.atchFileId}" />
									</c:import>		
								</c:if>
								<c:if test="${resultVO.atchFileId == ''}">
									<input type="hidden" name="fileListCnt" value="" />
								</c:if>
								<div>
									<div>
										<input name="file_1" id="egovComFileUploader" type="file" multiple />
									</div>
								</div>
                            </td>
                        </tr>
                        <tr>
                        	<td colspan="3">
                        	<div id="egovComFileList"></div>
                        	</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="table_text"><textarea name="content"><c:out value="${resultVO.content}"/></textarea></td>
                        </tr>
                    </table>
                    
                    <div class="tableBtn_area">
                        <div class="leftBtn">
                            <button class="btn10 btn_grey_line" onclick="fn_cancel();" type="button">취소</button>
                        </div>
                        <div class="rightBtn">
                            <button class="btn10 btn_blue" onclick="fn_save();" type="button">등록</button>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
        <!-- e:container -->
</form>

<script src="${pageContext.request.contextPath}/js/egovframework/com/cmm/fms/EgovMultiFile.js"></script>

<script >

var maxFileNum = document.frm.atchPosblFileNumber.value;
if(maxFileNum == null || maxFileNum == "") {
	maxFileNum = 3;
}
var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum);
multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );

</script>

<c:import url="/EgovPageLink.do?link=study/inc/footer" />