package com.personal.cv.interceptor;

import com.personal.cv.entity.Users;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.InternalPathMethodNameResolver;
import org.springframework.web.servlet.mvc.multiaction.MethodNameResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class ManagerInterceptor implements HandlerInterceptor {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
        System.out.println("=======================进入拦截=======================");
        MethodNameResolver methodNameResolver = new InternalPathMethodNameResolver();
        System.out.println("methodName=" + methodNameResolver.getHandlerMethodName(request));
        HttpSession session = request.getSession();
        //当后台管理员登录后或者以下方法可以通过拦截
        if (session.getAttribute("manager") instanceof Users
                || methodNameResolver.getHandlerMethodName(request).equals("init")
                || methodNameResolver.getHandlerMethodName(request).equals("selectReply")
                || methodNameResolver.getHandlerMethodName(request).equals("selectByIndex")
                || methodNameResolver.getHandlerMethodName(request).equals("selectByNickName")
                || methodNameResolver.getHandlerMethodName(request).equals("like")
                || methodNameResolver.getHandlerMethodName(request).equals("sendMag")
                || methodNameResolver.getHandlerMethodName(request).equals("login")
                || methodNameResolver.getHandlerMethodName(request).equals("qqLogin")
                || methodNameResolver.getHandlerMethodName(request).equals("qqConnect")
                || methodNameResolver.getHandlerMethodName(request).equals("register")) {
            return true;
        }
        //当前台用户登录后并且是以下方法才可以通过拦截
        if (session.getAttribute("users") instanceof Users && (methodNameResolver.getHandlerMethodName(request).equals("addReply")
                || methodNameResolver.getHandlerMethodName(request).equals("addMessage")
                || methodNameResolver.getHandlerMethodName(request).equals("delMessage")
                || methodNameResolver.getHandlerMethodName(request).equals("delReply")
                || methodNameResolver.getHandlerMethodName(request).equals("selectByUser")
                || methodNameResolver.getHandlerMethodName(request).equals("signOut")
                || methodNameResolver.getHandlerMethodName(request).equals("editByUser"))){
            return true;
        }
        session.setAttribute("unManagerLogin", "unManagerLogin");
        response.sendRedirect(request.getContextPath() + "/logout");
        return false;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView view) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object obj, Exception exception) throws Exception {
        //System.out.println("=================放行=======================");
    }
}
