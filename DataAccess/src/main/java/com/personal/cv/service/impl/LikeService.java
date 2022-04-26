package com.personal.cv.service.impl;


import com.personal.cv.entity.EnjoyInfo;
import com.personal.cv.util.RedisKeyUtil;
import org.springframework.stereotype.Service;
import sun.java2d.cmm.PCMM;

import javax.annotation.Resource;
import java.util.*;

@Service
public class LikeService {

    @Resource
    JedisAdapter jedisAdapter;
    @Resource
    EnjoyInfoServiceImpl enjoyInfoService;


    /**
     * 点赞：即当前用户点赞后，被点赞用户的like集合中就会加上一个该点赞的用户信息
     *
     * @param ip
     * @param entityType
     * @param entityId
     * @return
     */
    public long like(String ip, int entityType, int entityId) {
        //在当前news上点赞后获取key:   LIKE:ENTITY_NEWS:2
        String likeKey = RedisKeyUtil.getLikeKey(entityId, entityType);
        //在喜欢集合中添加当前操作用户的ip(即当前用户点赞后，被点赞用户的like集合中就会加上一个点赞的用户信息)
        jedisAdapter.sadd(likeKey, ip);
        String disLikeKey = RedisKeyUtil.getDisLikeKey(entityId, entityType);
        jedisAdapter.srem(disLikeKey, ip);
        //返回点赞数量
        return jedisAdapter.scard(likeKey);
    }

    /**
     * 取消赞 ：即当前用户取消赞后，从like集合中删除该点赞信息
     *
     * @param ip
     * @param entityType
     * @param entityId
     * @return
     */
    public long disLike(String ip, int entityType, int entityId) {

        //从赞中删除
        String likeKey = RedisKeyUtil.getLikeKey(entityId, entityType);
        jedisAdapter.srem(likeKey, ip);
        //返回点赞数量
        return jedisAdapter.scard(likeKey);
    }

    /**
     * 检测是否存在缓存中
     */
    public boolean exist(String ip, int entityType, int entityId) {
        String likeKey = RedisKeyUtil.getLikeKey(entityId, entityType);
        boolean flag = jedisAdapter.sismember(likeKey, ip);
        return flag;
    }

    /**
     * 创建缓存
     */
    public boolean buildCache() {
        List<HashMap<String, Object>> list = enjoyInfoService.selectAll();
        try {
            for (int i = 0; i < list.size(); i++) {
                for (Object map : list.get(i).entrySet()) {
                    jedisAdapter.sadd(((Map.Entry) map).getKey().toString(), ((Map.Entry) map).getValue().toString());
                }

            }
            return true;
        } catch (Exception e) {
            e.fillInStackTrace();
            return false;
        }
    }

    /**
     * 将缓存更新到数据库
     */
    public boolean updateEnjoy() {
        Map map = jedisAdapter.getAllKey();
        /*for (Object s : map.keySet()) {
            System.out.println("key : " + s + " value : " + map.get(s));
        }*/
        try {
            enjoyInfoService.saveMap(map);
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.fillInStackTrace();
            return false;
        }
    }

    /**
     * 获取当前IP点过赞的留言
     * */
    public List messageIds(String ip) {
        List<String> messageIds = new ArrayList();
        Map<String,Set<String>> map = jedisAdapter.getAllKey();
        for (Object s : map.keySet()) {
            Set set = map.get(s);
            Iterator it = set.iterator();
            while (it.hasNext()) {
                if (it.next().equals(ip)){
                    String id=s.toString();
                    id=id.substring(id.lastIndexOf(":")+1,id.length());
                    messageIds.add(id);
                }
            }
        }
        return messageIds;
    }

    /**
     * 清空缓存
     */
    public String flushDB() {
        return jedisAdapter.flushDB();
    }
}
