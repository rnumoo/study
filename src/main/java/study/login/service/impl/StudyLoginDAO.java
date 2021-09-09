package study.login.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import study.login.service.LoginVO;

@Repository("studyLoginDAO")
public class StudyLoginDAO extends EgovComAbstractDAO {
	
	public void insertUserInfo(LoginVO loginVO) throws Exception{
		insert("studyLoginDAO.insertUserInfo", loginVO);
	}
	
	public int idConfirm(Object param) throws Exception {
		return selectOne("studyLoginDAO.idConfirm", param);
	}
	
	public LoginVO loginAction(LoginVO loginVO) throws Exception {
		return selectOne("studyLoginDAO.loginAction", loginVO);
	}
	
}
