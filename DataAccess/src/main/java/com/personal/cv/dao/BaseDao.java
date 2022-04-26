package com.personal.cv.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Administrator on 2016/12/22.
 */
public interface BaseDao<T> {

    int save(T t);
    int update(T t);
    int delete(@Param("ids") String[] ids);
    int selectCount(@Param("pattern") String pattern);
    T get(int id);
    int existData(int id);

    /**
     * @param pattern 模糊查询数据
     * @param firstResult 计算出从什么位置查询 (pageNo - 1) * pageSize
     * @param maxSize 查询条数
     * @param Sort 排序数据
     * */
    List<T> select(@Param("pattern") String pattern, @Param("firstResult") int firstResult, @Param("maxSize") int maxSize, @Param("Sort") String Sort);
}
