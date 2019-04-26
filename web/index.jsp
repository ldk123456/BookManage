<%--
  Created by IntelliJ IDEA.
  User: LDK
  Date: 2019/4/25
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>救护队图书资料管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="static/css/bootstrap-admin-theme.css">
    <link rel="stylesheet" href="static/css/bootstrap-admin-theme.css">
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/jQuery/jquery-3.1.1.min.js"></script>
    <script src="static/ajax-lib/ajaxutils.js"></script>
    <script src="static/js/login.js"></script>
    <style type="text/css">
      .alert{
        margin: 0 auto 20px;
        text-align: center;
      }
    </style>
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
  </head>
  <body class="bootstrap-admin-without-padding">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="alert alert-info">
          <a class="close" data-dismiss="alert" href="#">&times;</a>
          欢迎登录救护队图书资料管理系统
        </div>

        <form class="bootstrap-admin-login-form" method="post" action="login">
          <%
            String state = (String)session.getAttribute("state");
            session.removeAttribute("state");
            if(state!=null){
          %>
          <label class="control-label" for="username" style="color: red">工号或密码错误，请重新输入！</label>
          <%}%>
          <div class="form-group">
            <label class="control-label" for="username">账&nbsp;号</label>
            <input type="text" class="form-control" id="username" name="username" required="required" placeholder="请输入工号"/>
            <label class="control-label" for="username" style="display:none;"></label>
          </div>
          <div class="form-group">
            <label class="control-label" for="password">密&nbsp;码</label>
            <input type="password" class="form-control" id="password" name="password" required="required" placeholder="请输入密码"/>
            <label class="control-label" for="username" style="display:none;"></label>
          </div>
          <br>
          <input type="submit" class="btn btn-lg btn-primary"  value="登&nbsp;&nbsp;&nbsp;&nbsp;录"/>

        </form>
      </div>
    </div>
  </div>
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
  </body>
</html>
