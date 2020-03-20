<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2020/2/26
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <title>核对数据</title>
    <link href="<%=basePath%>static/icon/iconfont.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>



</head>
<body>
 <div id="app">



     <div>

         <el-form :label-position="labelPosition" ref="formhdsj" :model="form"
                  label-width="100px" size="small"

         >
             <el-row :gutter="gutter">

                 <el-col :span="spansize" :offset="offset">
                     <el-form-item label="患者姓名:">
                     <el-input v-model="form.vcname"  ></el-input>
                     </el-form-item>
                 </el-col>

                 <el-col :span="spansize" >
                     <el-form-item label="民族：">
                         <el-input v-model="form.vcnation"></el-input>
                     </el-form-item>
                 </el-col>
             </el-row>

             <el-row :gutter="gutter">
                 <el-col :span="spansize" :offset="offset">
                     <el-form-item label="性别：">
                         <el-input v-model="form.vcsex"></el-input>
                     </el-form-item>
                 </el-col>
                 <el-col :span="spansize">
                     <el-form-item label="职业：">
                         <el-input v-model="form.vcoccupation"></el-input>
                     </el-form-item>
                 </el-col>
             </el-row>

             <el-row :gutter="gutter">
                 <el-col :span="spansize" :offset="offset">
                     <el-form-item label="婚姻状况：">
                         <el-input v-model="form.vcmarry"></el-input>
                     </el-form-item>
                 </el-col>
                 <el-col :span="spansize">
                     <el-form-item label="教育程度：">
                         <el-input v-model="form.vceducation"></el-input>
                     </el-form-item>
                 </el-col>
             </el-row>

             <el-row :gutter="gutter">
                 <el-col :span="spansize" :offset="offset">
                     <el-form-item label="吸烟情况：">
                         <el-input v-model="form.vcsmoke"></el-input>
                     </el-form-item>
                 </el-col>
                 <el-col :span="spansize">
                     <el-form-item label="病案号：">
                         <el-input v-model="form.vcmdrecord"></el-input>
                     </el-form-item>
                 </el-col>
             </el-row>

             <el-row :gutter="gutter">
                 <el-col :span="spansize" :offset="offset">
                     <el-form-item label="入组编号：">
                         <el-input v-model="form.vcserialnum"></el-input>
                     </el-form-item>
                 </el-col>
                 <el-col :span="spansize">
                     <el-form-item label="身份证号：">
                         <el-input v-model="form.vcidentity"></el-input>
                     </el-form-item>
                 </el-col>
             </el-row>

             <el-row :gutter="gutter">
                 <el-col :span="spansize" :offset="offset">
                     <el-form-item label="手机号码：	">
                         <el-input v-model="form.vcphone"></el-input>
                     </el-form-item>
                 </el-col>
                 <el-col :span="spansize">
                     <el-form-item label="登记日期：">
                         <el-input v-model="form.dtregister"></el-input>
                     </el-form-item>
                 </el-col>
             </el-row>

             <el-row :gutter="gutter">
                 <el-col :span="14" :offset="offset">
                     <el-form-item label="家庭住址：">
                         <el-input v-model="form.vcaddress"></el-input>
                     </el-form-item>
                 </el-col>

             </el-row>


         </el-form>


     </div>


 </div>

 <script>
     <% String id=request.getParameter("id");%>
     new Vue({
         el: '#app',
         data() {
                 return {
                     labelPosition: 'right',
                     form: {

                     },
                     spansize:7,//占栏数
                     offset:5,//分栏偏移数
                     gutter:1,//间隔数







                 }
             },
         created:function(){
             this.loaddata();
         },
             methods: {
             ///加载表单数据
                 loaddata()
                 {
                     var self=this;
                     var data={
                        'id':<%=id%>
                     }
                     axios.get("<%=basePath%>admin/casehistory/selectbyid", {
                         params: data
                     }).then(function (response) {
                         self.form=response.data.object;
                         console.log(self.from.vcphone);
                     }).catch(function (error) {
                         console.log(error);
                     });
                 },
                 onSubmit() {
                     console.log('submit!');

                 },
                 //单点按钮，执行到下一个tab
                 changetab(){
                     console.log(<%=id%>)
                 },


             }


     });


 </script>



</body>
</html>
