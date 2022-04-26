package com.personal.cv.controller;

import com.captcha.Captcha;
import com.lang.Convert;
import com.lang.PageModel;
import com.lang.StringUtil;
import com.personal.cv.entity.LoginInfo;
import com.personal.cv.entity.User_auths;
import com.personal.cv.entity.Users;
import com.personal.cv.service.impl.*;
import com.personal.cv.util.GeetestConfig;
import com.personal.cv.util.GeetestLib;
import com.personal.cv.util.QueryHelper;
import eu.bitwalker.useragentutils.UserAgent;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/login")
public class LoginController {

    private static Logger logger = Logger.getLogger(ArticleInfoController.class);

    @Resource
    private Users_authServiceImpl users_authService;
    @Resource
    private UserServiceImpl userService;
    @Resource
    private LoginServiceImpl loginService;
    @Resource
    private VisitInfoServiceImpl visitInfoService;

    private static final Captcha CAPTCHA = new Captcha(100, 40);

    public static void write(Object obj, HttpServletResponse response) throws IOException {
        write(obj, false, response);
    }

    public static void write(Object obj, boolean isJson, HttpServletResponse response) throws IOException {
        if (response == null)
            return;
        response.setContentType((isJson ? "application/json" : "text/plain") + ";charset=utf-8");
        PrintWriter pw = response.getWriter();
        pw.write(String.valueOf(obj));
        pw.flush();
        pw.close();
    }

    @RequestMapping(value = "/toPages/{pageName}")
    public String toPages(@PathVariable String pageName, Model model) {
        if ("main".equals(pageName)) {
            List<HashMap<String, Object>> statistics = visitInfoService.statistics();
            List<HashMap<String, Object>> loginState = loginService.loginState();
            model.addAttribute("statistics", statistics.get(0));
            model.addAttribute("loginState", loginState);
            return "WEB-INF/page/main";
        }
        return "WEB-INF/page/" + pageName + "";
    }

    @RequestMapping("/toCaptcha")
    public void toCaptcha(String checkcode, HttpServletResponse response) {
        try {
            if (StringUtil.isNullOrWhiteSpace(checkcode)) {
                ImageIO.write(CAPTCHA.createCode(), "jpg", response.getOutputStream());
            } else
                write(String.valueOf(CAPTCHA.checkCaptcha(checkcode)), response);
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public void loginManager(Boolean rememberPwd, User_auths user_auths, HttpServletRequest request, HttpServletResponse response) throws Exception {
        user_auths.setRole(0);
        HttpSession session = request.getSession();
        User_auths userAuths;
        int existCount = 0;
        try {
            existCount = users_authService.existIdentifier(user_auths.getIdentifier());
        } catch (Exception e) {
            System.err.println(new Date() + "[DateBase Not Connection... ]");
            write(-4, true, response);
            return;
        }
        if (existCount == 0) {
            write(-3, true, response);//帐号不存在错误
            return;
        }
        userAuths = users_authService.selectByIdentifier(user_auths);
        if (userAuths == null)//密码输入错误
            write(-2, true, response);
        else {
            String managerPwd = Convert.toString(session.getAttribute("managerPwd"));
            if (userAuths.getIdentifier() != null && userAuths.getIdentifier().equals(user_auths.getIdentifier()) || StringUtil.equals(userAuths.getCredential(), managerPwd)) {
                Users users;
                users = userService.get(userAuths.getUser_id());
                if (users == null) {
                    write(-2, true, response);
                    return;
                }
                QueryHelper.userAgent=UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
                userAuths.setUsers(users);
                LoginInfo loginInfo = new LoginInfo();
                loginInfo.setUser_id(userAuths.getUser_id());
                loginInfo.setLogin_ip(QueryHelper.ip(request));
                loginInfo.setLogin_time(new Date());
                loginInfo.setLogin_area(QueryHelper.area());
                loginInfo.setLogin_browser(QueryHelper.browser(request));
                loginInfo.setLogin_os(QueryHelper.os(request));
                loginInfo.setState(QueryHelper.state());//登录状态 0:正常 1:异常
                loginInfo.setDelete_state(0);//删除状态 0:正常 1:删除
                int count = loginService.save(loginInfo);
                if (count > 0) {
                    session.setAttribute("manager", users);
                    session.setAttribute("identifier", userAuths.getIdentifier());
                    if (Boolean.TRUE.equals(rememberPwd)) {
                        session.setAttribute("managerPwd", userAuths.getCredential());
                    } else {
                        request.getSession().removeAttribute("managerPwd");
                    }
                    write(1, true, response);
                } else
                    write(-1, true, response);
            }

        }
    }

    @RequestMapping(value = "/loginOut")
    public String loginOut(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("manager");
        return "redirect:/logout";
    }

    /**
     * [批量]删除(逻辑删)
     */
    @RequestMapping(value = "/deleteLog")
    @ResponseBody
    public String deleteLog(String ids,String type) {
        logger.info("删除登录记录");
        int num=0;
        if(type.equals("")||type==null){
            num = loginService.delete(ids);
        }else if(type.equals("all")){
            num = loginService.deleteAll();
        }else if(type.equals("current")){
            num = loginService.deleteByCurrent(Integer.valueOf(ids));
        }
        return result(num);
    }

    /**
     * 分页查询
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     * @param pattern  模糊查询
     * @param sort     排序方式
     */
    @RequestMapping(value = "/selectLog")
    @ResponseBody
    public PageModel selectLog(String pattern, int pageNo, int pageSize, String sort) {
        logger.info("分页查询登录记录");
        PageModel pageModel;
        try {
            pageModel = loginService.selectByPage(pattern, pageNo, pageSize, sort);
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        return pageModel;
    }

    public String result(int num) {
        if (num > 0)
            return "true";
        else if (num <= 0)
            return "false";
        else
            return "error";
    }

    @RequestMapping(value = "/init")
    public void init(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        GeetestLib gtSdk = new GeetestLib(GeetestConfig.getGeetest_id(), GeetestConfig.getGeetest_key(), GeetestConfig.isnewfailback());
        String resStr = "{}";
        //自定义userid
        String userid = "test";
        //自定义参数,可选择添加
        HashMap<String, String> param = new HashMap<String, String>();
        param.put("user_id", userid); //网站用户id
        param.put("client_type", "web"); //web:电脑上的浏览器；h5:手机上的浏览器，包括移动应用内完全内置的web_view；native：通过原生SDK植入APP应用的方式
        param.put("ip_address", "127.0.0.1"); //传输用户请求验证时所携带的IP
        //进行验证预处理
        int gtServerStatus = gtSdk.preProcess(param);

        //将服务器状态设置到session中
        request.getSession().setAttribute(gtSdk.gtServerStatusSessionKey, gtServerStatus);
        //将userid设置到session中
        request.getSession().setAttribute("userid", userid);
        resStr = gtSdk.getResponseStr();
        PrintWriter out = response.getWriter();
        out.println(resStr);
        System.out.println(resStr);
    }
}
