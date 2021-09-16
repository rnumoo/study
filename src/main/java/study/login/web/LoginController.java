package study.login.web;

import java.security.PrivateKey;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.google.gson.Gson;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.sim.service.EgovFileScrty;
import study.common.service.RSAManager;
import study.login.service.AESUtil;
import study.login.service.LoginVO;
import study.login.service.StudyLoginService;

@Controller
public class LoginController {

    @Resource(name = "studyLoginService")
    private StudyLoginService studyLoginService;

    @Resource(name = "EMSMailSender")
    private JavaMailSender mailSender;

    private static final String AES_KEY = EgovProperties.getProperty("userInfo.aesKey");

    @RequestMapping(value = "/login/userSignUp.do")
    public String userSignUp(HttpServletRequest request) throws Exception {

        RSAManager.initRsa(request);

        return "study/login/userSignUp";
    }

    @RequestMapping(value = "/login/userSignUpAction.do", method = RequestMethod.POST)
    public String userSignUpAction(LoginVO loginVO, HttpSession session) throws Exception {

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
            rtn.put("success", Boolean.FALSE);
        } else {
            rtn.put("success", Boolean.TRUE);
        }

        return new Gson().toJson(rtn).getBytes("UTF-8");
    }

    @RequestMapping(value = "/login/signupResult.do")
    public String signupResult() throws Exception {
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

        LocalDate nowDate = LocalDate.now();

        // 로그인 성공
        if (result != null && result.getUserId() != null && result.getUserId() != "") {
            result.setUserPh(aesUtil.decode(result.getUserPh()));
            result.setUserMail(aesUtil.decode(result.getUserMail()));

            request.getSession().setAttribute("userLoginVO", result);
            session.removeAttribute(RSAManager.RSA_WEB_KEY);

            LocalDate pwExpireChk = result.getPwModdate().plusDays(90);
            if (pwExpireChk.isBefore(nowDate)) {
                rtn.put("redirectPage", Boolean.TRUE);
            } else {
                rtn.put("redirectPage", Boolean.FALSE);
            }

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

    @RequestMapping(value = "/login/logout.do")
    public String logout() throws Exception {

        RequestContextHolder.getRequestAttributes().setAttribute("userLoginVO", null, RequestAttributes.SCOPE_SESSION);

        return "redirect:/main.do";
    }

    @RequestMapping(value = "/login/findId.do")
    public String findId(HttpServletRequest request) throws Exception {

        return "study/login/findId";
    }

    @ResponseBody
    @RequestMapping(value = "/login/findIdAction.do")
    public byte[] findIdAction(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request,
            HttpSession session) throws Exception {

        Map<String, Object> rtn = new HashMap<>();

        String userName = request.getParameter("userName");
        String userMail = request.getParameter("userMail");

        loginVO.setUserName(userName);
        loginVO.setUserMail(userMail);

        AESUtil aesUtil = new AESUtil(AES_KEY);
        loginVO.setUserMail(aesUtil.encode(loginVO.getUserMail()));

        LoginVO result = studyLoginService.findIdAction(loginVO);

        // 아이디 찾기 성공
        if (result != null && result.getUserId() != null && result.getUserId() != "") {

            rtn.put("userId", result.getUserId());

            rtn.put("success", Boolean.TRUE);
            return new Gson().toJson(rtn).getBytes("UTF-8");

        } else { // 아이디 찾기 실패
            rtn.put("findIdFailMsg", "일치하는 계정이 존재하지 않습니다.");

            rtn.put("success", Boolean.FALSE);
            return new Gson().toJson(rtn).getBytes("UTF-8");
        }
    }

    @RequestMapping(value = "/login/findIdResult.do")
    public String findIdResult(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request)
            throws Exception {

        String userId = request.getParameter("userId");

        if (userId.length() > 2) {
            userId = userId.replace(userId.substring(0, 2), "**");
        }

        loginVO.setUserId(userId);

        return "study/login/findIdResult";
    }

    @RequestMapping(value = "/login/findPw.do")
    public String findPw(HttpServletRequest request) throws Exception {

        return "study/login/findPw";
    }

    @ResponseBody
    @RequestMapping(value = "/login/findPwAction.do")
    public byte[] findPwAction(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request,
            HttpSession session) throws Exception {

        Map<String, Object> rtn = new HashMap<>();

        String userId = request.getParameter("userId");
        String userName = request.getParameter("userName");
        String userMail = request.getParameter("userMail");

        loginVO.setUserId(userId);
        loginVO.setUserName(userName);
        loginVO.setUserMail(userMail);

        AESUtil aesUtil = new AESUtil(AES_KEY);
        loginVO.setUserMail(aesUtil.encode(loginVO.getUserMail()));

        String result = studyLoginService.findPwAction(loginVO);

        // 비밀번호 찾기 성공
        if (result != null && result != "") {

            Map<String, String> param = new HashMap<String, String>();
            param.put("tempPw", result);

            sendEmail(userMail, param);

            rtn.put("findPwSucMsg", "가입 시 입력한 이메일 주소로 임시비밀번호를 발송해 드렸습니다.\r\n로그인 후 비밀번호를 변경하십시오.");

            rtn.put("success", Boolean.TRUE);
            return new Gson().toJson(rtn).getBytes("UTF-8");

        } else { // 비밀번호 찾기 실패
            rtn.put("findPwFailMsg", "일치하는 계정이 존재하지 않습니다.");

            rtn.put("success", Boolean.FALSE);
            return new Gson().toJson(rtn).getBytes("UTF-8");
        }
    }

    @RequestMapping(value = "/login/changePw.do")
    public String changePw(HttpServletRequest request) throws Exception {

        RSAManager.initRsa(request);

        return "study/login/changePw";
    }

    @ResponseBody
    @RequestMapping(value = "/login/changePwAction.do")
    public byte[] changePwAction(LoginVO loginVO, HttpServletRequest request, HttpSession session) throws Exception {

        Map<String, Object> rtn = new HashMap<String, Object>();

        LoginVO userLoginVO = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("userLoginVO",
                RequestAttributes.SCOPE_SESSION);

        String userPw = request.getParameter("userPw");
        String userPwNew = request.getParameter("userPwNew");

        PrivateKey privateKey = (PrivateKey) session.getAttribute(RSAManager.RSA_WEB_KEY);

        AESUtil aesUtil = new AESUtil(AES_KEY);

        loginVO.setUserId(userLoginVO.getUserId());
        loginVO.setUserName(userLoginVO.getUserName());
        loginVO.setUserMail(aesUtil.encode(userLoginVO.getUserMail()));
        loginVO.setUserPw(RSAManager.decryptRsa(privateKey, userPw));

        String enc = EgovFileScrty.encryptPassword(loginVO.getUserPw(), loginVO.getUserId());
        loginVO.setUserPw(enc);

        LoginVO pwConfirm = studyLoginService.loginAction(loginVO);

        if (pwConfirm == null || pwConfirm.getUserId() == null || pwConfirm.getUserId() == "") {
            rtn.put("success", Boolean.FALSE);
            rtn.put("changePwFailMsg", "현재 비밀번호가 맞지 않습니다. 다시 확인 후 입력해주세요.");

            return new Gson().toJson(rtn).getBytes("UTF-8");
        } else {
            loginVO.setUserPw(RSAManager.decryptRsa(privateKey, userPwNew));
            String encNew = EgovFileScrty.encryptPassword(loginVO.getUserPw(), loginVO.getUserId());
            loginVO.setUserPw(encNew);

            studyLoginService.changePw(loginVO);

            session.removeAttribute(RSAManager.RSA_WEB_KEY);
            rtn.put("success", Boolean.TRUE);
            rtn.put("changePwSucMsg", "비밀번호 변경 성공");

            return new Gson().toJson(rtn).getBytes("UTF-8");
        }
    }

    private void sendEmail(String email, Map<String, String> param) throws Exception {

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
        messageHelper.setSubject("study 임시비밀번호 발송 메일");
        messageHelper.setText(param.get("tempPw"), true);
        messageHelper.setFrom("webmaster@eplatform.co.kr", "fromStudy");
        messageHelper.setTo(new InternetAddress(email, "toStudy", "UTF-8"));
        mailSender.send(message);
    }

}
