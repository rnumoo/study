package study.login.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import study.login.service.StudyLoginService;
import study.login.service.LoginVO;

@Service("studyLoginService")
public class StudyLoginServiceImpl extends EgovAbstractServiceImpl implements StudyLoginService {
	
	@Resource(name = "studyLoginDAO")
	private StudyLoginDAO studyLoginDAO;
	
	@Override
	public void insertUserInfo(LoginVO loginVO) throws Exception {
		studyLoginDAO.insertUserInfo(loginVO);
	}
	
	public Object idConfirm(Object param) throws Exception {
		return studyLoginDAO.idConfirm(param);
	}
	
	public LoginVO loginAction(LoginVO loginVO) throws Exception{
		return studyLoginDAO.loginAction(loginVO);
	}
	
}
