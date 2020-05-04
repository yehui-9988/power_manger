<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2019/12/26
  Time: 13:38
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>基线数据</title>

    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>

    <script src="https://cdn.bootcss.com/qs/6.5.1/qs.min.js"></script>

    <style>
        .el-tabs__header{
            margin: 0 0 2px;
        }

    </style>
</head>
<body >
<div id="app">
    <!--打开编辑 核对数据的选项卡 -->
    <el-dialog title="信息核对" :visible.sync="dialogsjgl"
               width="80%" height="500px"
               @close="getdata()"
               top="0vh"
   >
        <template>
            <div>
                <el-row>
                    <el-tabs v-model="editableTabsValue" type="card" @tab-click="handleclick">
                        <el-tab-pane
                                v-for="(item, index) in editableTabs"
                                :key="item.name"
                                :label="item.title"
                                :name="item.name"
                        >
                         <iframe :src="item.src+icasehistoryid" width="100%" height="70%"  frameborder="0"> </iframe>
                        </el-tab-pane>
                    </el-tabs>
                </el-row>
            </div>
        </template>
    </el-dialog>
    <%--
    增加新数据弹出dialog
    --%>
    <el-dialog title="新增数据" :visible.sync="dialogxzsj"
               width="80%" height="400px"
               @close="getdata()"
               top="10vh"
    >
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
            <el-row :gutter="gutter">
                <el-col :span="12" :offset="11">
                    <el-button type="primary" @click="onSubmit()">确认保存</el-button>
                </el-col>

            </el-row>
        </div>
    </el-dialog>

    <div style="margin-bottom:5px;margin-top:5px" >
        <el-row :gutter="20">
            <el-col :span="6">
                <el-button-group>
                    <el-button type="primary" round size="small" @click="savexzsj">新增数据</el-button>
                </el-button-group>
            </el-col>
        </el-row>
    </div>

<template>
    <el-table
            :data="list"
            ref="tb1"
            border
            :default-sort = "{prop: 'managerId', order: 'descending'}"
            style="width:100%;"
            :row-style="{height:'10px'}"
            :cell-style="{padding:'5px'}">
        <el-table-column
                type="selection"
                width="55"
        >
        </el-table-column>
        <el-table-column
                fixed
                sortable
                prop="icasehistoryid"
                label="ID"
                width="120"

        >
        </el-table-column>

        <el-table-column
                prop="vcname"
                label="患者姓名"
                width="150">
        </el-table-column>
     <%--   <el-table-column
                label="头像"
                width="180">
            <template slot-scope="scope">
                <img  style="height: 50px; width: 150px" :src="'<%=basePath%>'+scope.row.managerImg" onerror="javascript:this.src='<%=basePath%>static/imgs/default.jpg'">
                &lt;%&ndash;scope.row.managerImg&ndash;%&gt;
            </template>
        </el-table-column>--%>
        <el-table-column
                prop="vcphone"
                label="电话号码"
                width="150">
        </el-table-column>
        <el-table-column
                prop="vcserialnum"
                label="患者入组编号"
                width="200">
        </el-table-column>
        <el-table-column
                prop="vcidentity"
                label="身份证号码"
                width="200">
        </el-table-column>
        <el-table-column
                prop="vcmdrecord"
                label="病案号"
                width="200">
        </el-table-column>
        <el-table-column
                prop="dtregister"
                label="登记时间"
                width="200">
        </el-table-column>

        <el-table-column
                fixed="right"
                label="操作"
                width="200">
            <template slot-scope="scope">

                <el-button @click="selectrow(scope.row)" type="success" size="mini">编辑</el-button>
                <el-button @click="deleterow(scope.row)" type="danger" size="mini">删除</el-button>
            </template>
        </el-table-column>
    </el-table>



</template>
    <el-pagination
            background
            layout=" prev, pager, next,sizes ,jumper"
            :total="page.total"
            :page-size="page.size"
            :page-sizes="[1, 5, 10]"
            @current-change="changepage"
            @size-change="handleSizeChange"

    >
    </el-pagination>

</div>

<script>
    new Vue({
        el: '#app',
        data: function () {
            return {
                labelPosition: 'right',
                form: {},
                spansize: 7,//占栏数
                offset: 5,//分栏偏移数
                gutter: 1,//间隔数
                icasehistoryid:'',
                maxid:'',
                page: {
                    total: 20,
                    index: 1,
                    size: 10
                },
                labelbutton:'下一步',
                list:[],
                editableTabsValue: '1',
                testvalue:'2',
                editableTabs: [{
                    title: '核对数据',
                    name: '1',
                    src:'<%=basePath%>jsp/hgmx/cwjb/hdsj.jsp?id='
                }, {
                    title: '疾病历史',
                    name: '2',
                    src:'<%=basePath%>jsp/hgmx/cwjb/jbls.jsp?id='
                },{
                    title: '生命体征',
                    name: '3',
                    src:'<%=basePath%>jsp/hgmx/cwjb/smtz.jsp?id='
                },{
                    title: '研究前用药',
                    name: '4',
                    src:'<%=basePath%>jsp/hgmx/cwjb/yjqyy.jsp?id='
                },{
                    title: '脾气虚症状',
                    name: '5',
                    src:'<%=basePath%>jsp/hgmx/cwjb/hdsj.jsp?id='
                },{
                    title: '检查单报告',
                    name: '6',
                    src:'<%=basePath%>jsp/hgmx/cwjb/hdsj.jsp?id='
                },{
                    title: '医生处方记录',
                    name: '7',
                    src:'<%=basePath%>jsp/hgmx/cwjb/hdsj.jsp?id='
                },
                    ],
                dialogsjgl:false,
                dialogxzsj:false,
            }

        },
        created:function(){
          this.getdata();

        },
        computed: {
            update(){
                return this.testvalue
            }


        },
        methods: {

            //新增数据
            onSubmit() {
                var self = this;
                self.form.vctype = 3;
                var casehistory = self.form;
                axios.post("<%=basePath%>admin/casehistory/savecasehistory", Qs.stringify(casehistory))
                    .then(function (response) {
                        if (response.data.code == 10000) {
                            self.$message({
                                type: 'success',
                                message: "保存成功!"
                            });
                            self.getdata();
                            self.dialogxzsj=false;
                        }
                    });
            },

            //删除病历
              deletesuccess(id){
                  var self=this;
                 var data={
                      "id":id
                  }
                  axios.get("<%=basePath%>admin/casehistory/deletecasehistory",{params:data})
                      .then(function (response) {
                          if (response.data.code == '10000') {
                              self.$message({
                                  type: 'success',
                                  message: '删除成功!'

                              });
                              self.getdata();
                          }

                      }).catch(function (error) {

                  });

              },
            deleterow(row){
                   this.$confirm('此操作将永久删除数据, 是否继续?', '提示', {
                       confirmButtonText: '确定',
                       cancelButtonText: '取消',
                       type: 'warning',
                       center: true
                   }).then(() => {
                       this.deletesuccess(row.icasehistoryid)

                   }).catch(() => {
                       this.$message({
                           type: 'info',
                           message: '已取消删除'
                       });
                   });

            },

            //分页
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
            //获取表格数据
            getdata: function () {

                var self = this;
                var data = {
                    'index': self.page.index,
                    'size': self.page.size
                }
                axios.get("<%=basePath%>admin/casehistory/selectall",{params:data})
                    .then(function (response) {

                        if (response.data.code == '10000') {
                            self.list = response.data.object.list;
                            self.page.total = response.data.object.total;
                        }

                    }).catch(function (error) {

                });
            },
            //点击下一步 改变tab 选中
            changetab(){
                var editableTabsValue=parseInt(this.editableTabsValue)+1;

                this.editableTabsValue=editableTabsValue+'';
                if (editableTabsValue>=7)
                {
                    this.editableTabsValue=7+'';

                }

            },
            //tab被选中时，this.editableTabsValue的值更新
            handleclick(tab,event){
                this.editableTabsValue=tab.name;


            },
            //打开新的表格
            savejxsj() {
                this.dialogsjgl = true;
                var self = this;
                self.editableTabsValue=1+'';
                axios.get("<%=basePath%>admin/casehistory/selectmaxid")
                    .then(function (response) {

                        if (response.data.code == '10000') {
                            self.icasehistoryid =response.data.object+1;

                        }

                    }).catch(function (error) {

                });
            },
            //选择数据git config --global user.name“叶辉”
            selectrow(row)
            {
                this.dialogsjgl=true;
                this.editableTabsValue=1+'';
                this.icasehistoryid=row.icasehistoryid;
                console.log(this.icasehistoryid)
            },
            savexzsj()
            {
                this.dialogxzsj = true;
                this.form={};
            }

        }

    });
</script>
</body>
</html>
