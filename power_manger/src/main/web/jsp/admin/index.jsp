<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2019/10/8
  Time: 19:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>首页</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">


    <style>
        .el-tabs__header{

            height: 25px;

        }

        .el-header {
            background-color:#20222A;
                /*    #545c64;*/
            color: #fbfbfb;
            line-height: 50px;



        }

        .el-aside {
            background-color:#20222A ;



        }
        .el-main{
            padding: 10px;
            background-color:#eaedf1;

        }
        .el-menu{
            background-color: #20222A;

        }
        .jxutcm{


        }
        iframe{
            width: 100%;
            height: 100%;
            border: 0px;
            outline: none;
            overflow: scroll;
        }
    </style>
</head>


<body>
<div id="app">


<el-container style="height: 100%">
    <el-header style="text-align: right; font-size: 12px;height: 50px">
        <el-row>
            <el-col :span=1>
                    <img style="width:40px;height:40px;padding-top:5px;margin-right:80px" src='<%=basePath%>static/imgs/jxutcm.jpg'>
            </el-col>
            <el-col :span="6" style="text-align: left;">
                <span id="jxutcm" style="font-size: 25px; font-family:楷体;text-align: left;margin-left: 1px">江西中医大学</span>
            </el-col>
            <el-col :span="16">
                <span style="font-size: 18px;font-family:楷体">${sessionScope.manager.rolestr}/</span>
                <span style="font-size: 18px;font-family:楷体">${sessionScope.manager.managerName}</span>
            </el-col>
            <el-col :span="1" style="margin-top: 17px;" >
                <el-dropdown style="color: #fbfbfb;font-size: 18px;margin-right: 10px">
                    <i class="el-icon-setting" style="margin-right: 10px"></i>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item @click.native="addTab(modifypasswrodtitle,modifypasswrodname,modifypasswrodlink)">修改密码</el-dropdown-item>
                        <el-dropdown-item @click.native="loginexit()"><el-link :underline="false" href="<%=basePath%>util/login">注销账号</el-link></el-dropdown-item>

                    </el-dropdown-menu>
                </el-dropdown>

            </el-col>
        </el-row>





    </el-header>



    <el-container>

        <el-aside width="200px" >
            <el-menu default-active="2"
                     active-text-color="#40AFFE"
                     background-color="#20222A"
                     text-color="#fff"
                     >
                <el-submenu v-for="(item,index) in menus" :index="index+''" :key="item.menuId">
                    <template slot="title" >
                        <i :class="item.menuIco"></i><span style="font-size: 14px;font-family: 'Arial Black';color: #fbfbfb" >{{item.menuTitle}}</span>
                    </template>

                    <el-menu-item  v-for="(m,i) in item.list" :key="m.menuId" :index="index+'-'+i"  @click="addTab(m.menuTitle,m.menuTitle,m.menuLink)"
                    >
                        <template slot="title">
                            <i :class="m.menuIco" ></i><span style="font-size: 14px;font-family: 'Arial Black';color: #fbfbfb"  >{{m.menuTitle}}</span>
                        </template>
                    </el-menu-item>


                </el-submenu>
            </el-menu>
        </el-aside>

        <el-main style="margin-top:0px;" >
            <%--<div style="margin-bottom: 20px;">--%>
                <%--<el-button--%>
                        <%--size="small"--%>
                        <%--@click="addTab(editableTabsValue)"--%>
                <%-->--%>
                    <%--<label  style="font-size: 15px"> add </label>--%>
                <%--</el-button>--%>
            <%--</div>--%>
            <el-tabs v-model="editableTabsValue" type="card" closable @tab-remove="removeTab">
                <el-tab-pane
                        v-for="(item, index) in editableTabs"
                        :key="item.name"
                        :label="item.title"
                        :name="item.name"


                >
                    <iframe :src="item.src" scrolling="no" style="height: 700px"> </iframe>
                </el-tab-pane>
            </el-tabs>
        </el-main>
    </el-container>
</el-container>

</div>



<script src="https://unpkg.com/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://cdn.bootcss.com/qs/6.5.1/qs.min.js"></script>

<script>
    new Vue({
        el: '#app',
        data: function () {
            return {
                editableTabsValue: '1',
                editableTabs: [{
                    title: '欢迎',
                    name: '1',
                    src: '<%=basePath%>init'
                }],
                tabIndex: 2,
                menus:[],
                manager:{},
                modifypasswrodtitle:'修改密码',
                modifypasswrodname:'修改密码',
                modifypasswrodlink:'<%=basePath%>jsp/admin/manager/modifypassword.jsp',
            }
        },
        created:function(){
            this.loadmenu();
        },
        methods: {
            loginexit()
            {
                <%--${sessionScope.manager};--%>
                console.log("已经触发了loginexit");
                axios.get("<%=basePath%>util/login/exit"
                ) .then(function (response){
                    if(response.code='10000')
                    {
                        // location.href="http://localhost:8080/util/login";

                    }

                }).catch(function (error){

                });

            },
            loadmenu()
            {
                  var self=this;
                axios.get("<%=basePath%>admin/menu/manager"

                ) .then(function (response){
                        self.menus=response.data.object;
                        console.log(self.menus)

                }).catch(function (error){
                    self.$message({
                        type: 'error',
                        message: '网络异常'
                    });
                });
            },
            addTab(title,name,src){
                var hased=false;

                for(var i=0;i<this.editableTabs.length;i++)
                {
                    if (this.editableTabs[i].name==name)
                    {
                         hased=true;
                         break;
                    }
                }
                if (!hased) {

                    this.editableTabs.push({
                        title: title,
                        name: name,
                        src: src
                    });
                }
                this.editableTabsValue = name;
            },
            removeTab(targetName) {
                let tabs = this.editableTabs;
                let activeName = this.editableTabsValue;
                if (activeName === targetName) {
                    tabs.forEach((tab, index) => {
                        if (tab.name === targetName) {
                            let nextTab = tabs[index + 1] || tabs[index - 1];
                            if (nextTab) {
                                activeName = nextTab.name;
                            }
                        }
                    });
                }
                this.editableTabsValue = activeName;
                this.editableTabs = tabs.filter(tab => tab.name !== targetName);
            }
        }


    });
</script>


</body>
</html>
