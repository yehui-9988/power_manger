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
    <title>人员管理</title>

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
       <div style="margin-bottom:10px;margin-top:10px" >

           <el-row :gutter="20">
               <el-col :span="6">
                   <el-button-group>
                       <el-button type="primary" icon="el-icon-circle-plus-outline " @click="save"></el-button>
                       <el-button type="primary" icon="el-icon-share"></el-button>
                       <el-button type="primary" icon="el-icon-delete" @click="deleteall"></el-button>
                   </el-button-group>
               </el-col>

               <el-col :span="3">
                       <a href="<%=basePath%>static/template/manager.xlsx">模板下载</a>
               </el-col>

               <el-col :span="9">
                       <el-upload
                               class="upload-demo"
                                action="<%=basePath%>admin/manager/uploadall"
                               :on-success="importsuccess"
                               :on-error="importfail"
                               :show-file-list="false"
                       >
                           <el-button size="small" type="primary">批量添加</el-button>
                       </el-upload>
               </el-col>

               <el-col :span="4">


                       <el-input
                               @keyup.enter.native="search"
                               v-model="param"
                               size="mini"
                               placeholder="输入关键字搜索"/>
                   <el-button slot="append" icon="el-icon-search" @click="search"></el-button>

               </el-col>
           </el-row>

       </div>

         <el-dialog title="人员管理" :visible.sync="dialogFormVisible">
               <el-form :model="manager" ref="manager" :rules="rules" >
                   <div style="margin: 10px auto;text-align: center">
                         <el-upload
                                 class="avatar-uploader"
                                 action="<%=basePath%>admin/manager/upload"
                                 name="file"
                                 :show-file-list="false"
                                 :on-success="handleAvatarSuccess"
                                 :before-upload="beforeAvatarUpload">
                             <img v-if="imageUrl" :src="imageUrl" class="avatar">
                             <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                         </el-upload>

                   </div>
                 <el-form-item label="姓名" :label-width="formLabelWidth"  prop="managerName">
                     <el-input v-model="manager.managerName" autocomplete="off" ></el-input>
                 </el-form-item>
                 <el-form-item label="身份证号码" :label-width="formLabelWidth" prop="managerIdcard">
                     <el-input placeholder="请输入身份证号码" v-model="manager.managerIdcard" autocomplete="off" ></el-input>
                 </el-form-item>

                 <el-form-item label="性别" :label-width="formLabelWidth" prop="managerSex">
                     <el-select v-model="manager.managerSex" placeholder="请选择性别">
                         <el-option label="男" value="男"></el-option>
                         <el-option label="女" value="女"></el-option>
                     </el-select>
                 </el-form-item>

                 <el-form-item label="电话"  :label-width="formLabelWidth" prop="managerPhone">
                     <el-input v-model="manager.managerPhone" autocomplete="off" placeholder="请输入电话号码" ></el-input>
                 </el-form-item>
             </el-form>
             <div slot="footer" class="dialog-footer">
                 <el-button  >取 消</el-button>
                 <el-button type="primary" @click="submitForm('manager')">确 定</el-button>
             </div>
         </el-dialog>
<%--授权的信息的dialog--%>
     <el-dialog title="授权信息" :visible.sync="dialogpowerVisible">

         <el-checkbox-group v-model="checkedroels" @change="handleCheckedrolesChange">
             <el-checkbox v-for="role in roles" :label="role.roleId" :key="role.roleName">{{role.roleName}}</el-checkbox>
         </el-checkbox-group>
         <div slot="footer" class="dialog-footer">

             <el-button type="primary" @click="savepower">确 定</el-button>
         </div>
     </el-dialog>


         <template>
         <el-table
                 :data="list"
                 ref="tb1"
                 border
                 :default-sort = "{prop: 'managerId', order: 'descending'}"
                 @sort-change="sort"
                 style="width:100%;"
                 :row-style="{height:'0px'}"
                 :cell-style="{padding:'0px'}">
             <el-table-column
                     type="selection"
                     width="55"

             >
             </el-table-column>
             <el-table-column
                     fixed
                     sortable
                     prop="managerId"
                     label="ID"
                     width="100">
             </el-table-column>

             <el-table-column
                     prop="managerName"
                     label="姓名"
                     width="120">
             </el-table-column>
             <el-table-column
                     label="头像"
                     width="180">
                 <template slot-scope="scope">

                     <img  style="height: 50px; width: 150px" :src="'<%=basePath%>'+scope.row.managerImg" onerror="javascript:this.src='<%=basePath%>static/imgs/default.jpg'">
                     <%--scope.row.managerImg--%>
                 </template>
             </el-table-column>

             <el-table-column
                     prop="managerPhone"
                     label="电话"
                     width="200">
             </el-table-column>
             <el-table-column
                     prop="managerSex"
                     label="性别"
                     width="120">
             </el-table-column>
             <el-table-column
                     prop="managerIdcard"
                     label="身份证号码"
                     width="200">
             </el-table-column>
             <el-table-column
                     prop="managerCreatetime"
                     label="创建时间"
                     width="200">
             </el-table-column>
             <el-table-column
                     prop="rolestr"
                     label="权限"
                     width="200">
             </el-table-column>
             <el-table-column
                     prop="managerLastmodify"
                     label="修改时间"
                     width="300">
             </el-table-column>

             <el-table-column
                     fixed="right"
                     label="操作"
                     width="200">
                 <template slot-scope="scope">
                     <el-button @click="openpowerdialog(scope.row)" type="text" size="small" >授权</el-button>
                     <el-button @click="editmanager(scope)" type="text" size="small">编辑</el-button>
                     <el-button @click="deletebyid(scope.row.managerId)" type="text" size="small">删除</el-button>
                 </template>
             </el-table-column>
         </el-table>
     </template>

         <el-pagination
                 background
                 layout=" prev, pager, next,sizes ,jumper"
                 :total="page.total"
                 :page-size="page.size"
                 :page-sizes="[5, 10, 15, 20]"
                 @current-change="changepage"
                 @size-change="handleSizeChange"
         >
         </el-pagination>

 </div>



 <script>
   new Vue({
       el: '#app',
       data:function() {
           return {
               param:'',
               order:'asc',
               pro:'managerId',
               ids:[],
               currentid:0,
               checkedroels:[],
               roles:[],
               list: [],
               defaultimg: 'this.src=<%=basePath%>static/imgs/default.jpg',
               page: {
                   total: 0,
                   index: 1,
                   size: 20
               },
               dialogFormVisible: false,
               dialogpowerVisible:false,

               manager: {
                   managerName:'叶辉',
                   managerIdcard:'362329199703103019',
                   managerPhone:'15879900515',
                   managerSex:'男'

               },
               imageUrl: '<%=basePath%>static/imgs/default.jpg',
               formLabelWidth: "100px ",
               rules: {
                   managerName: [
                       {required: true, message: '请输入姓名', trigger: 'blur'},
                       { max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur'}
                   ],
                   managerPhone: [
                       {required: true, message: '请输入电话', trigger: 'blur'},

                       { pattern: /^1(3|4|5|6|7|8)\d{9}$/,message:'请输入正确的手机号码' }
                   ],
                   managerSex: [
                       {required: true, message: '请选择性别', trigger: 'change'},

                   ],
                   managerIdcard: [
                       {required: true, message: '请输入身份证号码', trigger: 'change'},

                       { pattern: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,message:'请输入正确的身份证号码' }
                   ],
               },


           }
       },
       created:function(){
           console.log("nihao");
           this.getdata();
           this.getRoles();

          
       },
       methods: {

           search(e )
           {
               console.log("查找"+e.keyCode)
               this.getdata();
           },

           //参数方法
           sort(e){

               if (e.order=='ascending')
               {
                   this.order='asc';
               }
               else {
                   this.order='desc';
               }
               this.pro=e.prop;
               this.getdata();
               console.log(e.prop+"--"+e.order)

           },
           savepower(){

               var data=
                   {
                       'roleids':this.ids.join(','),
                       'manageid':this.currentid

                   }
               console.log("_____"+data.roleids)
               console.log("+++++"+data.manageid)
               var self=this;
               axios.post("<%=basePath%>admin/manager/savepower",
                   Qs.stringify(data)
               ).then(function (response) {
                   console.log("值" + response)

                   if (response.data.code == '10000') {
                       self.$message({
                           type: 'success',
                           message: '保存成功!'
                       });

                   }
                   else {
                       self.dialogpowerVisible=false;
                   }
                   self.getdata();
                   self.dialogpowerVisible=false;


               }).catch(function (error) {
                   console.log(error);
               });

           },
           ///选择框改变 触发该方法
           handleCheckedrolesChange(e){

               console.log(e)
               this.ids=[];
               for (var i=0;i<this.checkedroels.length;i++)
               {
                   this.ids.push(this.checkedroels[i])

               }




           },
           ///打开权限管理的dialog
           openpowerdialog(e){
               this.checkedroels=[];
               this.dialogpowerVisible=true;
               this.currentid=e.managerId;


               for (var i=0;i<e.roles.length;i++)
               {
                   this.checkedroels.push(e.roles[i].roleId);

               }


           },
           ///编辑的功能
           editmanager(e)
           {
               this.dialogFormVisible = true;
               console.log("编辑功能的表格数据："+e.row);
               // this.manager={};
               this.manager=e.row;
               <%--this.imageUrl='<%=basePath%>static/imgs/default.jpg'--%>
               //打开dialog使得manager头像默认显示；
               this.imageUrl="<%=basePath%>"+e.row.managerImg;
               console.log("managerUrl:"+this.imageUrl);



           },


           getRoles: function () {
           console.log("调用了getdata")
           var self = this;
           axios.get("<%=basePath%>admin/role/list")
               .then(function (response) {

                   if (response.data.code == '10000') {
                       self.roles = response.data.object;


                   }

               }).catch(function (error) {
               console.log(error);
           });

           },
           deleteall:function(){
               var rows=this.$refs.tb1.selection;
               console.log("rows:"+rows)
               var ids=[];
               for (var i=0;i<rows.length;i++){
                   ids.push(rows[i].managerId)
                   console.log("IDS"+ids.join(','))
               }
               if (ids.length<=0)
               {
                   this.$message({
                       type: 'error',
                       message: '请选择删除的数据!'
                   });
               }
               var self=this;
               var data={'ids': ids.join(',')}
               axios.get('<%=basePath%>admin/manager/deleteall', {params: data})
                   .then(function (response) {
                       if (response.data.code=='10000')
                       {
                           self.$message({
                           type: 'success',
                           message: '删除成功'
                       });
                           self.getdata();

                       }

                   }).catch(function (response) {
                       self.$message({
                           type: 'error',
                           message: '删除失败!'
                       });

               });


           },
           importsuccess:function(response, file, fileList)
           {
               console.log("批量导入的"+response+"----"+file+"-----"+fileList)
              if (response.code='10000')
              {
                  this.$message({
                      type: 'success',
                      message: '上传成功'
                  });
                  this.getdata();
              }else {
                  this.$message({
                      type: 'error',
                      message: '上传失败'
                  });
              }
           },
           importfail:function(){
               this.$message({
                   type: 'error',
                   message: '网络异常'
               });
           },
           ///表单的规则验证
           submitForm(manager1) {

               this.$refs[manager1].validate((valid) => {
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

           //获取数据的方法
           handleAvatarSuccess(res, file) {
               this.imageUrl = URL.createObjectURL(file.raw);
               if (res.code=='10000')
               {
                this.manager.managerImg=res.object;
               }
           },
           beforeAvatarUpload(file) {
               const isJPG = file.type === 'image/jpeg';
               const isLt2M = file.size / 1024 / 1024 < 2;

               if (!isJPG) {
                   this.$message.error('上传头像图片只能是 JPG 格式!');
               }
               if (!isLt2M) {
                   this.$message.error('上传头像图片大小不能超过 2MB!');
               }
               return isJPG && isLt2M;

           },
           ///save或者修改的ajax的请求
           submitAxios:function(){
                var self=this;
                // console.log("测试manager"+self.manager);

                    axios.post('<%=basePath%>admin/manager/save', Qs.stringify(self.manager))
                    .then(function (response) {
                        if (response.data.code=='10000')
                        {
                            self.$message({
                                type: 'success',
                                message: '保存成功'
                            });
                            self.getdata();
                            self.dialogFormVisible=false;
                        }
                        else
                        {
                            self.$message({
                                type: 'error',
                                message: '添加失败'
                            });
                        }

                    }).catch(function (response) {
                    self.$message({
                        type: 'error',
                        message: '添加失败!'
                    });
                    self.getdata();
                    self.dialogFormVisible=false;

                })
           },
           save: function () {
               console.log("点击了save")
               this.dialogFormVisible = true;

           },
           ///分页
           getdata: function () {
               console.log("调用了getdata  ")
               var self = this;
               var data = {
                   'index': self.page.index,
                   'size': self.page.size,
                   'order':self.order,
                   'prop':self.pro,
                   'param':self.param
               }

               axios.get("<%=basePath%>admin/manager/list", {
                   params: data
               }).then(function (response) {
                   console.log(response)
                   if (response.data.code == '10000') {
                       self.list = response.data.object.list;
                       self.page.total = response.data.object.total;
                       // var roels=response.data.object.list.roles
                       // for (var i=0;i++;i<roels.length)
                       // {
                       //     self.checkedroels.push(roels[i].roleid)
                       // }



                       console.log(self.checkedroels)
                   }

               }).catch(function (error) {
                   console.log(error);
               });

           },
           changepage: function (page1) {
               console.log(page1)
               this.page.index = page1;
               this.getdata()

           },
           handleSizeChange: function (val) {
               this.page.size = val;
               console.log("pagesize"+ this.page.size)
               this.getdata();
           },
           deletebyid: function (id) {
               var self = this;
               this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
                   confirmButtonText: '确定',
                   cancelButtonText: '取消',
                   type: 'warning'
               }).then(() => {
                   axios.get("<%=basePath%>admin/manager/delete", {
                       params: {
                           'id': id
                       }
                   }).then(function (response) {
                       console.log("值" + response)
                       // self.$message({
                       //     type: 'success',
                       //     message: '删除成功!'
                       // });
                       // self.getdata();
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
                               message: '删除成功!'
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


           }


       },

   })

 </script>



</body>
</html>
