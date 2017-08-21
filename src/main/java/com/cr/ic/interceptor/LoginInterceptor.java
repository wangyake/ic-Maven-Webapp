package com.cr.ic.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @author bluewater
 * 登录拦截器
 */

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final String[] IGNORE_URI = { "/login" };

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res,
			Object handler) throws Exception {
		HttpSession session = req.getSession(true);
		String url = req.getRequestURL().toString();
		String contextPath = req.getContextPath();
		boolean flag = false;
		for (String s : IGNORE_URI) {
			if (url.contains(s)) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			Object obj = session.getAttribute("userid");
			if (obj == null) {
				res.sendRedirect(contextPath + "/login.jsp");
			} else {
				flag = true;
			}
		}
		return flag;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object obj, ModelAndView mav)
			throws Exception {
	}
}
