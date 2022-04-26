package com.personal.cv;

import com.aliyuncs.exceptions.ClientException;
import com.lang.PageModel;
import com.personal.cv.dao.VisitInfoDao;
import com.personal.cv.entity.*;
import com.personal.cv.service.impl.LikeService;
import com.personal.cv.service.impl.*;
import com.personal.cv.util.QueryHelper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import java.util.Map.Entry;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:Spring-mybatis.xml")
public class DaoTest {
    @Resource
    private SysInfoServiceImpl sysInfoService;
    @Resource
    private ColumnInfoServiceImpl columnInfoService;
    @Resource
    private ArticleInfoServiceImpl articleInfoService;
    @Resource
    private TempArticleInfoServiceImpl tempArticleInfoService;
    @Resource
    private VisitInfoServiceImpl visitInfoService;


    @Test
    public void selectAll() {
        System.out.println(sysInfoService.selectAll());
        List<SysInfo> list = sysInfoService.selectAll();
        for (SysInfo sysInfo : list) {
            System.out.println(sysInfo.getJava_version());
        }
        Iterator iterator = list.iterator();
        while (iterator.hasNext()) {
            Object obj = iterator.next();
            System.out.println(obj);
        }
    }

    /* @Test
     public void save(){
         ColumnInfo columnInfo=new ColumnInfo();
         columnInfo.setColumn_name("测试数据2");
         columnInfo.setAlias("测试数据2");
         columnInfo.setSet_time(new Date());
         columnInfo.setDelete_state(0);
         int i = columnInfoService.save(columnInfo);
         System.out.println(i);
     }*/
    @Test
    public void select() {
        List<ColumnInfo> list = columnInfoService.selectAll();
        System.out.println(list.size());
        if (list == null) {
            System.out.println("null");
        } else {
            System.out.println("notNull");
        }
        /*for(ColumnInfo columnInfo : list){
            System.out.println(columnInfo.getArticleNum());
        }*/
    }

    @Test
    public void selectByPage() {
        PageModel<ArticleInfo> pageModel;
        try {
            pageModel = articleInfoService.selectByPage("", 2, 2, "");
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        for (ArticleInfo articleInfo : pageModel.getData()) {
            System.out.println(articleInfo.getArticle_id() + "=============" + articleInfo.getCommentNum());
        }
    }

    @Test
    public void sp() {
        String[] n = "12345678.jpg".split("\\.");
        for (int s = 0; s < n.length; s++) {
            System.out.println(n[s]);
        }
        n[0] = "987654321";
        String p = n[0] + "." + n[1];
        System.out.println(p);
    }

    @Test
    public void saveOrUpdate() {
        TempArticleInfo tempArticleInfo = new TempArticleInfo();
        Date update_time = new Date();
        tempArticleInfo.setArticle_id(1);
        tempArticleInfo.setTitle("标题");
        tempArticleInfo.setContent("内容");
        tempArticleInfo.setDescribe("描述");
        tempArticleInfo.setTitle_img("图片URL");
        tempArticleInfo.setColumn_id(1);
        tempArticleInfo.setLabel("标签");
        tempArticleInfo.setPut_state(0);
        tempArticleInfo.setPut_time(update_time);
        tempArticleInfo.setUpdate_time(update_time);
        int i = tempArticleInfoService.saveOrUpdate(tempArticleInfo);
        System.out.println(i);
    }

    public static String getWebIp() {
        try {

            URL url = new URL("http://ip.chinaz.com/getip.aspx");

            BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));

            String s = "";

            StringBuffer sb = new StringBuffer("");

            String webContent = "";

            while ((s = br.readLine()) != null) {
                sb.append(s + "\r\n");

            }

            br.close();
            webContent = sb.toString();
            int start = webContent.indexOf("[") + 1;
            int end = webContent.indexOf("]");
            webContent = webContent.substring(start, end);

            return webContent;

        } catch (Exception e) {
            e.printStackTrace();
            return "error";

        }
    }

    public static String get(String urlString) {
        try {
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(5 * 1000);
            conn.setReadTimeout(5 * 1000);
            conn.setDoInput(true);
            conn.setDoOutput(true);
            conn.setUseCaches(false);
            conn.setInstanceFollowRedirects(false);
            conn.setRequestMethod("GET");
            /*conn.setRequestProperty("token",token);*/
            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                StringBuilder builder = new StringBuilder();
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
                for (String s = br.readLine(); s != null; s = br.readLine()) {
                    builder.append(s);
                }
                br.close();
                return builder.toString();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "error";
    }

    @Test
    public void te() {
        /*String builder=get("http://ip.taobao.com/service/getIpInfo2.php?ip=myip");
        Map maps = (Map) JSON.parse(builder);
        Map m= (Map) maps.get("data");
        *//*for (Object map : m.entrySet()){
            System.out.println(((Map.Entry)map).getKey()+"     " + ((Map.Entry)map).getValue());
        }*//*
        System.out.println("ip:"+m.get("ip")+"=======country:"+m.get("country")+"======city:"+m.get("city"));*/
        String UA = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36";

        //String UR = " Mozilla/5.0 (Linux; Android 7.1.1; ONEPLUS A3010 Build/NMF26F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.84 Mobile Safari/537.36";

        /*String UR="Mozilla/5.0(Linux; Android 4.3; zh-cn; SAMSUNG-GT-I9308_TD/1.0Android/4.3Release/11.15.2013Browser/AppleWebKit534.30Build/JSS15J) AppleWebKit/534.30(KHTML, like Gecko) Version/4.0Mobile Safari/534.30";
        Pattern pattern = Pattern.compile(";\\s?(\\S*?\\s?\\S*?)\\s?(Build)?/");

        Matcher matcher = pattern.matcher(UR);

        String model = null;

        if(matcher.find()) {
            model = matcher.group(1).trim();
            System.out.println("通过userAgent解析出机型："+ model);
        }*/

        String bit;
        int b_index = UA.lastIndexOf(";") + 1;
        int e_index = UA.indexOf(")");
        bit = UA.substring(b_index, e_index);
        bit = bit.replace("WOW", "bit");
        System.out.println(bit);

    }

    @Resource
    private VisitInfoDao visitInfoDao;

    @Test
    public void statistics() {
        /*VisitInfo visitInfo=new VisitInfo();
        visitInfo.setVisit_num(10);
        int count = visitInfoDao.updateVisitClickDate(visitInfo);//更新数据库
        System.out.println("更新完成"+count);*/
        List<HashMap<String, Object>> list = visitInfoDao.statistics();
        System.out.println(list.get(0).get("comment_num"));
        for (Object map : list.get(0).entrySet()) {
            System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
        }
    }

    @Resource
    private LoginServiceImpl loginService;

    @Test
    public void loginState() {
        /*VisitInfo visitInfo=new VisitInfo();
        visitInfo.setVisit_num(10);
        int count = visitInfoDao.updateVisitClickDate(visitInfo);//更新数据库
        System.out.println("更新完成"+count);*/
        List<HashMap<String, LoginInfo>> list = loginService.loginState();
        for (Object map : list.get(0).entrySet()) {
            System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
        }
    }

    @Resource
    private CommentInfoServiceImpl commentInfoService;

    @Test
    public void commentTest() {
        /*PageModel<CommentInfo> pageModel = commentInfoService.selectByPage("", 3, 5);
        System.out.println(pageModel.getData().size());*/
        /*CommentInfo commentInfo = commentInfoService.get(1);
        System.out.println(commentInfo.getArticleInfo().getTitle());*/
        List<HashMap<String, Object>> list = commentInfoService.seeReply(1);
        for (int i = 0; i < list.size(); i++) {
            System.out.println("第" + (i + 1) + "条");
            for (Object map : list.get(i).entrySet()) {
                System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
            }
        }

         /*   Iterator<HashMap<String, Object>> iterator=list.iterator();
        while (iterator.hasNext()){
            Map<String,Object> map= iterator.next();
            System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
        }*/
        /*for (Object map : list.entrySet()) {
            System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
        }*/

    }

    @Resource
    private ReplyInfoServiceImpl replyInfoService;

    @Test
    public void replyTest() {
        List<HashMap<String, Object>> list = replyInfoService.detailReply(1);
        for (int i = 0; i < list.size(); i++) {
            System.out.println("第" + (i + 1) + "条");
            for (Object map : list.get(i).entrySet()) {
                System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
            }
        }

         /*   Iterator<HashMap<String, Object>> iterator=list.iterator();
        while (iterator.hasNext()){
            Map<String,Object> map= iterator.next();
            System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
        }*/
        /*for (Object map : list.entrySet()) {
            System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
        }*/

    }

    public static List mapTransitionList(Map map) {
        List list = new ArrayList();
        Iterator iter = map.entrySet().iterator();  //获得map的Iterator
        while (iter.hasNext()) {
            Entry entry = (Entry) iter.next();
            list.add(entry.getValue());
        }
        return list;
    }

    @Resource
    private MessageInfoServiceImpl messageInfoService;

    @Resource
    private M_replyInfoServiceImpl m_replyInfoService;

    @Resource
    private FlinkInfoServiceImpl flinkInfoService;

    @Test
    public void messageTest() {
        PageModel pageModel = messageInfoService.selectByIndex(0, 5,"","");
        /*List<HashMap<String, Object>> list = pageModel.getData();
        String ids = "";
        for (int i = 0; i < list.size(); i++) {
            ids += list.get(i).get("message_id") + ",";
        }
        ids = ids.substring(0, ids.length() - 1);
        List<M_replyInfo> replyInfos = m_replyInfoService.selectByMessageId(ids);
        for (int i = 0; i < list.size(); i++) {
            List<M_replyInfo> list1 = new ArrayList<>();
            for (int j = 0; j < replyInfos.size(); j++) {
                if (Integer.parseInt(list.get(i).get("message_id").toString()) == replyInfos.get(j).getMessage_id()) {
                    list1.add(replyInfos.get(j));
                }
            }
            list.get(i).put("reply", list1);
        }
        pageModel.setData(list);*/
        System.out.println(pageModel);
    }

    @Resource
    private UserServiceImpl userService;

    @Test
    public void userTest() {
        /*PageModel pageModel = userService.selectByPage("", 1, 20, "user_id desc");
        List<HashMap<String, Object>> list = userService.seeUser(1);
        for (int i = 0; i < list.size(); i++) {
            System.out.println("第" + (i + 1) + "条");
            for (Object map : list.get(i).entrySet()) {
                System.out.println(((Map.Entry) map).getKey() + "     " + ((Map.Entry) map).getValue());
            }

        }*/
        Users users=new Users();
        /*users.setPortrait("15454");*/
        users.setNickname("23333");
        users.setRegister_time(new Date());
        userService.register(users);
        System.out.println(users.getUser_id());
    }

    @Test
    public void updateUser() {
        /*Users users = new Users();
        User_auths userAuths = new User_auths();
        users.setUser_id(1);
        users.setNickname("test昵称");
        users.setAutograph("test签名");
        users.setPortrait("test头像");
        userAuths.setAuths_id(1);
        userAuths.setQq_id("testqqid");
        userAuths.setAccess_token("testqqaaacess");
        userAuths.setQq_number("testqq_number");
        userAuths.setIdentifier("testidentifier");
        int i = userService.updateUser(users, userAuths);
        System.out.println("测试结果" + i);*/
        Users users = new Users();
        users.setNickname("test昵称111");
        users.setRegister_time(new Date());
        users.setPortrait("2326asdf");
        int i = userService.register(users);
        System.out.println("影响行数：\t" + i + "主键ID：" + users.getUser_id());
    }

    @Test
    public void sendMag() throws ClientException, InterruptedException {
        /*//发短信
        SendSmsResponse response = SendMsg.sendSms(CreateCode());
        Thread.sleep(3000L);

        QuerySendDetailsResponse querySendDetailsResponse = SendMsg.querySendDetails(response.getBizId());
        for (QuerySendDetailsResponse.SmsSendDetailDTO smsSendDetailDTO : querySendDetailsResponse.getSmsSendDetailDTOs()) {
            System.out.println("短信发送成功");
            System.out.println("Content=" + smsSendDetailDTO.getContent());
            System.out.println("PhoneNum=" + smsSendDetailDTO.getPhoneNum());
            System.out.println("SendDate=" + smsSendDetailDTO.getSendDate());
        }*/

    }

    @Resource
    LikeService likeService;

    @Test
    public void redis(){
        /*long likeCount = likeService.like("192.168.1.1", 1, 3);
        System.out.println(likeCount);*/
        /*System.out.println(likeService.updateEnjoy());*/
        /*List list = likeService.messageIds("113.251.9.60");
        System.out.println(list.size());*/
        /*System.out.println(QueryHelper.ip());*/
        System.out.println(QueryHelper.getRealIp());
    }



}

