  <%--Created by IntelliJ IDEA.
  User: LDK
  Date: 2019/5/7
  Time: 13:10
  To change this template use File | Settings | File Templates.--%>
<%@ page import="bean.User" %>
<%@ page import="dao.UserDao" %>
  <%@ page import="java.util.ArrayList" %>
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
                    <a href="manage_book.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 图书管理</a>
                </li>
                <li>
                    <a href="manage_user.jsp"><i class="glyphicon glyphicon-chevron-right"></i> 用户管理</a>
                </li>
            </ul>
        </div>

        <!-- content -->
        <div class="col-md-10">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default bootstrap-admin-no-table-panel">
                        <div class="panel-heading">
                            <div class="text-muted bootstrap-admin-box-title">用户管理</div>
                        </div>
                        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                            <form class="form-horizontal" action="find" method="post">
                                <div class="col-lg-7 form-group">
                                    <label class="col-lg-4 control-label" for="adminName">用户账号</label>
                                    <div class="col-lg-8">
                                        <input class="form-control" id="adminName" name="name" type="text" value="">
                                        <label class="control-label" for="adminName" style="display: none;"></label>
                                    </div>
                                </div>
                                <div class="col-lg-3 form-group">

                                    <button type="submit" class="btn btn-primary" id="btn_query" onclick="">查找</button>
                                </div>

                                <div class="col-lg-3 form-group">

                                    <button type="button" class="btn btn-primary" id="btn_add" data-toggle="modal" data-target="#addModal">添加用户</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="col-lg-12">
                    <table id="data_list" class="table table-hover table-bordered" >
                        <thead>
                        <tr>
                            <th>账号</th>
                            <th>用户名</th>
                            <th>手机号</th>
                            <th>操作</th>
                        </tr>
                        </thead>

                        <!---在此插入信息-->
                        <%
                            ArrayList<User> data2 = new ArrayList<>();
                            data2 = (ArrayList<User>)request.getAttribute("data");
                            if(data2!=null){

                            for (User bean : data2){
                        %>
                        <tbody>
                        <td><%= bean.getAdminName() %></td>
                        <td><%= bean.getUserName() %></td>
                        <td><%= bean.getPhone() %></td>
                        <td>
                            <button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#updateStatusModal"
                                    id="btn_update2" onclick="updateStatus(<%= bean.getUserId() %>,'<%= bean.getStatus()%>')">设置权限</button>
                            <button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#updateModal"
                                    id="btn_update1" onclick="updateUser(<%= bean.getUserId() %>,'<%= bean.getAdminName() %>','<%= bean.getUserName() %>'
                                ,<%= bean.getPhone() %>,'<%= bean.getPassword() %>')">修改信息</button>
                            <button type="button" class="btn btn-danger btn-xs" onclick="deleteUser(<%= bean.getUserId() %>)">删除</button>
                        </td>
                        </tbody>
                        <%} %>
                        <%} %>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function updateStatus(id,status) {
            document.getElementById("updateStatusId").value = id;
            document.getElementById("updateStatus").value = status;
        }
        function updateUser(id,username,name,phone,password) {
            document.getElementById("updateUserId").value = id;
            document.getElementById("updateAdminName").value = username;
            document.getElementById("updateUserName").value = name;
            document.getElementById("updatePhone").value = phone;
            document.getElementById("updatePassword").value = password;
        }
        function deleteUser(id) {
            con=confirm("是否删除?");
            if(con==true){
                location.href = "delete_user?id="+id;
            }
        }
    </script>

    <!-- 设置权限模态框（Modal） -->
    <form class="form-horizontal" method="post" action="update_status">   <!--保证样式水平不混乱-->
        <div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="updateStatusModalLabel">
                            设置用户权限
                        </h4>
                    </div>
                    <div class="modal-body">

                        <!---------------------表单-------------------->
                        <div class="form-group">
                            <label for="updateStatus" class="col-sm-3 control-label">权限</label>
                            <div class="col-sm-7">
                                <input type="hidden" id="updateStatusId" name="statusId">
                                <select class="form-control" id="updateStatus" name="status" onPropertyChange="showValue(this.value)">
                                    <option value="-1">请选择</option>
                                    <option value="管理员">管理员</option>
                                    <option value="普通用户">普通用户</option>
                                </select>
                                <label class="control-label" for="updateStatus" style="display: none;"></label>
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

    <!-- 修改模态框（Modal） -->
    <form class="form-horizontal" method="post" action="update_user">   <!--保证样式水平不混乱-->
        <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="updateModalLabel">
                            修改读者信息
                        </h4>
                    </div>
                    <div class="modal-body">

                        <!---------------------表单-------------------->

                        <div class="form-group">
                            <label for="updateAdminName" class="col-sm-3 control-label">账号</label>
                            <div class="col-sm-7">
                                <input type="hidden" id="updateUserId" name="aid">
                                <input type="text" class="form-control" id="updateAdminName" name="adminName"  placeholder="">
                                <label class="control-label" for="updateAdminName" style="display: none;"></label>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="updateUserName" class="col-sm-3 control-label">用户名</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="updateUserName" name="userName"  placeholder="">
                                <label class="control-label" for="updateUserName" style="display: none;"></label>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="updatePhone" class="col-sm-3 control-label">手机号</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="updatePhone" name="phone"  placeholder="">
                                <label class="control-label" for="updatePhone" style="display: none;"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="updatePassword" class="col-sm-3 control-label">密码</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="updatePassword" name="password"  placeholder="">
                                <label class="control-label" for="updatePassword" style="display: none;"></label>
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







    <!--------------------------------------添加的模糊框------------------------>
    <form class="form-horizontal" method="post" action="add_user">>   <!--保证样式水平不混乱-->
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel1">
                            添加新读者
                        </h4>
                    </div>
                    <div class="modal-body">

                        <!---------------------表单-------------------->

                        <div class="form-group">
                            <label for="addAdminName" class="col-sm-3 control-label">账号</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="adminName" id="addAdminName" required="required" placeholder="请输入账号">
                                <label class="control-label" for="addAdminName" style="display: none;"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="addUserName" class="col-sm-3 control-label">用户名</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="userName" id="addUserName" required="required"  placeholder="请输入用户名">
                                <label class="control-label" for="addUserName" style="display: none;"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="addPhone" class="col-sm-3 control-label">手机号</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="phone" id="addPhone" required="required"  placeholder="请输入手机号">
                                <label class="control-label" for="addPhone" style="display: none;"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="addPassword" class="col-sm-3 control-label">密码</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="password" id="addPassword" required="required"   placeholder="请输入密码">
                                <label class="control-label" for="addPassword" style="display: none;"></label>
                            </div>
                        </div>

                        <!---------------------表单-------------------->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary" >
                            添加
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>

    </form>
    <!--------------------------------------添加的模糊框------------------------>



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
                                <input type="password" class="form-control" name="password" id="oldPwd"  placeholder="请输入原密码">
                                <label class="control-label" for="oldPwd" style="display: none"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newPwd" class="col-sm-3 control-label">新密码</label>
                            <div class="col-sm-7">
                                <input type="password" class="form-control" name="password2" id="newPwd"  placeholder="请输入新密码">
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
                                <input type="text" class="form-control" id="name" name="name" placeholder="请输入用户名" value='<% out.write(user.getUserName());%>'>
                                <label class="control-label" for="name" style="display: none"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="col-sm-3 control-label">手机号</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="phone" name="phone" placeholder="请输入手机号" value='<% out.write(user.getPhone());%>'>
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

