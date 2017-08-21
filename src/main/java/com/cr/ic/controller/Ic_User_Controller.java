package com.cr.ic.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import com.cr.ic.pojo.Ic_User;
import com.cr.ic.service.impl.Ic_User_ServiceImpl;

@Controller
@RequestMapping("/ic_user")
public class Ic_User_Controller {
	@Resource
	private Ic_User_ServiceImpl service;
	//用户登录
	@RequestMapping("/login.do")
	public ModelAndView login(HttpServletRequest req, HttpSession session) {
		String username = (String) req.getParameter("username");
		String password = (String) req.getParameter("password");
		Ic_User user = new Ic_User();
		user.setUsername(username);
		user.setPassword(password);
		Ic_User finduser = this.service.login(user);
		if (finduser == null) {
			return new ModelAndView(new RedirectView("../login.jsp"));
		} else {
			session.setAttribute("userid", finduser.getUserid());
			return new ModelAndView(new RedirectView("../index.jsp?create_id="
					+ finduser.getUserid()));
		}
	}

	//用户登出
	@RequestMapping("/logout.do")
	public ModelAndView logout(HttpServletRequest req, HttpSession session) {
		if (session.getAttribute("userid") == null) {
		} else {
			session.removeAttribute("userid");
		}
		return new ModelAndView(new RedirectView("../login.jsp"));
	}
}
