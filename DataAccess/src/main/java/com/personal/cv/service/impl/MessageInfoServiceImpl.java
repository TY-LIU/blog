package com.personal.cv.service.impl;

import com.lang.PageModel;
import com.personal.cv.dao.MessageInfoDao;
import com.personal.cv.entity.M_replyInfo;
import com.personal.cv.entity.MessageInfo;
import com.personal.cv.entity.Users;
import com.personal.cv.service.MessageInfoService;
import com.personal.cv.util.QueryHelper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class MessageInfoServiceImpl implements MessageInfoService {

    @Resource
    private MessageInfoDao messageInfoDao;
    @Resource
    private M_replyInfoServiceImpl m_replyInfoService;

    @Override
    public int selectCount(String pattern) {
        return messageInfoDao.selectCount(pattern);
    }

    @Override
    public int selectByAuthorCount() {
        return messageInfoDao.selectByAuthorCount();
    }

    @Override
    public int selectCountByUser(int userId) {
        return messageInfoDao.selectCountByUser(userId);
    }

    @Override
    public PageModel selectByPage(String pattern, int pageNo, int pageSize) {
        PageModel pageModel = new PageModel<>();
        pageSize = pageSize == 0 ? 10 : pageSize;
        pageModel.setPageSize(pageSize);
        pattern = "%" + (pattern == null ? "" : pattern) + "%";
        int count = selectCount(pattern);
        pageModel.setTotalRecords(count);
        pageNo = pageModel.getTotalPages() < pageNo ? pageModel.getTotalPages() : pageNo;
        pageNo = pageNo == 0 ? 1 : pageNo;
        pageModel.setPageNo(pageNo);
        if (count == 0)
            return pageModel;
        List list = messageInfoDao.select(pattern, (pageNo - 1) * pageSize, pageSize);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public PageModel selectByIndex(int pageNo, int pageSize,String sort,String author) {
        int count=0;
        PageModel pageModel = new PageModel<>();
        pageSize = pageSize == 0 ? 10 : pageSize;
        pageModel.setPageSize(pageSize);
        if(author.equals("true"))
            count = selectByAuthorCount();
        else
            count = selectCount("%%");
        sort = sort==""||sort==null?"enjoy desc":sort;
        pageModel.setTotalRecords(count);
        pageNo = pageModel.getTotalPages() < pageNo ? pageModel.getTotalPages() : pageNo;
        pageNo = pageNo == 0 ? 1 : pageNo;
        pageModel.setPageNo(pageNo);
        if (count == 0)
            return pageModel;
        List<HashMap<String, Object>> list = messageInfoDao.selectByIndex((pageNo - 1) * pageSize, pageSize,sort,author);
        String ids = "";
        for (int i = 0; i < list.size(); i++) {
            ids += list.get(i).get("message_id") + ",";
        }
        ids = ids.substring(0, ids.length() - 1);
        List<M_replyInfo> reply = m_replyInfoService.selectByMessageId(ids);
        for (int i = 0; i < list.size(); i++) {
            List<M_replyInfo> tempList = new ArrayList<>();
            for (int j = 0; j < reply.size(); j++) {
                if (Integer.parseInt(list.get(i).get("message_id").toString()) == reply.get(j).getMessage_id()) {
                    tempList.add(reply.get(j));
                }
            }
            list.get(i).put("reply", tempList);
        }
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public PageModel selectByUser(int pageNo, int pageSize, int userId) {
        PageModel pageModel = new PageModel<>();
        pageSize = pageSize == 0 ? 10 : pageSize;
        pageModel.setPageSize(pageSize);
        int count = selectCountByUser(userId);
        pageModel.setTotalRecords(count);
        pageNo = pageModel.getTotalPages() < pageNo ? pageModel.getTotalPages() : pageNo;
        pageNo = pageNo == 0 ? 1 : pageNo;
        pageModel.setPageNo(pageNo);
        if (count == 0)
            return pageModel;
        List<HashMap<String, Object>> list = messageInfoDao.selectByUser((pageNo - 1) * pageSize, pageSize,userId);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public List seeMessage(int message_id) {
        return messageInfoDao.seeMessage(message_id);
    }

    @Override
    public List seeReply(int message_id) {
        return messageInfoDao.seeReply(message_id);
    }

    @Override
    public int delete(String ids) {
        return messageInfoDao.delete(ids.split(","));
    }

    @Override
    public int updateEnjoy(MessageInfo messageInfo) {
        return messageInfoDao.update(messageInfo);
    }

    @Override
    public int addMessage(MessageInfo messageInfo) {
        return messageInfoDao.save(messageInfo);
    }

    @Override
    public MessageInfo getMessage(int messageId) {
        return messageInfoDao.get(messageId);
    }

    @Override
    public int delMessage(int userId, int messageId) {
        return messageInfoDao.delMessage(userId,messageId);
    }
}
