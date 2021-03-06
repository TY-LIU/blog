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
     * ????????????
     *
     * @param nickname   ??????
     * @param credential ??????
     */
    @RequestMapping(value = "/register")
    @ResponseBody
    public String register(HttpServletRequest request, Users users, User_auths user_auths, String nickname, String identifier, String credential, String code) {
        logger.info("????????????");
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
            session.setAttribute("users", users);//????????????
        } catch (Exception e) {
            e.fillInStackTrace();
            return "error";
        }
        return result(num);
    }

    /**
     * ????????????
     */
    @RequestMapping(value = "/login")
    public void login(HttpServletRequest request, HttpServletResponse response, User_auths user_auths) throws Exception {
        logger.info("????????????");
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
        if (userAuths == null)//?????????????????????????????????
            write(-2, true, response);
        else {
            if (userAuths.getIdentifier() != null && userAuths.getIdentifier().equals(user_auths.getIdentifier()) || StringUtil.equals(userAuths.getCredential(), user_auths.getCredential())) {
                Users users;
                users = userService.get(userAuths.getUser_id());
                if (users == null) {
                    write(-2, true, response);
                    return;
                } else if (users.getEnable() == 0) {
                    write(-4, true, response);//?????????
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
                loginInfo.setState(QueryHelper.state());//???????????? 0:?????? 1:??????
                loginInfo.setDelete_state(0);//???????????? 0:?????? 1:??????
                int count = loginService.save(loginInfo);
                if (count > 0) {
                    session.setAttribute("users", users);//????????????
                    write(1, true, response);
                } else
                    write(-1, true, response);//????????????
            }

        }
    }

    @RequestMapping(value = "/qqLogin")
    public void qqLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        logger.info("qq??????");
        response.setContentType("text/html;charset=utf-8");
        try {
            response.sendRedirect(new Oauth().getAuthorizeURL(request));
        } catch (QQConnectException e) {
            e.printStackTrace();
        }
    }

    /**
     * ????????????qq????????????
     */
    @RequestMapping(value = "/qqConnect")
    public void qqConnect(HttpServletRequest request, HttpServletResponse response, Users users, User_auths user_auths) throws Exception {
        logger.info("qq????????????");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        try {
            AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);
            String accessToken, openID;
            if (accessTokenObj.getAccessToken().equals("")) {
                /*??????????????????CSRF????????????????????????????????????*/
                System.out.print("???????????????????????????");
                out.println("???????????????????????????");
                return;
            } else {
                String newName;
                accessToken = accessTokenObj.getAccessToken();
                OpenID openIDObj = new OpenID(accessToken);//??????accessToken??????OpenID
                openID = openIDObj.getUserOpenID();
                try {
                    if (!openID.equals(QueryHelper.judgeOpenID(accessToken))) {//????????????accessToken??????OpenID????????????
                        out.println("??????????????????????????????");
                        return;
                    }
                }catch (Exception e){
                    e.printStackTrace();
                    out.println("???????????????+"+e.getMessage()+"");
                    return;
                }
                UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
                UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
                if (userInfoBean.getRet() == 0) {//???????????????????????????
                    int i_exist,n_exist;
                    try {
                        i_exist = users_authService.existQQid(openID);//????????????????????????????????????
                        n_exist = userService.selectByNickName(userInfoBean.getNickname());//??????????????????????????????????????????
                    }catch (Exception e){
                        e.printStackTrace();
                        out.println("???????????????+"+e.getMessage()+"");
                        return;
                    }
                    if(i_exist>0){//??????????????????ID???????????????
                        Users newUsers=userService.selectByQQid(openID);//?????????????????????ID?????????????????????
                        if(newUsers==null){
                            out.println("??????????????????????????????");
                            return;
                        }
                        session.setAttribute("users", newUsers);//????????????
                        response.sendRedirect("/cv");//??????????????????
                        return;
                    }else{//?????????????????????????????????
                        newName=userInfoBean.getNickname();
                        if(n_exist>0){//qq??????????????????,???????????????????????????????????????
                            while (true){//????????????????????????????????????????????????
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
                            userService.register(users);//???????????????????????????
                        } catch (Exception e) {
                            e.fillInStackTrace();
                            out.println("???????????????"+e.getMessage()+"");
                            return;
                        }
                        user_auths.setRole(1);
                        user_auths.setUser_id(users.getUser_id());
                        user_auths.setAccess_token(accessToken);
                        user_auths.setQq_id(openID);
                        try {
                            users_authService.save(user_auths);//???????????????????????????
                        } catch (Exception e) {
                            e.fillInStackTrace();
                            out.println("???????????????"+e.getMessage()+"");
                            return;
                        }
                        session.setAttribute("users", users);//??????????????????
                        response.sendRedirect("/cv");//??????????????????
                        return;
                    }
                } else {
                    out.println("???????????????????????????????????????????????????");//?????????????????????qq???????????????
                    return;
                }
            }
        } catch (QQConnectException e) {//????????????
            e.printStackTrace();
            out.println("???????????????"+e.getMessage()+"");
            return;
        }
    }

    /**
     * ????????????
     * */
    @RequestMapping(value = "/signOut")
    public String signOut(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        session.removeAttribute("users");//????????????session
        return "redirect:/";//???????????????
    }

    /**
     * [??????]??????(?????????)
     */
    @RequestMapping(value = "/deleteUsers")
    @ResponseBody
    public String deleteMessage(String ids) {
        logger.info("????????????");
        int num = userService.delete(ids);
        return result(num);
    }

    /**
     * ????????????
     */
    @RequestMapping(value = "/disEnableUser")
    @ResponseBody
    public String disEnableUser(int user_id) {
        logger.info("????????????");
        int num = userService.updateDisEnable(user_id);
        return result(num);
    }

    /**
     * ????????????
     */
    @RequestMapping(value = "/enableUser")
    @ResponseBody
    public String enableUser(int user_id) {
        logger.info("??????");
        int num = userService.updateEnable(user_id);
        return result(num);
    }


    /**
     * ????????????
     */
    @RequestMapping(value = "/updateUser")
    @ResponseBody
    public String updateUser(Users users, User_auths user_auths, int user_id, String nickname, String portrait, String autograph, int auths_id, String qq_id, String access_token, String qq_number, String identifier) {
        logger.info("????????????");
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
     * ??????????????????
     */
    @RequestMapping(value = "/seeUser")
    @ResponseBody
    public List seeUser(int users_id) {
        logger.info("??????????????????");
        List<HashMap<String, Object>> list = userService.seeUser(users_id);
        return list;
    }

    /**
     * ????????????
     *
     * @param pageSize ??????????????????
     * @param pageNo   ?????????
     * @param pattern  ????????????
     * @param sort     ????????????
     */
    @RequestMapping(value = "/selectUsers")
    @ResponseBody
    public PageModel selectMessage(String pattern, int pageNo, int pageSize, String sort) {
        logger.info("??????????????????");
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
     * ????????????????????????
     */
    @RequestMapping(value = "/selectByNickName")
    @ResponseBody
    public String selectByNickName(String nickname) {
        logger.info("????????????");
        int num = userService.selectByNickName(nickname.trim());
        return result(num);
    }

    /**
     * ????????????????????????????????????
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
        p = Pattern.compile("^[1][3,4,5,7,8][0-9]{9}$"); // ???????????????
        m = p.matcher(str);
        b = m.matches();
        return b;
    }


}
