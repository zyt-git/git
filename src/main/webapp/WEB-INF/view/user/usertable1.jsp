<%--
  Created by IntelliJ IDEA.
  User: ZYT
  Date: 2019/8/15
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>用户展示</title>
    <link rel="stylesheet" href="/js/bootstrop/css/bootstrap.min.css">
    <link rel="stylesheet" href="/js/DataTables/css/dataTables.bootstrap.min.css">
</head>

<body>
    <form>
        &nbsp;&nbsp;&nbsp;&nbsp;用户名称：<input type="text" id="username" placeholder="请输入用户名称"><br>
        &nbsp;&nbsp;&nbsp;&nbsp;真实姓名：<input type="text" id="realname" placeholder="请输入真实姓名"><br>
        <input type="button" value="搜索" onclick="search()" class="btn btn-default" >
        <input type="reset" class="btn btn-default">
    </form>
    <button class="btn btn-default"  data-toggle="modal" data-target="#myModal">增加</button>
    <table id="table_id_example" class="table table-striped table-bordered">
        <thead>
            <tr>
                <td>id</td>
                <td>用户名称</td>
                <td>真实姓名</td>
                <td>性别</td>
                <td>年龄</td>
                <td>手机号</td>
                <td>邮箱</td>
                <td>操作</td>
            </tr>
        </thead>
    </table>

    <!-- 增加 -->
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"  >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">用户增加</h4>
                </div>
                <div>
                    <form action="/user/add.do" method="post">
                        用户名称：<input name="userName" placeholder="请输入用户名称"><br>
                        真实姓名：<input name="realName" placeholder="请输入真实姓名"><br>
                        密码：<input type="password" name="password" placeholder="请输入密码"><br>
                        性别：<input type="radio" name="sex" value="0"/>女
                              <input type="radio" name="sex" value="1"/>男<br>
                        年龄：<input type="text" name="age"/><br>
                        电话：<input type="text" name="phone"/><br>
                        邮箱：<input type="text" name="email"/><br>
                        <input type="submit" class="btn btn-default">
                        <input type="reset" class="btn btn-default">
                    </form>
                </div>
                <div class="modal-footer" >
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <!-- 修改 -->
    <div class="modal fade" id="xiugai" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" >用户修改</h4>
                </div>

                    <form action="/user/update.do" method="post">
                        <input type="hidden" name="id" id="hid">
                        用户名称：<input name="userName"  id="xusername" placeholder="请输入用户名称"><br>
                        真实名称：<input name="realName"  id="xrealname" placeholder="请输入真实名称"><br>
                        性别：<input type="radio" name="sex" value="0"/>女
                        <input type="radio" name="sex" value="1"/>男<br>
                        年龄：<input type="text" name="age" id="xage"/><br>
                        电话：<input type="text" name="phone" id="xphone"/><br>
                        邮箱：<input type="text" name="email" id="xemail"/><br>
                        <input type="submit" class="btn btn-default">
                        <input type="reset" class="btn btn-default">
                    </form>

                <div class="modal-footer" >
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <script src="/js/jquery-3.3.1.js"></script>
    <script src="/js/DataTables/js/jquery.dataTables.min.js"></script>
    <script src="/js/DataTables/js/dataTables.bootstrap.min.js"></script>
    <script>
        var table;
        $(function(){
            table=$('#table_id_example').DataTable({
                "serverSide": true,//开启服务的模式
                "ajax":{
                    "url":"/user/queryListJson1.do",
                    "type":"post"
                },
                columns: [
                    {data:'id'},
                    {data:'userName'},
                    {data:'realName'},
                    {data:'sex',render:function(data, type, row, meta){
                            var sex=data==0?"女":data==1?"男":"";
                            return sex;
                        }},
                    {data:'age'},
                    {data:'phone'},
                    {data:'email'},
                    {data:'id',render:function(data, type, row, meta){
                            var strs=JSON.stringify(row);
                            var str="<input type='button' value='删除' onclick='del("+strs+")' class='btn btn-default'/>";
                            str+="<input type='button' value='修改' onclick='update("+strs+")' class='btn btn-default' data-toggle='modal' data-target='#xiugai' />"
                            return str;
                        }},
                ],
                "lengthMenu": [3,5, -1],
                //关闭查询
                "searching":false,
                "language":{
                    "url":"/js/DataTables/Chinese.json",
                }
            })
        })
        //搜索
        function search(){
            var username=$("#username").val();
            var realname=$("#realname").val();
            var data={
                "userName":username,
                "realName":realname,
            };
            table.settings()[0].ajax.data=data;
            table.ajax.reload();
        }

        //删除
        function del(strs){
            var id=strs.id;
            if(confirm("确定要删除吗")){
                location.href="/user/del.do?id="+id;
            }
        }

        //修改
        function update(strs){
            var id=strs.id;
            $("#hid").val(id);
            var username=strs.userName;
            $("#xusername").val(username);
            var realname=strs.realName;
            $("#xrealname").val(realname);
            var age=strs.age;
            $("#xage").val(age);
            var phone=strs.phone;
            $("#xphone").val(phone);
            var email=strs.email;
            $("#xemail").val(email);
            var sex=strs.sex;
            $("input[name='sex']").each(function(){
                if(sex==this.value){
                    this.checked=true;
                }
            })
        }
    </script>
</body>
</html>
