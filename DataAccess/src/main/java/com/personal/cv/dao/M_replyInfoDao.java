package com.personal.cv.dao;

import com.personal.cv.entity.M_replyInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface M_replyInfoDao extends BaseDao<M_replyInfo> {

    List detailReply(@Param("id") int reply_id);

    List selectByMessageId(@Param("ids") String[] ids);

    int countByMessage(@Param("id") int message_id);

    List selectByPage(@Param("firstResult") int firstResult, @Param("maxSize") int maxSize,@Param("id") int message_id);

    int delReply(@Param("userId") int userId, @Param("reply_id") int reply_id);

    /*前台方法*/
    List selectByUser(@Param("firstResult") int firstResult, @Param("maxSize") int maxSize, @Param("userId") int userId);

    int selectCountByUser(int userId);
}
