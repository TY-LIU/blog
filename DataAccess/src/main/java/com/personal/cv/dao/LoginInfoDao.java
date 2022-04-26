package com.personal.cv.dao;

import com.personal.cv.entity.LoginInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LoginInfoDao extends BaseDao<LoginInfo> {

    List loginState();

    int deleteByCurrent(@Param("id") int id);

    int deleteAll();
}
