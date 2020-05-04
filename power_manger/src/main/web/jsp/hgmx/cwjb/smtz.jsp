<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2020/3/28
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <title>测试</title>
    <link href="<%=basePath%>static/icon/iconfont.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
</head>
<body>

<div id="app">

    <el-form :label-position="labelPosition" ref="formhdsj" :model="form"
             label-width="100px" size="small"
             :disabled="istrue"

    >
        <el-row :gutter="gutter">

            <el-col :span="spansize" :offset="offset">
                <el-form-item label="身高:">
                    <el-input v-model="form.vchigh"  ></el-input>
                </el-form-item>
            </el-col>

            <el-col :span="spansize" >
                <el-form-item label="体重：">
                    <el-input v-model="form.vcweight"></el-input>
                </el-form-item>
            </el-col>
        </el-row>


        <el-row :gutter="gutter">

            <el-col :span="spansize" :offset="offset">
                <el-form-item label="收缩压:">
                    <el-input v-model="form.vcssy"  ></el-input>
                </el-form-item>
            </el-col>

            <el-col :span="spansize" >
                <el-form-item label="舒张压：">
                    <el-input v-model="form.vcszy"></el-input>
                </el-form-item>
            </el-col>
        </el-row>

        <el-row :gutter="gutter">
            <div>
            <el-col :span="4" :offset="6">
                    <el-radio v-model="form.bdel" label="0" >已检查</el-radio>
            </el-col>
            <el-col :span="4" :offset="1">
                <el-radio v-model="form.bdel" label="1"  >未检查</el-radio>
            </el-col>
            </div>
        </el-row>




    </el-form>
    <el-row :gutter="gutter" style="margin-top: 20px">

        <el-col :span="spansize" :offset="6">
            <el-button type="success" @click="savedata">确认保存</el-button>
        </el-col>

        <el-col :span="spansize" >
            <el-button type="info" @click="modify">修改数据 </el-button>
        </el-col>
    </el-row>

</div>
<script>
    <% String id=request.getParameter("id");%>
    new Vue({
        el: '#app',
        data() {
            return {
                istrue:false,
                labelPosition: 'center',
                spansize: 5,
                gutter: 1,//间隔数
                id:<%=id%>,
                form:{
                },
                offset:4,
                radio1: '0',


            }
        },
        created: function ()
        {
            this.getdata();

        },
        methods:{

            getdata()
            {
                var self=this;
                var data={'id':self.id}
                axios.get("<%=basePath%>admin/smtz/select", {
                    params: data
                }).then(function (response) {
                    self.form = response.data.object;
                    self.istrue=true;

                }).catch(function (error) {
                    console.log(error);
                });



            },
            //提交数据
            savedata()
            {
                var vitalsigns=this.form;
                var self=this;
                if (vitalsigns.icaseid==null)
                {
                    vitalsigns.icaseid=self.id;
                }
                axios.get("<%=basePath%>admin/smtz/save", {
                    params: vitalsigns
                }).then(function (response) {
                    if (response.data.code == '10000') {
                        self.$message({
                            type: 'success',
                            message: '保存成功!'

                        });
                    }
                    self.getdata();
                    self.istrue=true;

                }).catch(function (error) {
                    console.log(error);
                });

            },
            modify()
            {
                this.istrue=false;
            }

        }
    });
</script>


</body>
</html>
