<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    request.setAttribute("path", request.getContextPath());
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="${path}/assets/i/web-icon72x72.png">
    <link rel="stylesheet" type="text/css" href="${path}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/background/css/style.css">
    <link rel="stylesheet" type="text/css" href="${path}/background/css/font-awesome.min.css">
    <script src="${path}/assets/js/jquery-1.12.2.js" type="text/javascript"></script>
    <script src="${path}/assets/layer/layer.js" type="text/javascript"></script>
    <script src="${path}/js/plug.js"></script>
    <title>分页插件</title>
    <style>
        .table-responsive {
            min-height: 65vh;
            overflow-x: auto;
        }

        span {
            padding: 1px;
        }
    </style>
</head>
<body>
<div class="col-sm-12 col-sm-offset-0 col-md-12 col-lg-12 main">
    <form method="post">
        <h1 class="page-header"></h1>
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th><span class="glyphicon glyphicon-check"></span> <span>选择</span>
                    </th>
                    <th><span class="glyphicon glyphicon-file"></span> <span>标题</span></th>
                    <th><span class="glyphicon glyphicon-comment"></span> <span>摘要</span>
                    </th>
                    <th><span class="glyphicon glyphicon-time"></span> <span>日期</span></th>
                </tr>
                </thead>
                <tbody id="table-content">
                <div class="loader">
                    <div class="loader-inner line-scale">
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                    </div>
                </div>
                </tbody>
            </table>
        </div>
        <footer class="message_footer">
            <nav>
                <div class="btn-toolbar operation" role="toolbar">
                    <div class="btn-group" role="group"><a class="btn btn-default" onClick="select()">全选</a> <a
                            class="btn btn-default" onClick="reverse()">反选</a> <a class="btn btn-default"
                                                                                  onClick="noselect()">不选</a>
                    </div>
                </div>
                <%--<div id="demo7"></div>--%>
                <ul class="pagination pagenav" id="pageTool">

                </ul>
                <input type="hidden" value="10" id="pageSize">
                <input type="hidden" value="1" id="pageNo">
                <input type="hidden" value="" id="indexPageNo">
                <input type="hidden" value="" id="lastPageNo">
                <input type="hidden" value="" id="totalPages">
                <input type="hidden" value="20" id="totalRecords">
                <input type="hidden" value="false" id="toolFlag">
            </nav>
        </footer>
    </form>
</div>
<script>
    $(function () {
        var _data = [];
        var _json = {};
        var toolload = "false";
        var hash_page = window.location.hash.split("=")[1];
        hash_page = hash_page == undefined ? 1 : hash_page;
        load("", hash_page, $("#pageSize").val());

        function load(sort, _pageNo, _pageSize) {
            var totalPage = Math.ceil(parseFloat($("#totalRecords").val()) / parseFloat($("#pageSize").val()));
            if (totalPage <= 1 || parseInt($("#pageNo").val()) > totalPage) {
                $("#pageNo").val(totalPage);
            }
            _data = [];
            for (var i = 1; i <= _pageSize; i++) {
                _data.push({
                    "content": "内容" + ((parseInt(_pageNo) - 1) * parseInt(_pageSize) + i) + "",
                    "id": "" + i + "",
                    "title": "标题" + ((parseInt(_pageNo) - 1) * parseInt(_pageSize) + i) + "",
                    "time": "" + (new Date()).Format("yyyy.MM.dd hh:mm:ss.S") + ""
                })
            }

            _json = {
                "indexPageNo": "1",
                "lastPageNo": totalPage,
                "nextPageNo": parseInt(_pageNo) >= totalPage ? totalPage : parseInt(_pageNo) + 1,
                "pageNo": _pageNo,
                "pageSize": _pageSize,
                "previousPageNo": parseInt(_pageNo) <= 1 ? 1 : parseInt(_pageNo) - 1,
                "totalPages": totalPage,
                "totalRecords": $("#totalRecords").val(),
                "data": _data
            };
            $("#table-content").find("tr").remove();
            $(".loader").show();
            if (_json == "" || _json == null) {
                layer.alert('系统错误，数据获取失败', {
                    icon: 2,
                    skin: 'layer-ext-moon',
                    shade: 0.01,
                    zIndex: layer.zIndex,
                    success: function (layero) {
                        layer.setTop(layero);
                    }
                }, function () {
                    layer.close(layer.index);
                    $("#table-content").append("<tr><td style='text-align: center' colspan=5>数据获取失败，请稍后再试！</td></tr>");
                    $(".loader").hide();
                });
                return false;
            }
            if (_json.totalRecords == 0) {
                $("#table-content").append("<tr><td style='text-align: center' colspan=5>暂无数据！</td></tr>");
                $(".loader").hide();
                return false;
            }
            $(".loader").hide();
            if ($("#toolFlag").val() == "false") {
                $(".message_footer nav").hide();
                $.pageInit({
                    totalPages: _json.totalPages,
                    totalRecords: _json.totalRecords,
                    pageNo: _pageNo,
                    pageSize: _pageSize,
                    jumpPage: 1,
                    nextPageNo: _json.nextPageNo,
                    previousPageNo: _json.previousPageNo,
                    callback: load
                });
            }
            $.each(_json.data, function (index, item) {
                var content = item.content;
                content = content.length > 50 ? content.substring(0, 50) + "..." : content;
                $("#table-content").append("<tr>" +
                    "<td><input type='checkbox' class='input-control' name='checkbox[]' value='" + item.id + "'/></td>" +
                    "<td class='notice-title'>" + item.title + "</td>" +
                    "<td class='notice-content'>" + content + "</td>" +
                    "<td>" + item.time + "</td>" +
                    "</tr>");
            });
            $("#pageNo").val(_json.pageNo);
            $(".prevPage").attr("rel", _json.previousPageNo);
            $(".nextPage").attr("rel", _json.nextPageNo);

            /*$("#indexPageNo").val(_json.indexPageNo);
            $("#lastPageNo").val(_json.lastPageNo);
            $("#totalPages").val(_json.totalPages);*/
            /*改变每页浏览条数*/
            $("#selectNum").change(function () {
                $("#toolFlag").val("false");
                $("#pageSize").val($(this).val());
                load("", hash_page, $(this).val());
            });
            if (_json.pageNo == _json.indexPageNo) {
                $(".prevPage").parent().addClass("disabled");
            } else {
                $(".prevPage").parent().removeClass("disabled");
            }
            if (_json.pageNo == _json.lastPageNo) {
                $(".nextPage").parent().addClass("disabled");
            } else {
                $(".nextPage").parent().removeClass("disabled");
            }
        }
    });
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;

    };
    var checkall = document.getElementsByName("checkbox[]");

    //全选
    function select() {
        for (var $i = 0; $i < checkall.length; $i++) {
            checkall[$i].checked = true;
        }

    }

    //反选
    function reverse() {
        for (var $i = 0; $i < checkall.length; $i++) {
            if (checkall[$i].checked) {
                checkall[$i].checked = false;
            } else {
                checkall[$i].checked = true;
            }
        }
    }

    //全不选
    function noselect() {
        for (var $i = 0; $i < checkall.length; $i++) {
            checkall[$i].checked = false;
        }
    }
</script>
</body>
</html>
