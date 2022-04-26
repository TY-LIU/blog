package com.personal.cv.dao;

import com.personal.cv.entity.ReplyInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReplyInfoDao extends BaseDao<ReplyInfo> {
    List detailReply(@Param(value = "id") int reply_id);
}
