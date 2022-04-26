;(function ($, window, undefined) {
    var pageNo = '',
        pageSize = '',
        previousPageNo = '',
        nextPageNo = '',
        indexPageNo = '',
        //跳转是否有值
        jumpVal = '',
        //从DOM中重新获取数据总页数/总数
        totalPages = '',
        totalRecords = '',
        //回调函数
        callback = null;

    var Page = function (opts, callBack) {
        this.settings = $.extend({}, Page.defaults, opts, callBack);
        pageNo = this.settings.pageNo;
        pageSize = this.settings.pageSize;
        totalPages = this.settings.totalPages;
        totalRecords = this.settings.totalRecords;
        nextPageNo = this.settings.nextPageNo;
        previousPageNo = this.settings.previousPageNo;
        jumpVal = this.settings.jumpPage;
        indexPageNo = this.settings.indexPageNo;
        callback = this.settings.callback;
        this.init();
    };
    //默认配置
    Page.defaults = {
        container: '#pageTool',     //ul容器ID，默认pageTool
        setPos: 'body',             //DOM放置的HTML位置，默认body
        totalPages: null,           //总页数
        totalRecords: null,         //总记录条数
        indexPageNo: 1,             //首页，默认1
        pageNo: 1,                  //当前页，默认1
        pageSize: 10,               //每页条数，默认10
        jumpPage: 1,                //跳转页，默认1
        nextPageNo: null,           //下一页
        previousPageNo: null,       //上一页
        callback: null              //回调函数
    };
    Page.prototype = {
        init: function () {
            this.create();
        },
        create: function () {
            $(this.settings.container).find("li").remove();
            if (pageNo == indexPageNo)
                $(this.settings.container).append("<li class='disabled'><a aria-label='Previous' class='prevPage' rel=" + previousPageNo + "> <span aria-hidden='true'><i class=' icon-angle-left'></i></span></a></li>");
            else
                $(this.settings.container).append("<li><a aria-label='Previous' class='prevPage' rel=" + previousPageNo + "> <span aria-hidden='true'><i class=' icon-angle-left'></i></span></a></li>");
            for (var i = 1; i <= totalPages; i++) {
                if (totalPages == 6) {
                    if (i == pageNo)
                        $(this.settings.container).append("<li class='active'><a class='pageNo' href='javascript:void(0)' rel=" + i + ">" + i + "</a></li>");
                    else
                        $(this.settings.container).append("<li><a class='pageNo' href='javascript:void(0)' rel=" + i + ">" + i + "</a></li>");
                    continue;
                }
                if (i > 5) {
                    $(this.settings.container).append("<li><span>...</span></li>");
                    $(this.settings.container).append("<li><a class='pageNo' href='javascript:void(0)' rel=" + totalPages + ">" + totalPages + "</a></li>");
                    break;
                }
                if (i == pageNo)
                    $(this.settings.container).append("<li class='active'><a class='pageNo' href='javascript:void(0)' rel=" + i + ">" + i + "</a></li>");
                else
                    $(this.settings.container).append("<li><a class='pageNo' href='javascript:void(0)' rel=" + i + ">" + i + "</a></li>");
            }
            if (indexPageNo == totalPages)
                $(this.settings.container).append("<li class='disabled'><a href='javascript:void(0)' class='nextPage' aria-label='Next' rel=" + nextPageNo + "><span aria-hidden='true'><i class=' icon-angle-right'></i></span></a></li>");
            else
                $(this.settings.container).append("<li><a href='javascript:void(0)' class='nextPage' aria-label='Next' rel=" + nextPageNo + "><span aria-hidden='true'><i class=' icon-angle-right'></i></span></a></li>");
            $(this.settings.container).append("<li class='tool-page'>" +
                "<select id='selectNum' class='tool-page-select'>" +
                "<option value='1'>1条/页</option>" +
                "<option value='2'>2条/页</option>" +
                "<option value='5'>5条/页</option>" +
                "<option value='10'>10条/页</option>" +
                "<option value='15'>15条/页</option>" +
                "<option value='20'>20条/页</option>" +
                "<option value='50'>50条/页</option>" +
                "<option value='100'>100条/页</option>" +
                "</select>&nbsp;共" + totalRecords + "条</li>" +
                "<li class='tool-page'>到第<input  class='tool-page-input' type='number' oninput='checkNun(this," + indexPageNo + "," + totalPages + ")' min='1' max=" + totalPages + " value='1'>页" +
                "<input class='tool-page-button' type='button' value='确定' id='jump'></li>");
            $.each($("#selectNum option"), function (index, item) {
                if ($(item).val() == pageSize)
                    $(item).attr("selected", true);
            });
            $(".message_footer nav").show();
            this.bindEvent();
        },
        bindEvent: function () {
            var _this = this;

            $(this.settings.setPos).on('click', '.pageNo', function () {
                if ($(this).parent().attr("class") == "active")
                    return false;
                else
                    _this.refreshDom(this);
            });
            //上一页
            $(this.settings.setPos).find('.prevPage').off("click").on('click', function () {
                if ($(this).parent().attr("class") == "disabled")
                    return false;
                else
                    _this.refreshDom(this);
            });
            //下一页
            $(this.settings.setPos).find('.nextPage').off("click").on('click', function () {
                if ($(this).parent().attr("class") == "disabled")
                    return false;
                else {
                    _this.refreshDom(this);
                }
            });
            //跳转页数
            $(this.settings.setPos).find('#jump').off('click').on('click',function () {
                _this.refreshDom(this, $(".tool-page-input").val());
            });
        },
        refreshDom: function (event, pageNum) {
            var _pageNo = parseInt($(event).attr('rel')),
                element = $(event).parent().parent();
            if (pageNum != undefined) {
                _pageNo = parseInt(pageNum);
            }
            var len = 0;
            if (totalPages == 7) {
                if (_pageNo >= 5) {
                    element.find("li").eq(6).empty().append("<a class='pageNo' href='javascript:void(0)' rel='6'>6</a>");
                    element.find("li").eq(2).empty().append("<span>...</span>");
                } else {
                    element.find("li").eq(2).empty().append("<a class='pageNo' href='javascript:void(0)' rel='2'>2</a>");
                    element.find("li").eq(6).empty().append("<span>...</span>");
                }
            } else if (totalPages > 7) {
                len = element.find("li a[class='pageNo']").parent().length;
                if (_pageNo + 3 < totalPages && _pageNo - 3 > 1) {
                    if (len == 7) {
                        for (var i = 3; i < 8; i++) {
                            element.find("li").eq(i).find("a").attr("rel", "" + (_pageNo + (i - 5)) + "").text("" + (_pageNo + (i - 5)) + "");
                        }
                    } else {
                        if (element.find("li").eq(2).children("span").length == 0) {
                            element.find("li").eq(2).empty().append("<span>...<span>");
                        }
                        for (var i = 3; i < 7; i++) {
                            element.find("li").eq(i).empty().append("<a class='pageNo' href='javascript:void(0)' rel='" + (_pageNo + (i - 5)) + "'>" + (_pageNo + (i - 5)) + "</a>");
                        }
                        element.find("li").eq(6).after("<li><a class='pageNo' href='javascript:void(0)' rel='" + (_pageNo + 2) + "'>" + (_pageNo + 2) + "</a></li>");
                        if (element.find("li").eq(8).children("span").length == 0) {
                            element.find("li").eq(7).after("<li><span>...<span></li>");
                        }
                    }
                } else {
                    if (_pageNo - 3 <= 1) {
                        if (len == 7) {
                            if (element.find("li").eq(8).children("span").length == 0) {
                                element.find("li").eq(7).after("<li><span>...<span></li>");
                            }
                            for (var i = 0; i < 2; i++) {
                                element.find("li").eq(6).remove();
                            }
                        } else {
                            if (element.find("li").eq(6).children("span").length == 0) {
                                element.find("li").eq(6).empty().append("<span>...<span>");
                            }
                        }
                        for (var i = 2; i < 6; i++) {
                            element.find("li").eq(i).empty().append("<a class='pageNo' href='javascript:void(0)' rel='" + i + "'>" + i + "</a>");
                        }
                    } else if (_pageNo + 3 >= totalPages) {
                        if (element.find("li").eq(2).children("span").length == 0) {
                            element.find("li").eq(2).empty().append("<span>...<span>");
                        }
                        if (len == 7) {
                            for (var i = 0; i < 2; i++) {
                                element.find("li").eq(3).remove();
                            }
                        }
                        for (var i = 1, n = 6; i < 5; i++, n--) {
                            element.find("li").eq(n).empty().append("<a class='pageNo' href='javascript:void(0)' rel='" + (totalPages - i) + "'>" + (totalPages - i) + "</a>");
                        }
                    }
                }
            }
            element.find("li:has('.pageNo'):contains('" + _pageNo + "')").eq(0).addClass("active").siblings().removeClass("active");
            var hash = window.location.hash,
                origin = window.location.origin,
                pathname = window.location.pathname,
                url;
            if(hash==''||hash==null){
                url=origin+pathname+"#!page="+_pageNo+"";
            }else{
                var new_hash = hash.replace('' + hash.split("=")[1] + '', '' + _pageNo + '');
                url= origin + pathname + new_hash;
            }
            window.history.pushState({}, '', '' + url + '');
            typeof callback === 'function' ? callback($("#search").val(), _pageNo, $("#pageSize").val()) : alert('分页参数错误');
        }
    };
    var pageInit = function (opts, callBack) {
        return new Page(opts, callBack);
    };
    window.pageInit = $.pageInit = pageInit;

})(jQuery, window, undefined);

function checkNun(event, min, max) {
    var reg = new RegExp("/[^" + min + "-" + max + "]$/");
    var val = $(event).val();
    $(event).val(val.replace(reg, ''));
    if (val < min) {
        $(event).val(min);
    } else if (val > max) {
        $(event).val(max);
    }
}