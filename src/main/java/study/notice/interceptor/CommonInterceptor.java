package study.notice.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CommonInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		
		
		//인증된사용자 여부
		boolean isAuthenticated = false;
		/**
		if (RequestContextHolder.getRequestAttributes() == null) {
			isAuthenticated = false;
		} else {
			if (RequestContextHolder.getRequestAttributes().getAttribute("userLoginVO", RequestAttributes.SCOPE_SESSION) == null) {
				isAuthenticated = false;
			} else {
				isAuthenticated = true;
			}
		}
		**/
		if(request.getSession() == null) {
			isAuthenticated = false;
		} else {
			if(request.getSession().getAttribute("userLoginVO") == null) {
				isAuthenticated = false;
			} else {
				isAuthenticated = true;
			}
		}
		
		//미인증사용자 체크
		if(!isAuthenticated) {
			ModelAndView modelAndView = new ModelAndView("redirect:/login/login.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		
		return true;
	}

}