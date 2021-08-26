package study.notice.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import study.notice.service.NoticeService;
import study.notice.service.NoticeVO;
import study.notice.service.SearchVO;

//이 클래스가 컨트롤러임을 나타내는 어노테이션
@Controller
//value 값의 요청에 대해 어떤 컨트롤러나 메서드가 처리될지를 맵핑하기 위한 어노테이션
@RequestMapping(value = "/notice/")		
public class NoticeController {
	
	//name에 해당하는 bean의 이름을 검색해서 의존성 주입
	@Resource(name = "noticeService")		
    private NoticeService noticeService;
	
	@Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	// 공지사항 리스트
	@RequestMapping(value = "noticeList.do")
	public String noticeList(@ModelAttribute("searchVO") SearchVO searchVO, Model model) throws Exception {
		
		//페이징 처리를 위한 데이터들을 담고 있는 클래스
        PaginationInfo paginationInfo = new PaginationInfo();
        
        //아래 네개의 변수들은 컨트롤러에서 직접 해당 setter에 값을 넣어줘야 한다.
        paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(searchVO.getRecordCountPerPage());
        paginationInfo.setPageSize(searchVO.getPageSize());
        int totalCnt = noticeService.selectNoticeCnt(searchVO);
        paginationInfo.setTotalRecordCount(totalCnt);
        
        //dao로 전달해서 mybatis에서 사용하기 위해 set(출력할 행의 시작 번호, 0부터 시작, 페이징 sql 조건절에 사용)
        searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        
        //List 자료형의 listData라는 이름의 변수에 noticeService의 selectNoticeList의 결과를 대입(noticeService 라는 이름의 @Service annotation 이 있는 클래스 찾아 감)
        List<?> listData = noticeService.selectNoticeList(searchVO);
        List<?> fix = noticeService.selectNoticeListFix(searchVO);
        
        model.addAttribute("fix", fix);		//"fix" 라는 키값으로 fix라는 이름의 List를 뷰에서 사용할 수 있게 함.
        model.addAttribute("list", listData);
        model.addAttribute("paginationInfo", paginationInfo);

		return "/study/notice/noticeList";
	}
	
	// 공지사항 상세보기
    @RequestMapping(value = "noticeView.do")
    public String noticeView(@ModelAttribute("noticeVO") NoticeVO noticeVO, @ModelAttribute("searchVO") SearchVO searchVO, Model model) throws Exception {

        EgovMap resultVO = noticeService.selectNoticeDetail(noticeVO);
        
        model.addAttribute("resultVO", resultVO.get("noticeDetail"));
        model.addAttribute("pre", resultVO.get("noticeDetailPre"));
        model.addAttribute("next", resultVO.get("noticeDetailNext"));

        return "study/notice/noticeView";
    }

    // 공지사항 글 작성 페이지
    @RequestMapping(value = "noticeWritePage.do")
    public String noticeWrite(@ModelAttribute("noticeVO") NoticeVO noticeVO, Model model) throws Exception {
        
    	model.addAttribute("flag", "write");
    	
        return "study/notice/noticeWrite";
    }

    // 공지사항 글 등록
    @RequestMapping(value = "noticeWriteAction.do")
    public String noticeInsert(@ModelAttribute("noticeVO") NoticeVO noticeVO, final MultipartHttpServletRequest multiRequest, Model model) throws Exception {
        
    	//multiRequest의 파라미터명을 키로, 파일 객체를 value로 하는 map(key : file_0, value : 파일네임...)
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();

        String atchFileId = "";

        if (!files.isEmpty()) {
        	//parseFileInf : 파일객체, 구분값, 파일순번, 파일id, 저장경로.
        	//파일id가 빈 문자열 또는 null일 때 IDGenerationService를 통해서 신규로 생성.
        	//파일순번의 경우 최초 등록시에는 0을 세팅.
        	//구분 값은 실제 파일이 물리적인 저장위치에 변경된 이름으로 저장될 때 해당 파일이름 생성시에 사용. 생성규칙은 “구분 값”+“yyyyMMddhhmmssSSS형태의 TimeStamp값”+“파일 키”
            List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
            //생성된 첨부파일의 id를 리턴
            atchFileId = fileMngService.insertFileInfs(result);
            noticeVO.setAtchFileId(atchFileId);
        }
    	
    	noticeService.noticeWriteAction(noticeVO);
        
    	return "redirect:/notice/noticeList.do";
    }

    // 공지사항 글 수정 페이지

    @RequestMapping(value = "noticeUpdatePage.do")
    public String noticeModify(@ModelAttribute("noticeVO") NoticeVO noticeVO, Model model) throws Exception {
    	
    	EgovMap resultVO = noticeService.selectNoticeDetail(noticeVO);
    	
        model.addAttribute("flag", "update");
        model.addAttribute("resultVO", resultVO.get("noticeDetail"));

        return "study/notice/noticeWrite";
    }

    // 공지사항 글 수정

    @RequestMapping(value = "noticeUpdateAction.do")
    public String noticeUpdate(@ModelAttribute("noticeVO") NoticeVO noticeVO, @ModelAttribute("searchVO") SearchVO searchVO, final MultipartHttpServletRequest multiRequest, Model model) throws Exception {
        
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();

        String atchFileId = noticeVO.getAtchFileId();

        if (!files.isEmpty()) {
            if ("".equals(atchFileId) || atchFileId == null) {
                List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
                atchFileId = fileMngService.insertFileInfs(result);
                noticeVO.setAtchFileId(atchFileId);
            } else {
                FileVO fvo = new FileVO();
                //최종 파일 순번을 획득하기 위해 VO에 현재 첨부파일 id를 세팅
                fvo.setAtchFileId(atchFileId);
                //해당 첨부파일 id에 속하는 최종 파일 순번을 획득
                int cnt = fileMngService.getMaxFileSN(fvo);
                List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
                fileMngService.updateFileInfs(_result);
            }
        }
        
    	noticeService.noticeUpdateAction(noticeVO);

        return "redirect:/notice/noticeList.do";
    }

    // 공지사항 글 삭제
    @RequestMapping("noticeDeleteAction.do")
    public String noticeDelete(@ModelAttribute("noticeVO") NoticeVO noticeVO, HttpServletRequest request, Model model) throws Exception {

        noticeService.noticeDeleteAction(noticeVO);
        
        return "redirect:/notice/noticeList.do";
    }

}
