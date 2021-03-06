<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!-- 网页使用的语言 -->
<html lang="zh-CN">
<head>
    <!-- 指定字符集 -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>修改用户</title>

    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <script src="../../js/jquery-2.1.0.min.js"></script>
    <script src="../../js/bootstrap.min.js"></script>
    <script>
        window.onload = function () {
            document.getElementById("return").onclick = function () {
                if (confirm("您确定要放弃修改吗？")) {
                    location.href = "${pageContext.request.contextPath}/user/findByPage"
                }
            }

            $.post("/city/findAll",function (data) {
                for(var i=0;i,data.length;i++){
                    $("#address").append("<option value='"+data[i].city+"'>"+data[i].city+"</option>");
                }
            });
        }
    </script>
</head>
<body>
<div class="container" style="width: 400px;">
    <h3 style="text-align: center;">修改联系人</h3>
    <form action="${pageContext.request.contextPath}/user/updateUser" method="post">
        <input type="hidden" name="id" value="${user.id}">
        <div class="form-group">
            <label for="username">用户名：</label>
            <input type="text" class="form-control" id="username" name="username" value="${user.username}" readonly="readonly"/>
        </div>

        <div class="form-group">
            <label for="password">密码：</label>
            <input type="text" class="form-control" id="password" name="password"  value="${user.password}"/>
        </div>

        <div class="form-group">
            <label for="name">姓名：</label>
            <input type="text" class="form-control" id="name" name="name" value="${user.name}"/>
        </div>

        <div class="form-group">
            <label>性别：</label>
            <input type="radio" name="gender" value="男"   ${user.gender == '男' ? "checked" : ""}  />男
            <input type="radio" name="gender" value="女"  ${user.gender == '女' ? "checked" : ""} />女
        </div>

        <div class="form-group">
            <label for="age">年龄：</label>
            <input type="text" class="form-control" id="age" name="age" value="${user.age}" placeholder="请输入年龄"/>
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
            <input type="text" class="form-control" id="qq" name="qq" value="${user.qq}" placeholder="请输入QQ号码"/>
        </div>

        <div class="form-group">
            <label for="email">Email：</label>
            <input type="text" class="form-control" id="email" name="email" value="${user.email}"
                   placeholder="请输入邮箱地址"/>
        </div>

        <div class="form-group" style="text-align: center">
            <input class="btn btn-primary" type="submit" value="提交"/>
            <input class="btn btn-default" type="reset" value="重置"/>
            <input class="btn btn-default" type="button" id="return" value="返回"/>
        </div>
    </form>
</div>
</body>
</html>