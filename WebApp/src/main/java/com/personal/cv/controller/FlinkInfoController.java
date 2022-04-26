package com.personal.cv.controller;

import com.lang.PageModel;
import com.personal.cv.entity.FlinkInfo;
import com.personal.cv.service.impl.FlinkInfoServiceImpl;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;

@Controller
@RequestMapping("/flink")
public class FlinkInfoController {
    private static Logger logger = Logger.getLogger(FlinkInfoController.class);

    @Resource
    private FlinkInfoServiceImpl flinkInfoService;

    @RequestMapping(value = "/save")
    @ResponseBody
    public String saveNotice(FlinkInfo flinkInfo, String flink_name, String flink_icon, String flink_url, String describe) {
        logger.info("添加友链");
        Date date = new Date();
        flinkInfo.setFlink_name(flink_name);
        flink_icon=flink_icon==""||flink_icon==null?"#":flink_icon;
        flinkInfo.setFlink_icon(flink_icon);
        flinkInfo.setFlink_url(flink_url);
        flinkInfo.setDescribe(describe);
        flinkInfo.setPut_time(date);
        int num = flinkInfoService.save(flinkInfo);
        return result(num);
    }

    @RequestMapping(value = "/deleteFlink")
    @ResponseBody
    public String deleteNotice(String ids) {
        logger.info("删除友链");
        int num = flinkInfoService.delete(ids);
        return result(num);
    }

    @RequestMapping(value = "/updateFlink")
    @ResponseBody
    public String updateNotice(FlinkInfo flinkInfo, String flink_name, String flink_icon, String flink_url, String describe) {
        logger.info("修改友链");
        flinkInfo.setFlink_name(flink_name);
        flinkInfo.setFlink_icon(flink_icon);
        flinkInfo.setFlink_url(flink_url);
        flinkInfo.setDescribe(describe);
        int num = flinkInfoService.update(flinkInfo);
        return result(num);
    }

    @RequestMapping(value = "/selectFlink")
    @ResponseBody
    public PageModel selectMessage(String pattern, int pageNo, int pageSize, String Sort) {
        logger.info("分页查询友链");
        PageModel pageModel;
        try {
            pageModel = flinkInfoService.selectByPage(pattern, pageNo, pageSize, Sort);
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        return pageModel;
    }

    @RequestMapping(value = "/detailFlink")
    @ResponseBody
    public FlinkInfo detailNotice(int flink_id) {
        logger.info("查看友链详情");
        FlinkInfo flinkInfo = flinkInfoService.get(flink_id);
        return flinkInfo;
    }

    public String result(int num) {
        if (num > 0)
            return "true";
        else if (num <= 0)
            return "false";
        else
            return "error";
    }

}
