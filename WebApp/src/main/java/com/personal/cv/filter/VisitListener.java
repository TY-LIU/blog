package com.personal.cv.filter;

import com.personal.cv.service.impl.EnjoyInfoServiceImpl;
import com.personal.cv.service.impl.LikeService;
import com.personal.cv.service.impl.VisitInfoServiceImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Created by Administrator on 2017/1/6.
 */
public class VisitListener implements ServletContextListener {

    private static ApplicationContext applicationContext = null;
    private static LikeService likeService;

    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("=======================开始监听=======================");
        //System.out.println("ServletContext对象创建");
        //初始化 ApplicationContext  对象
        applicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(sce.getServletContext());
        //设置点击量
        sce.getServletContext().setAttribute("increaseCountMap", new ConcurrentHashMap< String, AtomicInteger>());
        //创建缓存
        /*likeService=(LikeService) webApplicationContext.getBean("likeService");
        if(likeService.buildCache()){
            System.out.println("redis缓存创建成功");
        }else{
            System.out.println("redis缓存创建失败");
            return;
        }*/

    }

    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("=======================结束监听=======================");
        //System.out.println("ServletContext对象销毁");
        //获取业务层service Bean
        try {
            WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
            VisitInfoServiceImpl visitInfoService = (VisitInfoServiceImpl) webApplicationContext.getBean("visitInfoServiceImpl");
            visitInfoService.updateVisitClickDate();//更新点击量
            sce.getServletContext().removeAttribute("increaseCountMap");//移除全局变量--点击量
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("结束错误");
        }
    }
    //用于那些非控制层中使用直接获取到的Spring Bean的获取，如接口
    public static ApplicationContext getApplicatonContext() {
        return applicationContext;
    }

}