package com.personal.cv.service.impl;

import com.lang.PageModel;
import com.personal.cv.dao.LoginInfoDao;
import com.personal.cv.entity.LoginInfo;
import com.personal.cv.service.LoginInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class LoginServiceImpl implements LoginInfoService {
    @Resource
    private LoginInfoDao loginInfoDao;

    @Override
    public int save(LoginInfo loginInfo) {
        return loginInfoDao.save(loginInfo);
    }

    @Override
    public List loginState() {
        return loginInfoDao.loginState();
    }

    @Override
    public int selectCount(String pattern) {
        return loginInfoDao.selectCount(pattern);
    }

    @Override
    public PageModel selectByPage(String pattern, int pageNo, int pageSize, String Sort) {
        PageModel pageModel = new PageModel<>();
        pageSize = pageSize == 0 ? 10 : pageSize;
        pageModel.setPageSize(pageSize);
        pattern = "%" + (pattern == null ? "" : pattern) + "%";
        int count = selectCount(pattern);
        pageModel.setTotalRecords(count);
        pageNo = pageModel.getTotalPages() < pageNo ? pageModel.getTotalPages() : pageNo;
        pageNo = pageNo == 0 ? 1 : pageNo;
        pageModel.setPageNo(pageNo);
        if (count == 0)
            return pageModel;
        List list = loginInfoDao.select(pattern, (pageNo - 1) * pageSize, pageSize ,Sort);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public int delete(String ids) {
        return loginInfoDao.delete(ids.split(","));
    }

    @Override
    public int deleteByCurrent(int user_id) {
        return loginInfoDao.deleteByCurrent(user_id);
    }

    @Override
    public int deleteAll() {
        return loginInfoDao.deleteAll();
    }
}
