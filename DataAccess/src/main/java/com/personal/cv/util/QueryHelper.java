package com.personal.cv.util;

import com.alibaba.fastjson.JSON;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.OperatingSystem;
import eu.bitwalker.useragentutils.UserAgent;
import eu.bitwalker.useragentutils.Version;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class QueryHelper {
    /**
     * txt|jsonp|xml
     */
    public static String DATATYPE = "text";
    public static UserAgent userAgent;
    public static Map map;

    /**
     * api.ip138.com提供的接口,需要提供IP，返回IP市级归属地以及网络运营商,付费
     *
     * @param urlString API接口
     * @param token     密匙
     */
    public static String get(String urlString, String token) {
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
            conn.setRequestProperty("token", token);
            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                StringBuilder builder = new StringBuilder();
                BufferedReader br = new BufferedReader(
                        new InputStreamReader(conn.getInputStream(), "utf-8"));
                for (String s = br.readLine(); s != null; s = br
                        .readLine()) {
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

    public static String queryIP(String ip) {
        String url = "http://api.ip138.com/query/?ip=" + ip + "&datatype=" + DATATYPE;
        String token = "8945e53c44d7f772f278d294674081b3";
        return get(url, token);
    }

    /**
     * @param urlString API接口
     */
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
        return "{\"code\":\"error\"}";
    }
    /**
     *[http://ip.taobao.com/service/getIpInfo2.php?ip=myip]提供的接口，不需要提供IP，返回IP所属国家以及网络运营商，免费
     *[http://ip.chinaz.com/getip.aspx]上面淘宝的炸了不稳定，换个chinaz的
     * */
    public static Map queryIP(HttpServletRequest request) {
        String url = "http://ip.taobao.com/service/getIpInfo2.php?ip="+QueryHelper.getClientIpAddr(request)+"";
        try{
            String builder = get(url);
            Map maps = (Map) JSON.parse(builder);
            Map data = (Map) maps.get("data");
            return data;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 获取浏览器信息
     */
    public static String browser(HttpServletRequest request) {
        Browser browser = userAgent.getBrowser();
        Version version = browser.getVersion(request.getHeader("User-Agent"));
        String bro = browser.getName() + "/" + version.getVersion();
        return bro;
    }

    /**
     * 获取操作系统信息
     */
    public static String os(HttpServletRequest request) {
        String UA = request.getHeader("User-Agent");
        OperatingSystem os = userAgent.getOperatingSystem();
        String bit = "";
        if (os.getDeviceType().getName() == "Computer") {
            int b_index = UA.indexOf(";") + 1;
            bit = UA.substring(b_index, b_index + 6);
            bit = bit.replace("WOW", "Bit");
        } else if (os.getDeviceType().getName() == "Mobile") {
                    /*获取机型*/
            Pattern pattern = Pattern.compile(";\\s?(\\S*?\\s?\\S*?)\\s?(Build)?/");
            Matcher matcher = pattern.matcher(UA);
            if (matcher.find()) {
                bit = matcher.group(1).trim();
            }
        }
        String os_info = os.getName() + " " + bit;
        return os_info;
    }

    /**
     * 获取IP
     */
    public static String ip(HttpServletRequest request) {
        map=QueryHelper.queryIP(request);
        if(map==null){
            return QueryHelper.getLocalAddress();
        }
        String ip = map.get("ip").toString();
        return ip;
    }

    /**
     * 获取IP归属地
     */
    public static String area() {
        if(map==null){
            return "chongqing";
        }
        String area = map.get("country").toString() + map.get("area").toString() + map.get("city").toString();
        return area;
    }

    /**
     *获取本地ip
     *
     */
    public static String getLocalAddress(){
        String ip;
        try {
            ip = InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            ip="192.168.1.1";
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return ip;
    }

    /**
     * 异地登陆 TODO 正则匹配'重庆'
     */
    public static int state() {
        int state = 0;
        if (!"重庆".equals(map.get("city").toString()))
            state = 1;
        return state;
    }

    /**
     * 获取openID
     *
     * @param accessToken 传过来的值为登录qq后返回的accessToken
     */
    public static String judgeOpenID(String accessToken) {
        String url = "https://graph.qq.com/oauth2.0/me?access_token=" + accessToken + "";
        String builder = get(url);
        if (builder.equals("error")) {
            return "error";
        }
        builder = builder.substring(builder.indexOf("{"), builder.lastIndexOf("}") + 1);
        Map maps = (Map) JSON.parse(builder);
        String openid = maps.get("openid").toString();
        /*String openid = data.get("openid").toString();*/
        return openid;
    }


    /**
     *base64字符串转化成图片
     * @param imgStr base64字符
     */
    public static String GenerateImage(String imgStr){   //对字节数组字符串进行Base64解码并生成图片
        if (imgStr == null) //图像数据为空
            return null;
        BASE64Decoder decoder = new BASE64Decoder();
        try
        {
            imgStr=imgStr.replace("data:image/jpeg;base64,","");
            //Base64解码
            byte[] b = decoder.decodeBuffer(imgStr);
            for(int i=0;i<b.length;++i){
                if(b[i]<0)
                {//调整异常数据
                    b[i]+=256;
                }
            }
            try {
                if (!(new File("D:/ossUpload/img/").isDirectory())) {
                    new File("D:/ossUpload/img/").mkdirs();
                }
            } catch (SecurityException e) {
                e.printStackTrace();
            }
            //生成jpeg图片
            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            String imgFilePath = "D:/ossUpload/img/"+uuid+".jpg";//新生成的图片
            OutputStream out = new FileOutputStream(imgFilePath);
            out.write(b);
            out.flush();
            out.close();
            return imgFilePath;
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }


    /**
     * Gets the client ip addr.
     *
     * @param request the request
     * @return the client ip addr
     */
    public static String getClientIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        try {
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("Proxy-Client-IP");
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("WL-Proxy-Client-IP");
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getRemoteAddr();
            }
        }catch (Exception e){
            e.printStackTrace();
            ip="192.168.1.1";
        }
        return ip;
    }

    /**
     * Gets the real ips.
     *
     * @return the real ips
     */
    public static List<String> getRealIps() {
        List<String> ips = new ArrayList<String>();
        String localip = null;// 本地IP，如果没有配置外网IP则返回它
        String netip = null;// 外网IP
        Enumeration<NetworkInterface> netInterfaces;
        try {
            netInterfaces = NetworkInterface.getNetworkInterfaces();
        } catch (SocketException e) {
            return null;
        }
        InetAddress ip = null;
        boolean finded = false;// 是否找到外网IP
        while (netInterfaces.hasMoreElements() && !finded) {
            NetworkInterface ni = netInterfaces.nextElement();
            Enumeration<InetAddress> address = ni.getInetAddresses();
            while (address.hasMoreElements()) {
                ip = address.nextElement();
                if (!ip.isSiteLocalAddress() && !ip.isLoopbackAddress() && ip.getHostAddress().indexOf(":") == -1) {// 外网IP
                    netip = ip.getHostAddress();
                    ips.add(netip);
                    finded = true;
                    break;
                } else if (ip.isSiteLocalAddress() && !ip.isLoopbackAddress() && ip.getHostAddress().indexOf(":") == -1) {// 内网IP
                    localip = ip.getHostAddress();
                    ips.add(localip);
                }
            }
        }
        return ips;
    }

    /**
     * Gets the real ip.
     *
     * @return the real ip
     */
    public static String getRealIp() {
        return getRealIps().iterator().next();
    }

}
