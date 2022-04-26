package com.personal.cv.controller;

import com.aliyuncs.dysmsapi.model.v20170525.QuerySendDetailsResponse;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.personal.cv.util.CreateCode;
import com.personal.cv.util.SendMsg;
import org.apache.http.HttpRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Timer;
import java.util.TimerTask;

import static com.personal.cv.util.CreateCode.CreateCode;

@Controller
@RequestMapping("/verifi")
public class VerifiController {

    private static Logger logger = Logger.getLogger(MessageInfoController.class);
    public int num = 59;
    public int timeOut = 120;
    boolean flag = true;

    /**
     *  发送验证码
     *
     * @param phoneNum 电话号码
     */
    @RequestMapping(value = "/sendMag")
    @ResponseBody
    public String sendMag(HttpServletRequest request, String phoneNum) throws ClientException, InterruptedException {
        logger.info("发送短信");
        SendSmsResponse response = null;
        SendMsg.PhoneNumbers = phoneNum;
        if (flag) {
            try {
                System.out.println("发送验证码：" + CreateCode());
                num = 59;
                response = SendMsg.sendSms(CreateCode.code);
            } catch (Exception e) {
                System.out.println(e.fillInStackTrace());
            }
            timer();
            flag = false;
        } else {
            if (num > 1) {
                return "wait";
            } else {
                try {
                    System.out.println("发送验证码：" + CreateCode());
                    response = SendMsg.sendSms(CreateCode.code);
                    num = 59;
                } catch (Exception e) {
                    System.out.println(e.fillInStackTrace());
                }
                timer();
            }
        }
        HttpSession session = request.getSession();
        session.setAttribute("code", CreateCode.code);
        System.out.println("短信接口返回的数据----------------");
        System.out.println("Code=" + response.getCode());
        System.out.println("Message=" + response.getMessage());
        Thread.sleep(3000L);
        QuerySendDetailsResponse querySendDetailsResponse = SendMsg.querySendDetails(response.getBizId());
        QuerySendDetailsResponse.SmsSendDetailDTO smsSendDetailDTO = querySendDetailsResponse.getSmsSendDetailDTOs().get(0);
        System.out.println("短信发送成功"+querySendDetailsResponse.getSmsSendDetailDTOs());
        System.out.println("Content=" + smsSendDetailDTO.getContent());
        System.out.println("PhoneNum=" + smsSendDetailDTO.getPhoneNum());
        System.out.println("SendDate=" + smsSendDetailDTO.getSendDate());
        codeOver(session);
        return "true";
    }

    /*后台与前端同步*/
    public void timer() {
        Timer t = new Timer();
        t.schedule(new TimerTask() {
            @Override
            public void run() {
                if (num == 0) {
                    t.cancel();
                }
                num--;
            }
        }, 0, 1000);
    }

    /*短信过期*/
    public void codeOver(HttpSession session){
        Timer t = new Timer();
        t.schedule(new TimerTask() {
            @Override
            public void run() {
                if(timeOut==0){
                    session.setAttribute("code", "timeOut");
                    t.cancel();
                    timeOut=120;
                }
                timeOut--;
            }
        },0,1000);
    }

}
