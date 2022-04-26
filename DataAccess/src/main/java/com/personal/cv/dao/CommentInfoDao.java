package com.personal.cv.dao;

import com.personal.cv.entity.CommentInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentInfoDao extends BaseDao<CommentInfo>{
    List seeReply(@Param(value = "id") int comment_id);
}
