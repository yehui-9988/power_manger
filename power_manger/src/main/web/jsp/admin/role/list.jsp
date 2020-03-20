<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2019/10/9
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>角色列表</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <script src="https://cdn.bootcss.com/qs/6.5.1/qs.min.js"></script>
    <style>
        body{
            padding: 0px;
            margin: 0px;
        }
        .avatar-uploader .el-upload {
            border: 1px dashed #d9d9d9;
            border-radius: 6px;
            cursor: pointer;
            position: relative;
            overflow: hidden;

        }
        .avatar-uploader .el-upload:hover {
            border-color: #409EFF;
        }
        .avatar-uploader-icon {
            font-size: 28px;
            color: #8c939d;
            width: 78px;
            height: 78px;
            line-height: 78px;
            text-align: center;
        }
        .avatar {
            width: 108px;
            height: 108px;
            display: block;
        }


    </style>
</head>
<body>
 <div id="app">

     <div style="margin-bottom: 10px;margin-top: 10px" >

         <el-row :gutter="20">
             <el-col :span="8">
                 <div class="grid-content bg-purple">
                     <el-button-group>
                         <el-button type="primary" icon="el-icon-circle-plus-outline " @click="save"></el-button>
                         <el-button type="primary" icon="el-icon-share"></el-button>

                     </el-button-group>

                 </div>
             </el-col>

             <el-col :span="16">

             </el-col>
         </el-row>

     </div>
         <el-dialog title="角色管理" :visible.sync="dialogFormVisible">
             <el-form ref="role" :model="role" label-width="120px">
                 <el-form-item label="角色名称" prop="roleName">
                     <el-input v-model="role.roleName"></el-input>
                 </el-form-item>
             </el-form>
             <div slot="footer" class="dialog-footer">
                 <el-button  >取 消</el-button>
                 <el-button type="primary" @click="submitForm('role')">确 定</el-button>
             </div>
         </el-dialog>
<%--///授权--%>
     <el-dialog title="授权" :visible.sync="dialogpowerVisible" @closed="closedialogpower">
         <el-tree :data="data"
                  show-checkbox
                  ref="tree"
                  node-key="menuId"
                  :props="defaultProps"
                  @node-click="handleNodeClick"
                  :default-expand-all="true"
                  :check-on-click-node="true"
                  :default-checked-keys="ckarry"
                  <%--@check-change="savepower"--%>
         >


         </el-tree>
         <div slot="footer" class="dialog-footer">
             <el-button    @click="closedialogpower()">取 消</el-button>
             <el-button type="primary" @click="savepower()">确 定</el-button>
         </div>
     </el-dialog>



     <template>
         <el-table
                 :data="list"
                 ref="tb1"
                 border
                 style="width: 100%">

             <el-table-column
                     fixed
                     prop="roleId"
                     label="ID"
                     width="100">
             </el-table-column>

             <el-table-column
                     prop="roleName"
                     label="姓名"
                     width="120">
             </el-table-column>

             <el-table-column
                     prop="roleCreatetime"
                     label="创建时间"
                     width="200">
             </el-table-column>
             <el-table-column
                     prop="roleLastmodify"
                     label="修改时间"
                     width="300">
             </el-table-column>

             <el-table-column
                     fixed="right"
                     label="操作"
                     >
                 <template slot-scope="scope">
                     <el-button @click="power(scope.row.roleId)" type="text" size="small">授权</el-button>
                     <el-button @click="handleClick(scope.row)" type="text" size="small">编辑</el-button>
                     <el-button @click="deletebyid(scope.row.roleId)" type="text" size="small">删除</el-button>
                 </template>
             </el-table-column>
         </el-table>
     </template>


 </div>



 <script>
   new Vue({
       el: '#app',
       data: function () {
           return {

               ///默认选中的数组
               ckarry:[],
               data: [],
               list: [],
               defaultProps: {
                   children: 'list',
                   label: 'menuTitle'
               },
               dialogFormVisible: false,
               dialogpowerVisible: false,
               role: {},
               formLabelWidth: "100px ",
               rules: {
                   roleName: [
                       {required: true, message: '请输入姓名', trigger: 'blur'},
                       {max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur'}
                   ],
               },
               currentid:0,


           }
       },
       created: function () {
           console.log("nihao");
           this.getdata()
       },
       methods: {

           getpowerlis()
           {


           },
           closedialogpower(){
               this.dialogpowerVisible=false;
               ///点击窗口X 刷新数组 防止默认勾选
               this.ckarry=[];


           },
           savepower()
           {
                   ///获取选中的节点
                   var e=this.$refs.tree.getCheckedNodes(false,false)
                   console.log(e[0])
                   var ids=[];
               for (var i=0;i<e.length;i++)
               {
                 ids.push(e[i].menuId )
               }
               var  data={

                   menuIds:ids.join(","),
                   roleid:this.currentid
               }

               var self=this;

               axios.get("<%=basePath%>admin/role/power",{params:data}
               ).then(function (response) {
                   self.dialogpowerVisible=false;

                   self.$message({
                   type: 'success',
                   message: '保存成功'
                   });



               }).catch(function (error) {

                       self.$message({
                       type: 'error',
                       message: '网络异常'
                       });

               });

           },
////点击授权获取当前的roleid
           power: function (roleid) {
               var self=this;
               self.dialogpowerVisible = true;
               self.currentid=roleid;
               self.inittree();

               axios.get("<%=basePath%>admin/role/powerlist",{
                       params:{
                           'roleid': roleid
                       }
                   }
               ).then(function (response) {
                   self.ckarry=[];
                   var list=response.data.object;
                   console.log("list:"+list[0].rmrfMenuid)

                   if (response.data.code == '10000') {

                        for (var i=0;i<list.length;i++)
                        {

                            self.ckarry.push(list[i].rmrfMenuid)
                            console.log(self.ckarry)
                            console.log("执行了")
                        }
                       self.inittree();
                       self.dialogpowerVisible = true;

                   }

               }).catch(function (error) {


               });

           },
           inittree: function () {
               var self = this;
               axios.get("<%=basePath%>admin/menu/list",
               ).then(function (response) {
                   self.data = response.data.object;

               }).catch(function (error) {
                   self.$message({
                       type: 'error',
                       message: '网络异常'
                   });

               });

           },
           ///表单的规则验证
           submitForm(role) {

               this.$refs[role].validate((valid) => {
                   if (valid) {
                       this.submitAxios()
                   } else {
                       console.log('error submit!!');
                       return false;
                   }
               });
           },
           resetForm(formName) {
               this.$refs[formName].resetFields();
           },
           ///打开dialog
           save: function () {

               this.dialogFormVisible = true;
           },

           //获取数据的方法 请求ajax
           submitAxios: function () {
               var self = this;

               axios.post('<%=basePath%>admin/role/save', Qs.stringify(self.role))
                   .then(function (response) {
                       if (response.data.code == '10000') {
                           self.$message({
                               type: 'success',
                               message: '保存成功'
                           });
                           self.getdata();
                           self.dialogFormVisible = false;
                       }

                   }).catch(function (response) {
                   self.$message({
                       type: 'error',
                       message: '添加失败!'
                   });
                   self.getdata();
                   self.dialogFormVisible = false;

               })
           },
           getdata: function () {
               console.log("调用了getdata")
               var self = this;
               axios.get("<%=basePath%>admin/role/list")
                   .then(function (response) {

                       if (response.data.code == '10000') {
                           self.list = response.data.object;


                       }

                   }).catch(function (error) {
                   console.log(error);
               });

           },
           deletebyid: function (id) {
               var self = this;
               this.$confirm('此操作将永久删除该数据, 是否继续?', '提示', {
                   confirmButtonText: '确定',
                   cancelButtonText: '取消',
                   type: 'warning'
               }).then(() => {
                   axios.get("<%=basePath%>admin/role/delete", {
                       params: {
                           'id': id
                       }
                   }).then(function (response) {
                       console.log("值" + response)
                       if (response.data.code == '10000') {
                           self.$message({
                               type: 'success',
                               message: '删除成功!'
                           });
                           self.getdata();
                       }
                       else {
                           self.$message({
                               type: 'error',
                               message: '删除失败!'
                           });
                           self.getdata();
                       }

                   }).catch(function (error) {
                       console.log(error);
                   });
               }).catch(() => {
                   this.$message({
                       type: 'info',
                       message: '已取消删除'
                   });
               });
           },
           handleNodeClick(data, node) {
               console.log(data)


           },

       }


   })

 </script>



</body>
</html>
