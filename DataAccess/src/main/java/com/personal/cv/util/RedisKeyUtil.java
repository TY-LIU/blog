package com.personal.cv.util;

public class RedisKeyUtil {
    private static String SPLIT = ":";
    private static String BIZ_LIKE = "LIKE";
    private static String BIZ_DISLIKE = "DISLIKE";

    /**
     * 产生key:如在newsId为2上的咨询点赞后会产生key: LIKE:ENTITY_NEWS:2
     *
     * @param entityId
     * @param entityType
     * @return
     */
    public static String getLikeKey(int entityId, int entityType) {
        return BIZ_LIKE + SPLIT + String.valueOf(entityType) + SPLIT + String.valueOf(entityId);
    }

    /**
     * 取消赞:如在newsId为2上的资讯取消点赞后会产生key: DISLIKE:ENTITY_NEWS:2
     *
     * @param entityId
     * @param entityType
     * @return
     */
    public static String getDisLikeKey(int entityId, int entityType) {
        return BIZ_DISLIKE + SPLIT + String.valueOf(entityType) + SPLIT + String.valueOf(entityId);
    }
}
