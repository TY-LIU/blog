<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    request.setAttribute("path", request.getContextPath());
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <base href="<%=basePath%>">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>文章修改 - 异清轩博客管理系统</title>
    <jsp:include page="/WEB-INF/page/ini.jsp"></jsp:include>
    <style>
        .right-box {
            transition: all 1s 0s;
        }

        .col-md-3 {
            width: 20%;
        }

        .col-md-9 {
            width: 80%;
        }
    </style>
</head>

<body class="user-select">
<section class="container-fluid">
    <jsp:include page="/WEB-INF/page/header.jsp"></jsp:include>
    <div class="row">
        <jsp:include page="/WEB-INF/page/aside.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
            <div class="row">
                <form name="form1" id="form1" class="add-article-form">
                    <input type="hidden" value="${articleInfo.article_id}" id="article_id">
                    <div class="col-md-9">
                        <h1 class="page-header">文章修改</h1>
                        <div class="form-group">
                            <label for="article-title" class="sr-only">标题</label>
                            <input type="text" id="article-title" name="title" class="form-control"
                                   placeholder="在此处输入标题" value="${articleInfo.title}" required autofocus
                                   autocomplete="off">
                        </div>
                        <div class="form-group" id="content">
                            <label for="article-content" class="sr-only">内容</label>
                            <script id="article-content" name="content"
                                    type="text/plain">${articleInfo.content}</script>
                        </div>
                        <div class="add-article-box">
                            <h2 class="add-article-box-title"><span>描述</span></h2>
                            <div class="add-article-box-content">
                                <textarea class="form-control" id="describe" name="describe" required
                                          autocomplete="off">${articleInfo.describe}</textarea>
                                <span class="prompt-text">描述是可选的手工创建的内容总结，并可以在网页描述中使用</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <h1 class="page-header">操作</h1>
                        <div class="add-article-box right-box">
                            <h2 class="add-article-box-title"><span>栏目</span></h2>
                            <div class="add-article-box-content">
                                <ul class="category-list">
                                    <c:forEach items="${columnInfo}" var="item">
                                        <li>
                                            <label>
                                                <input type="radio" name="column_id"
                                                       <c:if test="${item['column_id']==articleInfo.columnInfo.column_id}">checked</c:if>
                                                       value="${item['column_id']}">${item['column_name']}
                                                <em class="hidden-md">( 栏目ID: <span>${item['column_id']}</span> )</em>
                                            </label>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="add-article-box right-box">
                            <h2 class="add-article-box-title"><span>标签</span></h2>
                            <div class="add-article-box-content">
                                <input type="text" class="form-control" placeholder="输入新标签" required
                                       value="${articleInfo.label}" id="label" autocomplete="off">
                                <span class="prompt-text">多个标签请用英文逗号,隔开</span></div>
                        </div>
                        <div class="add-article-box right-box">
                            <h2 class="add-article-box-title"><span>标题图片</span></h2>
                            <div class="add-article-box-content">
                                <input type="text" class="form-control" placeholder="点击按钮选择图片" readonly id="pictureUpload"
                                       value="${articleInfo.title_img}" name="title_img" autocomplete="off">
                            </div>
                            <div class="add-article-box-footer">
                                <button class="btn btn-default" type="button" ID="upImage">选择</button>
                            </div>
                        </div>
                        <div class="add-article-box right-box">
                            <h2 class="add-article-box-title"><span>发布</span></h2>
                            <div class="add-article-box-content">
                                <p><label>状态：</label><span
                                        class="article-status-display">${articleInfo.put_state == 1?'已发布':'待更新'}</span>
                                </p>
                                <p><label>发布于：</label><span class="article-time-display">
                                    <input style="border: none;" type="datetime" name="put_time" readonly
                                           value="<fmt:formatDate value="${articleInfo.put_time}" pattern="yyyy-MM-dd HH:mm:ss"/>"/></span>
                                </p>
                                <p><label>上次更新时间：</label><span class="article-time-display">
                                    <input style="border: none;" type="datetime" name="update_time" readonly
                                           value="<fmt:formatDate value="${articleInfo.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/>"/></span>
                                </p>
                            </div>
                            <div class="add-article-box-footer">
                                <button class="btn btn-primary" style="margin-left: 10px;" type="submit" id="update"
                                        name="submit">更新
                                </button>
                                <button class="btn" type="button" id="save" name="submit">保存</button>
                                <button class="btn" type="button" style="float:left;" id="loadTempArticle"
                                        name="submit">
                                    加载上次内容
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<jsp:include page="/WEB-INF/page/modal-box.jsp"></jsp:include>
<script src="${path}/background/js/bootstrap.min.js"></script>
<script src="${path}/background/js/admin-scripts.js"></script>
<script src="${path}/background/lib/ueditor/ueditor.config.js"></script>
<script src="${path}/background/lib/ueditor/ueditor.all.min.js"></script>
<script src="${path}/background/lib/ueditor/lang/zh-cn/zh-cn.js"></script>
<script id="uploadEditor" type="text/plain"></script>
<script>
    var editor = UE.getEditor('article-content');
    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl = function (action) {
        if (action == 'uploadimage' || action == 'uploadscrawl' || action == 'uploadimage') {
            return '${path}/ueditor/ossUpload'
        } else if (action == 'uploadvideo') {
            alert("上传视屏");
        } else if (action == 'listimage') {
            alert("列出在线图片");
        } else {
            return this._bkGetActionUrl.call(this, action);
        }

    };
    window.onresize = function () {
        window.location.reload();
    };
    var _uploadEditor;
    $(function () {
        //重新实例化一个编辑器，防止在上面的editor编辑器中显示上传的图片或者文件
        _uploadEditor = UE.getEditor('uploadEditor');
        _uploadEditor.ready(function () {
            //设置编辑器不可用
            //_uploadEditor.setDisabled();
            //隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
            _uploadEditor.hide();
            //侦听图片上传
            _uploadEditor.addListener('beforeInsertImage', function (t, arg) {
                //将地址赋值给相应的input,只去第一张图片的路径
                $("#pictureUpload").attr("value", arg[0].src);
                //图片预览
                //$("#imgPreview").attr("src", arg[0].src);
            });
            //侦听文件上传，取上传文件列表中第一个上传的文件的路径
            _uploadEditor.addListener('afterUpfile', function (t, arg) {
                $("#fileUpload").attr("value", _uploadEditor.options.filePath + arg[0].url);
            })
        });
        $(window).scroll(function () {
            var scrollTop = $(this).scrollTop();
            if (scrollTop >= 119) {
                $(".right-box").css('transform', 'translateY(' + (scrollTop - 70) + 'px)');
            } else {
                $(".right-box").css('transform', '');
            }
        });
    });
    //弹出图片上传的对话框
    $('#upImage').click(function () {
        var myImage = _uploadEditor.getDialog("insertimage");
        myImage.open();
    });

    $("#form1").submit(function () {
        return false;
    });
    $("#update").click(function () {
        layer.confirm('确认发布更新？', {
            icon: 3,
            skin: 'layer-ext-moon',
            btn: ['确认', '再想想'] //按钮
        }, function () {
            ajaxFun('${path}/articleInfo/updateArticle', updateSuccess);
        }, function () {
            layer.close(layer.index);
        });
    });

    $("#save").click(function () {
        ajaxFun('${path}/articleInfo/updateTempArticle', saveSuccess);
    });

    $("#loadTempArticle").click(function () {
        $.ajax({
            type: 'post',
            url: '${path}/articleInfo/existData',
            timeout: 10000,
            data: {article_id:$("#article_id").val()},
            success: function (data) {
                if(data){
                    layer.confirm('加载后会覆盖当前数据，确认加载？', {
                        icon: 3,
                        skin: 'layer-ext-moon',
                        btn: ['确认', '取消'] //按钮
                    }, function () {
                        location.href = '${path}/articleInfo/loadTempArticle/' + $("#article_id").val();
                    }, function () {
                        layer.close(layer.index);
                    });
                }else{
                    layer.alert('当前文章未保存过临时信息', {
                        icon: 7,
                        skin: 'layer-ext-moon'
                    }, function () {
                        layer.close(layer.index);
                    });
                }

            }, complete: function (XMLHttpRequest, status) {
                if (status == "timeout") {
                    layer.alert('网络异常，请检查网络', {
                        icon: 2,
                        skin: 'layer-ext-moon'
                    }, function () {
                        layer.close(layer.index);
                    });
                } else if (status == "error") {
                    layer.alert('系统错误，加载失败', {
                        icon: 2,
                        skin: 'layer-ext-moon'
                    }, function () {
                        layer.close(layer.index);
                    });
                }
            }
        });
    });

    function ajaxFun(url, fun) {
        var article_id = $("#article_id").val();
        var title = $("#article-title").val();
        var content = UE.getEditor('article-content').getContent();
        var describe = $("#describe").val();
        var column_id = $(".category-list").find("input:checked").val();
        var label = $("#label").val();
        var pic = $("#pictureUpload").val();
        var param = {};//定义值，后台获取
        param.article_id = article_id;
        param.title = title;
        param.content = content;
        param.describe = describe;
        param.title_img = pic;
        param.column_id = column_id;
        param.label = label;
        $.ajax({
            type: 'post',
            url: url,
            timeout: 10000,
            data: param,
            success: function (data) {
                fun(data);
            }, complete: function (XMLHttpRequest, status) {
                if (status == "timeout") {
                    layer.alert('网络异常，请检查网络', {
                        icon: 2,
                        skin: 'layer-ext-moon'
                    }, function () {
                        layer.close(layer.index);
                    });
                } else if (status == "error") {
                    layer.alert('系统错误，修改失败', {
                        icon: 2,
                        skin: 'layer-ext-moon'
                    }, function () {
                        layer.close(layer.index);
                    });
                }
            }
        });

    }

    function updateSuccess(data) {
        if (data == "true") {
            layer.confirm('更新成功，返回文章列表？', {
                icon: 1,
                skin: 'layer-ext-moon',
                btn: ['确认', '取消'] //按钮
            }, function () {
                window.location.href = "${path}/login/toPages/article";
            }, function () {
                layer.close(layer.index);
            });
        }

    }

    function saveSuccess(data) {
        if (data == "true") {
            layer.msg('保存成功', {
                icon: 1,
                time: 1000
            });
        }

    }

    //弹出文件上传的对话框
    function upFiles() {
        var myFiles = _uploadEditor.getDialog("attachment");
        myFiles.open();
    }
</script>
</body>
</html>