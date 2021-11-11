package study.login.service;

import java.time.LocalDate;

import org.apache.commons.lang.builder.ToStringBuilder;

public class LoginVO {

    private String userId;
    private String userName;
    private String userPw;
    private String userPh;
    private String userMail;
    private LocalDate pwModdate;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPw() {
        return userPw;
    }

    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }

    public String getUserPh() {
        return userPh;
    }

    public void setUserPh(String userPh) {
        this.userPh = userPh;
    }

    public String getUserMail() {
        return userMail;
    }

    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }

    public LocalDate getPwModdate() {
        return pwModdate;
    }

    public void setPwModdate(LocalDate pwModdate) {
        this.pwModdate = pwModdate;
    }

    // @Override
    // public String toString() {
    // return "LoginVO [userId=" + userId + ", userName=" + userName + ", userPw=" +
    // userPw + ", userPh=" + userPh
    // + ", userMail=" + userMail + ", pwModdate=" + pwModdate + "]";
    // }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
