package com.personal.cv.controller;

import com.lang.PageModel;
import com.lang.StringUtil;
import com.personal.cv.entity.LoginInfo;
import com.personal.cv.entity.User_auths;
import com.personal.cv.entity.Users;
import com.personal.cv.service.impl.LoginServiceImpl;
import com.personal.cv.service.impl.UserServiceImpl;
import com.personal.cv.service.impl.Users_authServiceImpl;
import com.personal.cv.util.CreateCode;
import com.personal.cv.util.QueryHelper;
import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.oauth.Oauth;
import eu.bitwalker.useragentutils.UserAgent;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/users")
public class UsersController {

    private static Logger logger = Logger.getLogger(MessageInfoController.class);
    @Resource
    private UserServiceImpl userService;
    @Resource
    private Users_authServiceImpl users_authService;
    @Resource
    private LoginServiceImpl loginService;

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

    /**
     * 注册用户
     *
     * @param nickname   昵称
     * @param credential 密码
     */
    @RequestMapping(value = "/register")
    @ResponseBody
    public String register(HttpServletRequest request, Users users, User_auths user_auths, String nickname, String identifier, String credential, String code) {
        logger.info("添加用户");
        HttpSession session = request.getSession();
        String r_code;
        int num;
        if (!isMobile(identifier))
            return "telError";
        try {
            r_code = request.getSession().getAttribute("code").toString();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            r_code = null;
        }
        if (r_code == "timeOut" || r_code == null)
            return "timeOut";
        else if (!r_code.equals(code))
            return "codeError";
        int i_exist = users_authService.existIdentifier(identifier);
        int n_exist = userService.selectByNickName(nickname.trim());
        if (i_exist > 0)
            return "i_exist";
        else if (n_exist > 0)
            return "n_exist";
        users.setNickname(nickname);
        users.setRegister_time(new Date());
        try {
            userService.register(users);
        } catch (Exception e) {
            e.fillInStackTrace();
            return "error";
        }
        user_auths.setRole(1);
        user_auths.setUser_id(users.getUser_id());
        user_auths.setIdentifier(identifier);
        user_auths.setCredential(credential);
        try {
            num = users_authService.save(user_auths);
            session.setAttribute("users", users);//登录成功
        } catch (Exception e) {
            e.fillInStackTrace();
            return "error";
        }
        return result(num);
    }

    /**
     * 用户登录
     */
    @RequestMapping(value = "/login")
    public void login(HttpServletRequest request, HttpServletResponse response, User_auths user_auths) throws Exception {
        logger.info("用户登录");
        user_auths.setRole(1);
        HttpSession session = request.getSession();
        User_auths userAuths;
        try {
            users_authService.existIdentifier(user_auths.getIdentifier());
        } catch (Exception e) {
            System.err.println(new Date() + "[DateBase Not Connection... ]");
            write(-3, true, response);
            return;
        }
        userAuths = users_authService.selectByIdentifier(user_auths);
        if (userAuths == null)//用户名或者密码输入错误
            write(-2, true, response);
        else {
            if (userAuths.getIdentifier() != null && userAuths.getIdentifier().equals(user_auths.getIdentifier()) || StringUtil.equals(userAuths.getCredential(), user_auths.getCredential())) {
                Users users;
                users = userService.get(userAuths.getUser_id());
                if (users == null) {
                    write(-2, true, response);
                    return;
                } else if (users.getEnable() == 0) {
                    write(-4, true, response);//被禁用
                    return;
                }
                QueryHelper.userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
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
                    session.setAttribute("users", users);//登录成功
                    write(1, true, response);
                } else
                    write(-1, true, response);//登录失败
            }

        }
    }

    @RequestMapping(value = "/qqLogin")
    public void qqLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        logger.info("qq登录");
        response.setContentType("text/html;charset=utf-8");
        try {
            response.sendRedirect(new Oauth().getAuthorizeURL(request));
        } catch (QQConnectException e) {
            e.printStackTrace();
        }
    }

    /**
     * 用户使用qq登录回调
     */
    @RequestMapping(value = "/qqConnect")
    public void qqConnect(HttpServletRequest request, HttpServletResponse response, Users users, User_auths user_auths) throws Exception {
        logger.info("qq登录回调");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        try {
            AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);
            String accessToken, openID;
            if (accessTokenObj.getAccessToken().equals("")) {
                /*我们的网站被CSRF攻击了或者用户取消了授权*/
                System.out.print("没有获取到响应参数");
                out.println("没有获取到响应参数");
                return;
            } else {
                String newName;
                accessToken = accessTokenObj.getAccessToken();
                OpenID openIDObj = new OpenID(accessToken);//通过accessToken获取OpenID
                openID = openIDObj.getUserOpenID();
                try {
                    if (!openID.equals(QueryHelper.judgeOpenID(accessToken))) {//判断当前accessToken获取OpenID是否正确
                        out.println("当前登录账户存在问题");
                        return;
                    }
                }catch (Exception e){
                    e.printStackTrace();
                    out.println("登录错误：+"+e.getMessage()+"");
                    return;
                }
                UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
                UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
                if (userInfoBean.getRet() == 0) {//是否获取到用户信息
                    int i_exist,n_exist;
                    try {
                        i_exist = users_authService.existQQid(openID);//该用户是否已经存在数据库
                        n_exist = userService.selectByNickName(userInfoBean.getNickname());//该用户昵称是否已经存在数据库
                    }catch (Exception e){
                        e.printStackTrace();
                        out.println("登录错误：+"+e.getMessage()+"");
                        return;
                    }
                    if(i_exist>0){//数据库存在该ID则直接登录
                        Users newUsers=userService.selectByQQid(openID);//在数据库找到该ID的用户基本信息
                        if(newUsers==null){
                            out.println("当前登录账户存在问题");
                            return;
                        }
                        session.setAttribute("users", newUsers);//登录成功
                        response.sendRedirect("/cv");//重定向到首页
                        return;
                    }else{//不存在则自动注册再登录
                        newName=userInfoBean.getNickname();
                        if(n_exist>0){//qq昵称被人使用,则随机四位数字追加到昵称后
                            while (true){//如果加了随机码后还存在则循环追加
                                newName = CreateCode.CreateLetter(userInfoBean.getNickname());
                                int num = userService.selectByNickName(newName);
                                if(num==0)
                                    break;
                            }
                        }
                        users.setNickname(newName);
                        users.setRegister_time(new Date());
                        users.setPortrait(userInfoBean.getAvatar().getAvatarURL100());
                        try {
                            userService.register(users);//注册该用户基本信息
                        } catch (Exception e) {
                            e.fillInStackTrace();
                            out.println("登录失败："+e.getMessage()+"");
                            return;
                        }
                        user_auths.setRole(1);
                        user_auths.setUser_id(users.getUser_id());
                        user_auths.setAccess_token(accessToken);
                        user_auths.setQq_id(openID);
                        try {
                            users_authService.save(user_auths);//注册该用户账户信息
                        } catch (Exception e) {
                            e.fillInStackTrace();
                            out.println("登录失败："+e.getMessage()+"");
                            return;
                        }
                        session.setAttribute("users", users);//注册之后登录
                        response.sendRedirect("/cv");//重定向到首页
                        return;
                    }
                } else {
                    out.println("很抱歉，我们没能正确获取到您的信息");//接口没找到登录qq的个人信息
                    return;
                }
            }
        } catch (QQConnectException e) {//接口报错
            e.printStackTrace();
            out.println("登录失败："+e.getMessage()+"");
            return;
        }
    }

    /**
     * 退出登录
     * */
    @RequestMapping(value = "/signOut")
    public String signOut(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        session.removeAttribute("users");//删除用户session
        return "redirect:/";//返回到首页
    }

    /**
     * [批量]删除(逻辑删)
     */
    @RequestMapping(value = "/deleteUsers")
    @ResponseBody
    public String deleteMessage(String ids) {
        logger.info("删除用户");
        int num = userService.delete(ids);
        return result(num);
    }

    /**
     * 禁用用户
     */
    @RequestMapping(value = "/disEnableUser")
    @ResponseBody
    public String disEnableUser(int user_id) {
        logger.info("禁用用户");
        int num = userService.updateDisEnable(user_id);
        return result(num);
    }

    /**
     * 启用用户
     */
    @RequestMapping(value = "/enableUser")
    @ResponseBody
    public String enableUser(int user_id) {
        logger.info("用户");
        int num = userService.updateEnable(user_id);
        return result(num);
    }


    /**
     * 修改用户
     */
    @RequestMapping(value = "/updateUser")
    @ResponseBody
    public String updateUser(Users users, User_auths user_auths, int user_id, String nickname, String portrait, String autograph, int auths_id, String qq_id, String access_token, String qq_number, String identifier) {
        logger.info("修改用户");
        users.setUser_id(user_id);
        users.setNickname(nickname);
        users.setPortrait(portrait);
        users.setAutograph(autograph);
        user_auths.setAuths_id(auths_id);
        user_auths.setQq_id(qq_id);
        user_auths.setAccess_token(access_token);
        user_auths.setQq_number(qq_number);
        user_auths.setIdentifier(identifier);
        int num = userService.updateUser(users, user_auths);
        return result(num);
    }


    /**
     * 查看用户详情
     */
    @RequestMapping(value = "/seeUser")
    @ResponseBody
    public List seeUser(int users_id) {
        logger.info("查看留言详情");
        List<HashMap<String, Object>> list = userService.seeUser(users_id);
        return list;
    }

    /**
     * 分页查询
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     * @param pattern  模糊查询
     * @param sort     排序方式
     */
    @RequestMapping(value = "/selectUsers")
    @ResponseBody
    public PageModel selectMessage(String pattern, int pageNo, int pageSize, String sort) {
        logger.info("分页查询评论");
        PageModel pageModel;
        try {
            pageModel = userService.selectByPage(pattern, pageNo, pageSize, sort);
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

    /**
     * 判断用户是否存在
     */
    @RequestMapping(value = "/selectByNickName")
    @ResponseBody
    public String selectByNickName(String nickname) {
        logger.info("查询昵称");
        int num = userService.selectByNickName(nickname.trim());
        return result(num);
    }

    /**
     * 前台用户自己修改个人信息
     * */
    @RequestMapping(value = "/editByUser")
    @ResponseBody
    public String editByUser(HttpServletRequest request, Users users){
        HttpSession session = request.getSession();
        Users sessionUser = (Users) session.getAttribute("users");
        if(sessionUser.getUser_id()!=users.getUser_id()){
            return null;
        }
        if(users.getNickname().length()>8){
            return "longName";
        }
        if(users.getAutograph().length()>50){
            return "longAuto";
        }
        int num = userService.selectByNickName(users.getNickname().trim());
        if(num>0){
            return "exist";
        }else{
            try {
                int num1 = userService.editByUser(users);
                List<Map<String, Object>> list = userService.getByUser(users.getUser_id());
                if(list!=null){
                    users.setPortrait(list.get(0).get("portrait").toString());
                    users.setNickname(list.get(0).get("nickname").toString());
                    users.setAutograph(list.get(0).get("autograph").toString());
                }else{
                    return null;
                }
                session.setAttribute("users",users);
                return result(num1);
            }catch (Exception e){
                e.printStackTrace();
                return null;
            }
        }
    }



    public static boolean isMobile(final String str) {
        Pattern p = null;
        Matcher m = null;
        boolean b = false;
        p = Pattern.compile("^[1][3,4,5,7,8][0-9]{9}$"); // 验证手机号
        m = p.matcher(str);
        b = m.matches();
        return b;
    }


}
