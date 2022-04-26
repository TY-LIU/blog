package com.personal.cv.filter;

import com.personal.cv.util.VisitInfoUtil;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by Administrator on 2017/1/6.
 */
public class VisitFilter implements Filter {

    private FilterConfig filterConfig;

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        if (httpServletRequest.getRequestURI().indexOf(".") < 0
                && httpServletRequest.getRequestURI().indexOf("toPages") < 0
                && httpServletRequest.getRequestURI().indexOf("login") < 0
                && httpServletRequest.getRequestURI().indexOf("articleInfo") < 0
                && httpServletRequest.getRequestURI().indexOf("columnInfo") < 0) {
            new VisitInfoUtil().calClickRate(httpServletRequest);
        }
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

}