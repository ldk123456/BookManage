<%--
  Created by IntelliJ IDEA.
  User: LDK
  Date: 2019/5/11
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="bean.User" %>
<%@ page import="dao.UserDao" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.Type" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN" class="ax-vertical-centered">
<head>
    <meta charset="UTF-8">
    <title>救护队图书资料管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="static/css/bootstrap-admin-theme.css">
    <link rel="stylesheet" href="static/css/bootstrap-admin-theme.css">
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/jQuery/jquery-3.1.1.min.js"></script>
    <script src="static/js/bootstrap-dropdown.min.js"></script>

    <script src="static/ajax-lib/ajaxutils.js"></script>
    <script src="static/js/adminUpdateInfo.js"></script>
    <script src="static/js/adminUpdatePwd.js"></script>

    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
</head>
<body class="bootstrap-admin-with-small-navbar">
<%
    User user = new User();
    String userId = (String)session.getAttribute("user_id");
    UserDao userDao = new UserDao();
    user = userDao.getUserById(userId);
    Map<String, Integer> userMap = (Map<String, Integer>) request.getAttribute("user_map");
    Map<String, Integer> bookMap = (Map<String, Integer>) request.getAttribute("book_map");
    ArrayList<Type> types = (ArrayList<Type>) request.getAttribute("types");
%>
<nav class="navbar navbar-inverse navbar-fixed-top bootstrap-admin-navbar bootstrap-admin-navbar-under-small" role="navigation">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="collapse navbar-collapse main-navbar-collapse">
                    <a class="navbar-brand" href="manager.jsp"><strong>欢迎使用救护队图书资料管理系统</strong></a>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" role="button" class="dropdown-toggle" data-hover="dropdown"> <i class="glyphicon glyphicon-user"></i>欢迎您，<%out.write(user.getUserName());%><i class="caret"></i></a>

                            <ul class="dropdown-menu">
                                <li><a href="#updateinfo" data-toggle="modal">个人资料</a></li>
                                <li role="presentation" class="divider"></li>
                                <li><a href="#updatepwd" data-toggle="modal">修改密码</a></li>
                                <li role="presentation" class="divider"></li>
                                <li><a href="index.jsp">退出</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <!-- left, vertical navbar & content -->
    <div class="row">
        <!-- left, vertical navbar -->
        <div class="col-md-2 bootstrap-admin-col-left">
            <ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
                <li>
                    <a href="manage_book.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书资料管理</a>
                </li>
                <li>
                    <a href="manage_user.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 用户管理</a>
                </li>
                <li>
                    <a href="analysis.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 统计分析</a>
                </li>
            </ul>
        </div>

        <!-- content -->
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="text-muted bootstrap-admin-box-title">用户统计分析</div>
                        </div>
                        <div class="bootstrap-admin-panel-content" style="width: 50%">
                            <!-- 图表容器 DOM -->
                            <div id="user_container" style="width: 430px;height:300px;"></div>
                            <!-- 引入 highcharts.js -->
                            <script src="http://cdn.highcharts.com.cn/highcharts/highcharts.js"></script>
                            <%-- 引入图表导出功能 --%>
                            <script src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>
                            <script src="http://cdn.hcharts.cn/highcharts/modules/exporting.js"></script>
                            <script src="http://cdn.hcharts.cn/highcharts/modules/offline-exporting.js"></script>
                            <script>
                                //导出按钮汉化
                                Highcharts.setOptions({
                                    lang: {
                                        printChart:"打印图表",
                                        downloadJPEG: "下载JPEG 图片" ,
                                        downloadPDF: "下载PDF文档"  ,
                                        downloadPNG: "下载PNG 图片"  ,
                                        downloadSVG: "下载SVG 矢量图" ,
                                        exportButtonTitle: "导出图片"
                                    }
                                });
                                // 图表配置
                                var options = {
                                    chart: {
                                        type: 'bar'                          //指定图表的类型，默认是折线图（line）
                                    },
                                    title: {
                                        text: '用户统计分析'                 // 标题
                                    },
                                    xAxis: {
                                        categories: ['管理员', '普通用户']   // x 轴分类
                                    },
                                    yAxis: {
                                        title: {
                                            text: '人数'                // y 轴标题
                                        }
                                    },
                                    series: [{                              // 数据列
                                        name: '人数',                       // 数据列名
                                        data: [ <%= userMap.get("管理员")%>, <%= userMap.get("普通用户")%>]                     // 数据
                                    }]
                                };
                                // 图表初始化函数
                                var chart = Highcharts.chart('user_container', options);
                            </script>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="text-muted bootstrap-admin-box-title">图书资料统计分析</div>
                        </div>
                        <div class="bootstrap-admin-panel-content" style="width: 50%">
                            <!-- 图表容器 DOM -->
                            <div id="book_container" style="width: 430px;height:300px;"></div>
                            <!-- 引入 highcharts.js -->
                            <script src="http://cdn.highcharts.com.cn/highcharts/highcharts.js"></script>
                            <%-- 引入图表导出功能 --%>
                            <script src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>
                            <script src="http://cdn.hcharts.cn/highcharts/modules/exporting.js"></script>
                            <script src="http://cdn.hcharts.cn/highcharts/modules/offline-exporting.js"></script>
                            <script>
                                // 图表配置
                                var options = {
                                    chart: {
                                        type: 'bar'                          //指定图表的类型，默认是折线图（line）
                                    },
                                    title: {
                                        text: '图书资料统计分析'                 // 标题
                                    },
                                    xAxis: {
                                        categories: ['书籍', '行业文档', '法律法规']   // x 轴分类
                                    },
                                    yAxis: {
                                        title: {
                                            text: '图书资料数量'                // y 轴标题
                                        }
                                    },
                                    series: [{                              // 数据列
                                        name: '数量',                        // 数据列名
                                        data: [<%= bookMap.get("书籍")%>,<%= bookMap.get("行业文档")%>
                                            , <%= bookMap.get("法律法规")%>]                     // 数据
                                    }]
                                };
                                // 图表初始化函数
                                var chart = Highcharts.chart('book_container', options);
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-------------------------------------------------------------->

    <form class="form-horizontal" method="post" action="user">   <!--保证样式水平不混乱-->
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="updatepwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel">
                            修改密码
                        </h4>
                    </div>
                    <div class="modal-body">

                        <!--正文-->
                        <input type="hidden" name="tip" value="1">
                        <input type="hidden" name="url" value="manager">
                        <div class="form-group">
                            <label for="oldPwd" class="col-sm-3 control-label">原密码</label>
                            <div class="col-sm-7">
                                <input type="password" class="form-control" name="password" id="oldPwd" required="required" placeholder="请输入原密码">
                                <label class="control-label" for="oldPwd" style="display: none"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newPwd" class="col-sm-3 control-label">新密码</label>
                            <div class="col-sm-7">
                                <input type="password" class="form-control" name="password2" id="newPwd" required="required" placeholder="请输入新密码">
                                <label class="control-label" for="newPwd" style="display: none"></label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary" >
                            修改
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </form>

    <!-------------------------个人资料模糊框------------------------------------->

    <form class="form-horizontal" method="post" action="user">   <!--保证样式水平不混乱-->
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="updateinfo" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="ModalLabel">
                            个人资料
                        </h4>
                    </div>

                    <div class="modal-body">
                        <input type="hidden" name="tip" value="2">
                        <input type="hidden" name="url" value="manager">
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label">用户名</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="name" name="name" required="required" placeholder="请输入用户名" value='<% out.write(user.getUserName());%>'>
                                <label class="control-label" for="name" style="display: none"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="col-sm-3 control-label">手机号</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="phone" name="phone" required="required" placeholder="请输入手机号" value='<% out.write(user.getPhone());%>'>
                                <label class="control-label" for="phone" style="display: none"></label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary" >
                            修改
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </form>
    <!-------------------------------------------------------------->
    <div class="modal fade" id="modal_info" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="infoModalLabel">提示</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12" id="div_info"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="btn_info_close" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

