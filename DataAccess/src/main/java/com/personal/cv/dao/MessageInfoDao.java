package com.personal.cv.dao;

import com.personal.cv.entity.MessageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MessageInfoDao extends BaseDao<MessageInfo> {

    List select(@Param("pattern") String pattern, @Param("firstResult") int firstResult, @Param("maxSize") int maxSize);

    List selectByIndex(@Param("firstResult") int firstResult, @Param("maxSize") int maxSize, @Param("sort") String sort, @Param("author") String author);

    List selectByUser(@Param("firstResult") int firstResult, @Param("maxSize") int maxSize, @Param("userId") int userId);

    int selectCountByUser(int userId);

    int selectByAuthorCount();

    /**
     * 查看留言详情
     */
    List seeMessage(@Param("id") int message_id);

    /**
     * 查看留言回复
     */
    List seeReply(@Param("id") int message_id);

    int delMessage(@Param("userId") int userId, @Param("messageId") int messageId);

}
