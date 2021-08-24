package study.notice.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import study.notice.service.NoticeService;
import study.notice.service.NoticeVO;
import study.notice.service.SearchVO;

//@Service : 비즈니스 로직을 수행하는 class라는 것을 나타내는 어노테이션(비즈니스 로직 : 사용자의 요청에 대한 데이터의 처리, 가공)
@Service("noticeService")
public class NoticeServiceImpl extends EgovAbstractServiceImpl implements NoticeService {

	@Resource(name = "noticeDAO")
	private NoticeDAO noticeDAO;

	@Override
	public List<?> selectNoticeList(SearchVO searchVO) throws Exception {
		//noticeDAO 클래스의 selectNoticeList 결과를 searchVO에 넣어서 List형으로 return
		return noticeDAO.selectNoticeList(searchVO);
	}

	public List<?> selectNoticeListFix(SearchVO searchVO) throws Exception {
		return noticeDAO.selectNoticeListFix(searchVO);
	}

	public void noticeWriteAction(NoticeVO noticeVO) throws Exception {
		noticeDAO.noticeWriteAction(noticeVO);
	}

	public EgovMap selectNoticeDetail(NoticeVO noticeVO) throws Exception {
		return noticeDAO.selectNoticeDetail(noticeVO);
	}

	public int selectNoticeCnt(SearchVO searchVO) throws Exception {
		return noticeDAO.selectNoticeCnt(searchVO);
	}

	public void noticeUpdateAction(NoticeVO noticeVO) throws Exception {
		noticeDAO.noticeUpdateAction(noticeVO);
	}

	public void noticeDeleteAction(NoticeVO noticeVO) throws Exception {
		noticeDAO.noticeDeleteAction(noticeVO);
	}

	public void noticeViewCount(NoticeVO noticeVO) throws Exception {
		noticeDAO.noticeViewCount(noticeVO);
	}

	public EgovMap selectNoticeDetailNext(NoticeVO noticeVO) throws Exception {
		return noticeDAO.selectNoticeDetailNext(noticeVO);
	}

	public EgovMap selectNoticeDetailPre(NoticeVO noticeVO) throws Exception {
		return noticeDAO.selectNoticeDetailPre(noticeVO);
	}

}
