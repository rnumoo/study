package study.login.service;

public interface StudyLoginService {
	
	//회원가입
	public void insertUserInfo(LoginVO loginVO) throws Exception;
	
	public Object idConfirm(Object param) throws Exception;
	
	public LoginVO loginAction(LoginVO loginVO) throws Exception;
	
}
