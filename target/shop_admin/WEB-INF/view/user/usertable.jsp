<%--
  Created by IntelliJ IDEA.
  User: ZYT
  Date: 2019/8/13
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link rel="stylesheet" type="text/css" href="/js/datatable/DataTables-1.10.18/css/jquery.dataTables.css">
<script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" charset="utf8" src="/js/datatable/DataTables-1.10.18/js/jquery.dataTables.js"></script>
<link rel="stylesheet" href="/js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript" src="/js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<head>
    <title>Title</title>
</head>
<script>
    var table;
    $(document).ready( function () {
        $.post({
            "url":"/user/queryListJson.do",
            dataType:"json",
            success:function(data){
                //alert(JSON.stringify(data))
                table=$("#table_id_example").DataTable({
                    data:data,
                    "lengthMenu": [5, -1,10],
                    columns: [
                        { data: 'id' },
                        { data: 'userName' },
                        { data: 'realName' },

                        {data:'id',render:function(data, type, row, meta){
                                var strs=JSON.stringify(row);
                                var str="<input type='button' value='删除' onclick='del("+strs+")' class='btn btn-default'/>";
                                str+="<input  type='button' value='修改' onclick='update("+strs+")' data-toggle='modal'   data-target='#xiugai' class='btn btn-default' />";
                                return  str;
                            }}
                    ],
                    language:{
                        "sProcessing": "处理中...",
                        "sLengthMenu": "显示 _MENU_ 项结果",
                        "sZeroRecords": "没有匹配结果",
                        "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
                        "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
                        "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                        "sInfoPostFix": "",
                        "sSearch": "搜索:",
                        "sUrl": "",
                        "sEmptyTable": "表中数据为空",
                        "sLoadingRecords": "载入中...",
                        "sInfoThousands": ",",
                        "oPaginate": {
                            "sFirst": "首页",
                            "sPrevious": "上页",
                            "sNext": "下页",
                            "sLast": "末页"
                        },
                        "oAria": {
                            "sSortAscending": ": 以升序排列此列",
                            "sSortDescending": ": 以降序排列此列"
                        }
                    }
                })
            },
            error:function () {
              alert("用户信息获取失败")
            }

        })
    })

</script>
<script>
    //删除
    function del(strs){
        var id=strs.id;
        location.href="/user/del.do?id="+id;
    }
    //修改
    function update(strs) {
        var ids=strs.id;
        id=$("#userid").val(ids);
        var username=strs.userName;
         userName=$("#userName").val(username);
        var realname=strs.realName;
         realName=$("#realName").val(realname);
    }

</script>
<body>
<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">增加</button>
    <table id="table_id_example" class="display">
        <thead>
            <tr>
                <td>id</td>
                <td>姓名</td>
                <td>真实姓名</td>
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
                    用户名称：<input name="userName"  placeholder="请输入用户名称"><br>
                    真实名称：<input name="realName" placeholder="请输入真实名称"><br>
                    密码：<input name="password" type="password" placeholder="请输入密码"><br>


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
                    <input type="hidden" name="id" id="userid">
                    用户名称<input name="userName" id="userName" placeholder="请输入用户名称"><br>
                    真实名字：<input name="realName" id="realName" placeholder="请输入真实名称"><br>

                    <input type="submit">
                    <input type="reset">
                </form>
            <div class="modal-footer" >
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
