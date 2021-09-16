package study.login.service.impl;

import java.security.SecureRandom;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.sim.service.EgovFileScrty;
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
	
	public LoginVO findIdAction(LoginVO loginVO) throws Exception{
		return studyLoginDAO.findIdAction(loginVO);
	}
	
	public String findPwAction(LoginVO loginVO) throws Exception{
		
		int findPwAction = studyLoginDAO.findPwAction(loginVO);
		
		if (findPwAction > 0) {
			String tempPw = tempPwCreate();
			
			String enc = EgovFileScrty.encryptPassword(tempPw, loginVO.getUserId());
			
			loginVO.setUserPw(enc);
			
			studyLoginDAO.modifyPw(loginVO);
			
			return tempPw;
		} else {
			return null;
		}
	}
	
	public static String tempPwCreate() throws Exception {
        // TODO Auto-generated method stub

        char[] charList = new char[] { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
                'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
                'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5',
                '6', '7', '8', '9' };

        StringBuffer result = new StringBuffer();

        for (int i = 0; i < 8; i++) {
            SecureRandom rdm = new SecureRandom();
            int charIdx = (int) (charList.length * rdm.nextDouble());
            result.append(charList[charIdx]);
        }

        return result.toString();
    }
	
}
