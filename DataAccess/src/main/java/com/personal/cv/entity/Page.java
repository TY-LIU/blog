package com.personal.cv.entity;

import com.lang.PageModel;
import org.apache.poi.ss.formula.functions.T;

import java.util.List;

public class Page {
    private PageModel pageModel;
    private List list;
    private Users users;

    public PageModel getPageModel() {
        return pageModel;
    }

    public void setPageModel(PageModel pageModel) {
        this.pageModel = pageModel;
    }

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    public Page(PageModel pageModel) {
        this.pageModel = pageModel;
    }

    public Page(PageModel pageModel, List list) {
        this.pageModel = pageModel;
        this.list = list;
    }

    public Page(PageModel pageModel, Users users) {
        this.pageModel = pageModel;
        this.users = users;
    }

    public Page(PageModel pageModel, List list, Users users) {
        this.pageModel = pageModel;
        this.list = list;
        this.users = users;
    }
}
