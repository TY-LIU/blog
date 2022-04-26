package com.personal.cv.service.impl;

import com.personal.cv.dao.VisitInfoDao;
import com.personal.cv.entity.VisitInfo;
import com.personal.cv.service.VisitInfoService;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.annotation.Resource;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class VisitInfoServiceImpl implements VisitInfoService {
    @Resource
    private VisitInfoDao visitInfoDao;


    /**
     * 更新今日点击量
     *
     * */
    @Override
    public void updateVisitClickDate() {
        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
        ConcurrentHashMap<String, AtomicInteger> countMap = (ConcurrentHashMap<String, AtomicInteger>) webApplicationContext.getServletContext().getAttribute("increaseCountMap");
        Iterator it = countMap.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, AtomicInteger>me = (Map.Entry<String, AtomicInteger>) it.next();
            VisitInfo visitInfo=new VisitInfo();
            visitInfo.setVisit_num(me.getValue().intValue());
            visitInfoDao.updateVisitClickDate(visitInfo);//更新今日点击量
            System.out.println("已更新今日浏览量");
        }
        webApplicationContext.getServletContext().setAttribute("increaseCountMap", new ConcurrentHashMap<String, AtomicInteger>());
    }

    /**
     * 更新昨日点击量
     *
     * */
    @Override
    public void updateYetVisitClickDate() {
        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
        ConcurrentHashMap<String, AtomicInteger> countMap = (ConcurrentHashMap<String, AtomicInteger>) webApplicationContext.getServletContext().getAttribute("increaseCountMap");
        Iterator it = countMap.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, AtomicInteger>me = (Map.Entry<String, AtomicInteger>) it.next();
            VisitInfo visitInfo=new VisitInfo();
            visitInfo.setVisit_num(me.getValue().intValue());
            visitInfoDao.updateYetVisitClickDate(visitInfo);//更新昨日点击量
            System.out.println("昨日浏览量更已更新");
        }
        webApplicationContext.getServletContext().setAttribute("increaseCountMap", new ConcurrentHashMap<String, AtomicInteger>());
    }

    @Override
    public void insertVisitClickDate() {
        visitInfoDao.insertVisitClickDate();//添加明日点击量
    }

    @Override
    public List statistics() {
        return visitInfoDao.statistics();
    }
}
