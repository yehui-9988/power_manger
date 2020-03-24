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
    <style>

    </style>
</head>
<body >
<div id="app">
    <!--打开编辑 核对数据的选项卡 -->
    <el-dialog title="信息核对" :visible.sync="dialogsjgl" width="80%" height="500px">
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
      <%--  ///下一步的按钮 可有可无--%>
               <%-- <el-col :span="8" >
                    <el-button type="primary"  @click="changetab">{{labelbutton}}<i class="el-icon-arrow-right el-icon--right"></i></el-button>
                </el-col>--%>
    </el-dialog>
    <div style="margin-bottom: 10px;margin-top: 10px" >
        <el-row :gutter="20">
            <el-col :span="6">
                <el-button-group>
                    <el-button type="primary" icon="el-icon-circle-plus-outline " @click="savejxsj"></el-button>
                    <el-button type="primary" icon="el-icon-delete" ></el-button>
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
            style="width:100%;">
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
                width="100"

        >
        </el-table-column>

        <el-table-column
                prop="vcname"
                label="患者姓名"
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
                prop="vcphone"
                label="电话号码"
                width="200">
        </el-table-column>
        <el-table-column
                prop="vcserialnum"
                label="患者入组编号"
                width="120">
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

                <el-button @click="selectrow(scope.row)" type="success" size="small">编辑</el-button>
                <el-button @click="" type="danger" size="small">删除</el-button>
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
                icasehistoryid:'',
                labelbutton:'下一步',
                list:[],
                editableTabsValue: '1',
                testvalue:'2',
                editableTabs: [{
                    title: '核对数据',
                    name: '1',
                    src:'<%=basePath%>jsp/hgmx/cwjb/hdsj.jsp?id='
                }, {
                    title: '病史和生命体征',
                    name: '2',
                    src:'<%=basePath%>jsp/hgmx/cwjb/smtz.jsp?id='
                },{
                    title: '研究前用药',
                    name: '3',
                    src:'<%=basePath%>jsp/hgmx/cwjb/hdsj.jsp?id='
                },{
                    title: '临床诊断',
                    name: '4',
                    src:'<%=basePath%>jsp/hgmx/cwjb/hdsj.jsp?id='
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
            //获取表格数据
            getdata: function () {

                var self = this;
                axios.get("<%=basePath%>admin/casehistory/selectall")
                    .then(function (response) {

                        if (response.data.code == '10000') {
                            self.list = response.data.object;
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
            savejxsj(){
                this.dialogsjgl=true;
                this.icasehistoryid=0;

            },
            selectrow(row)
            {
                this.dialogsjgl=true;
                this.icasehistoryid=row.icasehistoryid;
                console.log(this.icasehistoryid)
            }

        }

    });
</script>
</body>
</html>
