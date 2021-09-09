package study.login.web;

import java.security.PrivateKey;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.string.EgovStringUtil;
import study.login.service.AESUtil;
import study.common.service.RSAManager;
import study.login.service.StudyLoginService;
import study.login.service.LoginVO;

@Controller
public class LoginController {

    @Resource(name = "studyLoginService")
    private StudyLoginService studyLoginService;

    private static final String AES_KEY = EgovProperties.getProperty("userInfo.aesKey");
    
    @RequestMapping(value = "/login/userSignUp.do")
    public String userSignUp(HttpServletRequest request) throws Exception {

        RSAManager.initRsa(request);

        return "study/login/userSignUp";
    }

    @RequestMapping(value = "/login/userSignUpAction.do", method = RequestMethod.POST)
    public String userSignUpAction(LoginVO loginVO, HttpSession session) throws Exception {

            String userId = loginVO.getUserId();

            if (EgovStringUtil.isEmpty(userId)) {
                throw new Exception("아이디가 입력되지 않았습니다.");
            }

            PrivateKey privateKey = (PrivateKey) session.getAttribute(RSAManager.RSA_WEB_KEY);

            loginVO.setUserId(RSAManager.decryptRsa(privateKey, loginVO.getUserId()));
            loginVO.setUserPw(RSAManager.decryptRsa(privateKey, loginVO.getUserPw()));
            loginVO.setUserName(RSAManager.decryptRsa(privateKey, loginVO.getUserName()));
            loginVO.setUserPh(RSAManager.decryptRsa(privateKey, loginVO.getUserPh()));
            loginVO.setUserMail(RSAManager.decryptRsa(privateKey, loginVO.getUserMail()));

            AESUtil aesUtil = new AESUtil(AES_KEY);
            
            String enc = EgovFileScrty.encryptPassword(loginVO.getUserPw(), loginVO.getUserId());
            loginVO.setUserPw(enc);

            loginVO.setUserPh(aesUtil.encode(loginVO.getUserPh()));
            loginVO.setUserMail(aesUtil.encode(loginVO.getUserMail()));

            session.removeAttribute(RSAManager.RSA_WEB_KEY);

            studyLoginService.insertUserInfo(loginVO);

        return "redirect:/login/signupResult.do";
    }
    
    @ResponseBody
    @RequestMapping(value = "/login/idConfirm.do", method = RequestMethod.POST)
    public byte[] idConfirm(HttpServletRequest request) throws Exception {
        Map<String, Object> rtn = new HashMap<String, Object>();

        String userId = request.getParameter("userId");

        int confirm = (int) studyLoginService.idConfirm(userId);

        if (confirm > 0) {
            rtn.put("success", Boolean.TRUE);
            rtn.put("result", Boolean.FALSE);
        } else {
            rtn.put("success", Boolean.TRUE);
            rtn.put("result", Boolean.TRUE);
        }

        return new Gson().toJson(rtn).getBytes("UTF-8");
    }
    
    @RequestMapping(value = "/login/signupResult.do")
    public String joinStep3() throws Exception {
        return "study/login/signupResult";
    }

    @RequestMapping(value = "/login/login.do")
    public String login(HttpServletRequest request) throws Exception {
    	
        RSAManager.initRsa(request);

        return "study/login/login";
    }
    
    @ResponseBody
    @RequestMapping(value = "/login/loginAction.do")
    public byte[] loginAction(LoginVO loginVO, HttpServletRequest request, HttpSession session) throws Exception {

        Map<String, Object> rtn = new HashMap<>();

        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");

        PrivateKey privateKey = (PrivateKey) session.getAttribute(RSAManager.RSA_WEB_KEY);
        
        AESUtil aesUtil = new AESUtil(AES_KEY);

        loginVO.setUserId(RSAManager.decryptRsa(privateKey, userId));
        loginVO.setUserPw(RSAManager.decryptRsa(privateKey, userPw));
        
        String enc = EgovFileScrty.encryptPassword(loginVO.getUserPw(), loginVO.getUserId());
        loginVO.setUserPw(enc);
        
        LoginVO result = studyLoginService.loginAction(loginVO);

        // 로그인 성공
        if (result != null && result.getUserId() != null && result.getUserId() != "") {
            result.setUserPh(aesUtil.decode(result.getUserPh()));
            result.setUserMail(aesUtil.decode(result.getUserMail()));

            request.getSession().setAttribute("userLoginVO", result);
            session.removeAttribute(RSAManager.RSA_WEB_KEY);

            rtn.put("success", Boolean.TRUE);
            return new Gson().toJson(rtn).getBytes("UTF-8");

        } else { // 로그인 실패
            rtn.put("loginFailMsg", "아이디가 존재하지 않거나 비밀번호가 맞지 않습니다. \n다시 한 번 확인하신 후 로그인해주세요.");

            rtn.put("success", Boolean.FALSE);
            return new Gson().toJson(rtn).getBytes("UTF-8");
        }
    }
    
    @RequestMapping(value = "/main.do")
    public String main() throws Exception {
        return "study/main/main";
    }

}
