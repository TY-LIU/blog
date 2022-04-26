package com.personal.cv.controller;

import com.personal.cv.entity.ColumnInfo;
import com.personal.cv.service.impl.ColumnInfoServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/columnInfo")
public class ColumnInfoController {
    @Resource
    private ColumnInfoServiceImpl columnInfoService;

    @RequestMapping(value = "/saveColumn")
    @ResponseBody
    public String saveColumn(ColumnInfo columnInfo, String column_name, String alias) {
        Date date = new Date();
        columnInfo.setColumn_name(column_name);
        columnInfo.setAlias(alias);
        columnInfo.setSet_time(date);
        columnInfo.setDelete_state(0);
        int num = columnInfoService.save(columnInfo);
        return result(num);
    }

    @RequestMapping(value = "/deleteColumn")
    @ResponseBody
    public String deleteColumn(String column_id) {
        int num = columnInfoService.delete(column_id);
          return result(num);
    }

    @RequestMapping(value = "/update-category")
    public String jumpPage(RedirectAttributes attributes, @RequestParam("column_id") int column_id, HttpServletRequest request){
        if(column_id>0){
            ColumnInfo columnInfo = columnInfoService.get(column_id);
            request.getSession().removeAttribute("org.springframework.web.servlet.support.SessionFlashMapManager.FLASH_MAPS");
            attributes.addFlashAttribute("columnInfo",columnInfo);
            return "/WEB-INF/page/update-category";
        }else{
            return "/WEB-INF/page/category";
        }

    }

    @RequestMapping(value = "/updateColumn")
    @ResponseBody
    public String updateColumn(ColumnInfo columnInfo, int column_id, String column_name, String alias) {
        columnInfo.setColumn_id(column_id);
        columnInfo.setColumn_name(column_name);
        columnInfo.setAlias(alias);
        int num = columnInfoService.update(columnInfo);
        return result(num);
    }

    @RequestMapping(value = "/selectColumn")
    @ResponseBody
    public List<ColumnInfo> selectColumn() {
        try {
            List<ColumnInfo> list = columnInfoService.selectAll();
            return list;
        }catch (Exception e){
            System.out.println(e.getMessage());
            return null;
        }

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
