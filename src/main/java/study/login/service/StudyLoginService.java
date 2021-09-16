package study.login.service;

public interface StudyLoginService {

    // 회원가입
    public void insertUserInfo(LoginVO loginVO) throws Exception;

    public Object idConfirm(Object param) throws Exception;

    public LoginVO loginAction(LoginVO loginVO) throws Exception;

    public LoginVO findIdAction(LoginVO loginVO) throws Exception;

    public String findPwAction(LoginVO loginVO) throws Exception;

    public void changePw(LoginVO loginVO) throws Exception;

}
