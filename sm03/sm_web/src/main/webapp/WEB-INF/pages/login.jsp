<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>管理员登录</title>

    <!-- 1. 导入CSS的全局样式 -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="../../js/jquery-2.1.0.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="../../js/bootstrap.min.js"></script>
    <script type="text/javascript"></script>
	  <%
		  String username = "";
		  String password = "";
		  String checked = "";
		  Cookie[] cookies = request.getCookies();
		  for (Cookie cookie : cookies) {
			  if ("username".equals(cookie.getName())) {
				  username = cookie.getValue();
				  checked = "checked";
			  }
			  if ("password".equals(cookie.getName())) {
				  password = cookie.getValue();
			  }

		  }
		  request.setAttribute("username", username);
		  request.setAttribute("password", password);
		  request.setAttribute("checked", checked);
	  %>

	  <script>
		  function refreshCode() {
		      var id = document.getElementById("vcode");
		      id.src="${pageContext.request.contextPath}/checkCode/getCode?time="+new Date().getTime();
          }
	  </script>
	  <script>
		  $(function () {
			 $("#sub_btn").click(function () {
				$.post("/user/loginUser",$("#login_from").serialize(),function (data) {
					if(data.flag){
					    location.href = "${pageContext.request.contextPath}/path/pathName/index";
					}else {
					    $("#errorMsg").html(data.errorMsg);
					}
                });
             });
          });
	  </script>
  </head>
  <body>
  	<div class="container" style="width: 400px;">
  		<h3 style="text-align: center;">管理员登录</h3>
        <form id="login_from" action="" method="post" accept-charset="utf-8">
	      <div class="form-group">
	        <label for="username">用户名：</label>
	        <input type="text" name="username" value="${username}" class="form-control" id="username" placeholder="请输入用户名"/>
	      </div>
	      
	      <div class="form-group">
	        <label for="password">密码：</label>
	        <input type="password" name="password" value="${password}" class="form-control" id="password" placeholder="请输入密码"/>
	      </div>
	      
	      <div class="form-inline">
	        <label for="checkeCode">验证码：</label>
	        <input type="text" name="checkeCode" class="form-control" id="checkeCode" placeholder="请输入验证码" style="width: 120px;"/>
	        <a href="javascript:refreshCode()"><img src="${pageContext.request.contextPath}/checkCode/getCode" title="看不清点击刷新" id="vcode"/></a>
	      </div>
			<div class="form-group">
				<label for="password">记住我：</label>
				<input type="checkbox" name="ck" class="form-control" value="1"  ${checked} id="ck"/>
			</div>

	      <hr/>
	      <div class="form-group" style="text-align: center;">
	        <button type="button" id="sub_btn">登录</button>
		  </div>


	  	</form>
		
		<!-- 出错显示的信息框 -->
		<div id="errorMsg" class="alert alert-danger" ></div>
  	</div>
  </body>
</html>