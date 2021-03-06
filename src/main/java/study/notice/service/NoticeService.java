package study.notice.service;

import java.util.List;

import egovframework.com.cmm.service.FileVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface NoticeService {
	
	//고정되지 않은 글 리스트 조회
	public List<?> selectNoticeList(SearchVO searchVO)throws Exception;
	
	//고정된 글 리스트 조회
	public List<?> selectNoticeListFix(SearchVO searchVO)throws Exception;
	
	//글 갯수 조회
	public int selectNoticeCnt(SearchVO searchVO)throws Exception;
	
	//작성한 글을 db에 insert
	public void noticeWriteAction(NoticeVO noticeVO)throws Exception;
	
	//글 내용 조회
	//public EgovMap selectNoticeDetail(NoticeVO noticeVO)throws Exception;
	public EgovMap selectNoticeDetail(NoticeVO noticeVO)throws Exception;
	
	//수정한 글을 db에 업데이트
	public void noticeUpdateAction(NoticeVO noticeVO, List<FileVO> listDelFileVO)throws Exception;
	
	//글 삭제
	public void noticeDeleteAction(NoticeVO noticeVO)throws Exception;
	
	public List<FileVO> selectFileInfs(FileVO fileVO) throws Exception;
	
}
