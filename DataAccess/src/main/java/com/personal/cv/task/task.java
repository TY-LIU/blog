package com.personal.cv.task;

import com.personal.cv.service.impl.LikeService;
import com.personal.cv.service.impl.VisitInfoServiceImpl;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Date;

@Component
public class task {

    @Resource
    private VisitInfoServiceImpl visitInfoService;
    @Resource
    private LikeService likeService;

    @Scheduled(cron="0 0 0 * * ? ") //凌晨
    public void insertAndUpdate(){
        try{
            System.out.println(new Date()+"========================更新/添加浏览量数据========================");
            visitInfoService.updateYetVisitClickDate();//更新昨日
            visitInfoService.insertVisitClickDate();//添加今日
            likeService.updateEnjoy();//更新点赞
        }catch (Exception e){
            System.out.println("========================更新/添加浏览量数据失败========================");
            e.printStackTrace();
        }
    }

}
