package com.personal.cv.service;

import com.personal.cv.entity.User_auths;

public interface User_authService {

    int save(User_auths user_auths);

    User_auths selectByIdentifier(User_auths user_auths);

    int existIdentifier(String identifier);

    int existQQid(String openID);
}
