package com.personal.cv.service.impl;

import com.personal.cv.dao.User_authsDao;
import com.personal.cv.entity.User_auths;
import com.personal.cv.service.User_authService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class Users_authServiceImpl implements User_authService {
    @Resource
    private User_authsDao users_authsDao;

    @Override
    public int save(User_auths user_auths) {
        return users_authsDao.save(user_auths);
    }

    @Override
    public User_auths selectByIdentifier(User_auths user_auths) {
        return users_authsDao.selectByIdentifier(user_auths);
    }

    @Override
    public int existIdentifier(String identifier) {
        return users_authsDao.existIdentifier(identifier);
    }

    @Override
    public int existQQid(String openID) {
        return users_authsDao.existQQid(openID);
    }
}
