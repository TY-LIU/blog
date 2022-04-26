package com.personal.cv.util;

import com.personal.cv.service.impl.VisitInfoServiceImpl;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpServletRequest;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

public class VisitInfoUtil {

    WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
    //获取业务层service Bean
    VisitInfoServiceImpl visitInfoService = (VisitInfoServiceImpl) webApplicationContext.getBean("visitInfoServiceImpl");

    static ConcurrentHashMap<String, AtomicInteger> increaseCountMap = new ConcurrentHashMap<>();

    public void calClickRate(HttpServletRequest request) {
        String key="pageviews";
        increaseCountMap = (ConcurrentHashMap<String, AtomicInteger>) request.getSession().getServletContext().getAttribute("increaseCountMap");
        Iterator it = increaseCountMap.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, AtomicInteger> me = (Map.Entry<String, AtomicInteger>) it.next();
            increaseCountMap.putIfAbsent(key, new AtomicInteger(me.getValue().getAndIncrement()));
        }
        if (!it.hasNext()) {
            increaseCountMap.putIfAbsent(key, new AtomicInteger(1));
        }
        try{
            if(increaseCountMap.get("pageviews").intValue()>=100)
                visitInfoService.updateVisitClickDate();
            else
                request.getSession().getServletContext().setAttribute("increaseCountMap", increaseCountMap);
        }catch (Exception e){
            e.printStackTrace();
            request.getSession().getServletContext().setAttribute("increaseCountMap", increaseCountMap);
        }
    }
}
