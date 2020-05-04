<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2019/12/2
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>密码修改界面</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
</head>
<body >

<div id="app">
     <div style="width: 350px">
         <el-form :label-position="labelPosition" label-width="100px" :model="formLabelAlign">
             <el-form-item label="当前密码">
                 <el-input v-model="formLabelAlign.name"></el-input>
             </el-form-item>
             <el-form-item label="新密码">
                 <el-input v-model="formLabelAlign.region"></el-input>
             </el-form-item>
             <el-form-item label="确认新密码">
                 <el-input v-model="formLabelAlign.type"></el-input>
             </el-form-item>
         </el-form>
         <div style="position: absolute ;left: 150px">
             <el-button type="primary" round @click="modifypassword">确认修改</el-button>

         </div>


     </div>

</div>

<script>

    new Vue({
        el: '#app',
        data: function () {
            return {
                labelPosition: 'right',
                formLabelAlign: {
                    name: '',
                    region: '',
                    type: '',
                },
                managerId:'',

            }
        },
        created:function(){

        },
        methods: {
            modifypassword()
            {
                var self=this;
                if (this.formLabelAlign.region!=this.formLabelAlign.type)
                {
                    self.$message({
                        type: 'error',
                        message: '新密码不一致，请核对!'
                    });
                    return false;
                }
                self.managerId='${sessionScope.manager.managerId}' ;
              // this.manager=manager
             // console.log("修改密码测试"+self.managerId)
               var data={  id:self.managerId,
                           pwd:this.formLabelAlign.name,
                           newpwd:this.formLabelAlign.type

              }
                axios.get("<%=basePath%>admin/manager/modifypassword", {params: data}

                ) .then(function (response){
                    if (response.data.code == '10000') {
                        self.$message({
                            type: 'success',
                            message: '密码修改成功!'
                        });
                        self.formLabelAlign={};
                    }
                    else if (response.data.code == '20001')
                    {
                        self.$message({
                            type: 'error',
                            message: '原密码错误，请核对!'
                        });

                    }

                }).catch(function (error){
                    self.$message({
                        type: 'error',
                        message: '网络异常'
                    });
                });
            }

        }

    });


</script>



</body>
</html>
