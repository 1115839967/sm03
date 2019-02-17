<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- HTML5文档-->
<!DOCTYPE html>
<!-- 网页使用的语言 -->
<html lang="zh-CN">
<head>
    <!-- 指定字符集 -->
    <meta charset="utf-8">
    <!-- 使用Edge最新的浏览器的渲染方式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- viewport视口：网页可以根据设置的宽度自动进行适配，在浏览器的内部虚拟一个容器，容器的宽度与设备的宽度相同。
    width: 默认宽度与设备的宽度相同
    initial-scale: 初始的缩放比，为1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>添加用户</title>

    <!-- 1. 导入CSS的全局样式 -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="../../js/jquery-2.1.0.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="../../js/bootstrap.min.js"></script>
    <script>
        window.onload=function () {
            document.getElementById("return").onclick=function () {
                if(confirm("您确定要放弃添加吗？")){
                    location.href="${pageContext.request.contextPath}/user/findByPage"
                }
            }
        }
    </script>

    <script>
        function checkUserName() {
            var username = $("#username").val();
            var reg_username = /^\w{3,10}$/;
            var flag = reg_username.test(username);
            if(flag){
                $("#username").css("border","");

            }else {
                $("#username").css("border","1px red solid");
            }
            return flag;
        }

        function checkPassword() {
            var password = $("#password").val();
            var reg_password = /^\w{1,25}$/;
            var flag = reg_password.test(password);
            if(flag){
                $("#password").css("border","");

            }else {
                $("#password").css("border","1px red solid");
            }
            return flag;
        }

        function checkName(){

            var name = $("#name").val();
            var reg_name = /^\w{1,12}$/;
            var flag = reg_name.test(name);
            if(flag){
                $("#name").css("border","");

            }else {
                $("#name").css("border","1px red solid");
            }
            return flag;
        }

        function checkAge(){

            var age = $("#age").val();
            var reg_age = /^\w{1,3}$/;
            var flag = reg_age.test(age);
            if(flag){
                $("#age").css("border","");

            }else {
                $("#age").css("border","1px red solid");
            }
            return flag;
        }

        function checkEmail(){

            var email = $("#email").val();
            var reg_email = /^\w+\@\w+\.\w+$/;
            var flag = reg_email.test(email);
            if(flag){
                $("#email").css("border","");

            }else {
                $("#email").css("border","1px red solid");
            }
            return flag;
        }

        function checkQq(){

            var qq = $("#qq").val();
            var reg_qq = /^\d{5,12}$/;
            var flag = reg_qq.test(qq);
            if(flag){
                $("#qq").css("border","");

            }else {
                $("#qq").css("border","1px red solid");
            }
            return flag;
        }


        $(function () {
            $.post("/city/findAll",function (data) {
                for(var i=0;i,data.length;i++){
                    $("#address").append("<option value='"+data[i].city+"'>"+data[i].city+"</option>");
                }
            });

            $("#add").submit(function () {
                if(checkUserName()&&checkPassword()&&checkName()&& checkAge()&& checkQq()&&checkEmail()){
                    $.post("/user/addUser",$(this).serialize(),function (data) {
                        if(data.flag){
                            location.href="${pageContext.request.contextPath}/user/findByPage";
                        }else {
                            $("#errorMsg").html(data.errorMsg);
                        }
                    });
                }
                return false;
            });

            $("#username").blur(checkUserName);
            $("#password").blur(checkPassword);
            $("#name").blur(checkName);
            $("#age").blur(checkAge);
            $("#email").blur(checkEmail);
            $("#qq").blur(checkQq);
        });
    </script>
</head>
<body>
<div class="container">
    <center><h3>添加联系人页面</h3></center>
    <form action="" method="post" id="add">
        <div class="form-group">
            <label for="username">用户名：</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名">
        </div>

        <div class="form-group">
            <label for="password">密码：</label>
            <input type="text" class="form-control" id="password" name="password" placeholder="请输入密码">
        </div>

        <div class="form-group">
            <label for="name">姓名：</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="请输入姓名">
        </div>

        <div class="form-group">
            <label>性别：</label>
            <input type="radio" name="gender" value="男" checked="checked"/>男
            <input type="radio" name="gender" value="女"/>女
        </div>

        <div class="form-group">
            <label for="age">年龄：</label>
            <input type="text" class="form-control" id="age" name="age" placeholder="请输入年龄">
        </div>

        <div class="form-group">
            <label for="address">籍贯：</label>
            <select name="address" class="form-control" id="address">
                <%--<option value="安徽">安徽</option>
                <option value="北京">北京</option>
                <option value="南京">南京</option>
                <option value="南京">杭州</option>
                <option value="南京">上海</option>
                <option value="南京">天津</option>
                <option value="南京">武汉</option>
                <option value="南京">长沙</option>
                <option value="南京">河北</option>
                <option value="南京">西藏</option>
                <option value="南京">新疆</option>--%>
            </select>
        </div>

        <div class="form-group">
            <label for="qq">QQ：</label>
            <input type="text" class="form-control" id="qq" name="qq" placeholder="请输入QQ号码"/>
        </div>

        <div class="form-group">
            <label for="email">Email：</label>
            <input type="text" class="form-control" name="email" id="email" placeholder="请输入邮箱地址"/>
        </div>

        <div class="form-group" style="text-align: center">
            <input class="btn btn-primary" type="submit" value="提交" />
            <input class="btn btn-default" type="reset" value="重置" />
            <input class="btn btn-default" type="button" id="return" value="返回" />
        </div>
    </form>

    <div id="errorMsg" class="alert alert-danger" ></div>
</div>
</body>
</html>