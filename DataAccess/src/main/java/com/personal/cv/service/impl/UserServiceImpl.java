package com.personal.cv.service.impl;

import com.aliyun.oss.OSSClient;
import com.lang.PageModel;
import com.personal.cv.dao.UsersDao;
import com.personal.cv.entity.User_auths;
import com.personal.cv.entity.Users;
import com.personal.cv.service.UserService;
import com.personal.cv.util.OSSClientUtil;
import com.personal.cv.util.QueryHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UsersDao usersDao;

    @Override
    public Users get(int id) {
        return usersDao.get(id);
    }

    @Override
    public int selectCount(String pattern) {
        return usersDao.selectCount(pattern);
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
        List list = usersDao.select(pattern, (pageNo - 1) * pageSize, pageSize, Sort);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public int updateEnable(int id) {
        return usersDao.enable(id);
    }

    @Override
    public int updateDisEnable(int id) {
        return usersDao.disEnable(id);
    }

    @Override
    public int updateUser(Users users, User_auths user_auths) {
        return usersDao.updateUser(users, user_auths);
    }

    @Override
    public int delete(String ids) {
        return usersDao.delete(ids.split(","));
    }

    @Override
    public int save(Users users) {
        return usersDao.save(users);
    }

    @Override
    public int register(Users users) {
        return usersDao.register(users);
    }

    @Override
    public List seeUser(int user_id) {
        return usersDao.seeUser(user_id);
    }

    @Override
    public int selectByNickName(String nickname) {
        return usersDao.selectByNickName(nickname);
    }

    @Override
    public Users selectByQQid(String openId) {
        return usersDao.selectByQQid(openId);
    }

    @Override
    public List<Map<String, Object>> getByUser(int userId) {
        return usersDao.getByUser(userId);
    }

    @Override
    public int editByUser(Users users) {
        if (users.getPortrait() != "" && users.getPortrait() != null) {
            String imgFilePath = QueryHelper.GenerateImage(users.getPortrait());
            if(imgFilePath==null){
                return 0;
            }
            try {
                OSSClientUtil ossClient = new OSSClientUtil();
                ossClient.uploadImg2Oss(imgFilePath);
                String imgUrl = ossClient.getImgUrl(imgFilePath);
                String[] split = imgUrl.split("\\?");
                users.setPortrait(split[0]);
            } catch (Exception e) {
                e.printStackTrace();
                return 0;
            }
        }
        return usersDao.editByUser(users);
    }
}
