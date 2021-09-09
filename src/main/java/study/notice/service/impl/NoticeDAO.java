package study.notice.service.impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import study.notice.service.NoticeVO;
import study.notice.service.SearchVO;

//@Repository : db에 접근하는 클래스임을 나타내는 어노테이션(db에 접근하는 코드가 모여있다.)
@Repository("noticeDAO")
public class NoticeDAO extends EgovComAbstractDAO{
	
	public List<?> selectNoticeList(SearchVO searchVO) throws Exception {
		//myBatis에서 noticeDAO.selectNoticeList id를 찾아 searchVO에 세팅 후 resultType에 지정된 형태로 return
		return selectList("noticeDAO.selectNoticeList", searchVO);
	}
	
	public List<?> selectNoticeListFix(SearchVO searchVO) throws Exception {
		return selectList("noticeDAO.selectNoticeListFix", searchVO);
	}
	
	public void noticeWriteAction(NoticeVO noticeVO)throws Exception{
		insert("noticeDAO.noticeWriteAction", noticeVO);
	}
	
	public int selectNoticeCnt(SearchVO searchVO) throws Exception {
		return (Integer) selectOne("noticeDAO.selectNoticeCnt", searchVO);
	}
	
	public EgovMap selectNoticeDetail(NoticeVO noticeVO) throws Exception {
		return selectOne("noticeDAO.selectNoticeDetail", noticeVO);
	}
	
	public void noticeUpdateAction(NoticeVO noticeVO)throws Exception{
		update("noticeDAO.noticeUpdateAction", noticeVO);
	}
	
	public void noticeDeleteAction(NoticeVO noticeVO)throws Exception{
		delete("noticeDAO.noticeDeleteAction", noticeVO);
	}
	
	public void noticeViewCount(NoticeVO noticeVO)throws Exception{
		update("noticeDAO.noticeViewCount", noticeVO);
	}
	
	public EgovMap selectNoticeDetailNext(NoticeVO noticeVO) throws Exception {
		return selectOne("noticeDAO.selectNoticeDetailNext", noticeVO);
	}
	
	public EgovMap selectNoticeDetailPre(NoticeVO noticeVO) throws Exception {
		return selectOne("noticeDAO.selectNoticeDetailPre", noticeVO);
	}
	
	public List<FileVO> selectFileInfs(FileVO fileVO) throws Exception {
		return (List<FileVO>) list("noticeDAO.selectFileList", fileVO);
	}
	
	public void deleteFileInfs(List<FileVO> listDelFileVO) throws Exception {
		Iterator<?> iter = listDelFileVO.iterator();
		FileVO vo;
		while (iter.hasNext()) {
			vo = (FileVO) iter.next();

			delete("noticeDAO.deleteFileDetail", vo);
		}
	}
}
