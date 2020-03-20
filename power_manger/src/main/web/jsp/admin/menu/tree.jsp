<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2019/10/14
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>系统菜单</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <script src="https://cdn.bootcss.com/qs/6.5.1/qs.min.js"></script>
</head>
<body>
    <div id="app">

    <el-row :gutter="20">
    <el-col :span="8">
    <div class="grid-content bg-purple">

                <el-tree :data="data"
                :props="defaultProps"
                @node-click="handleNodeClick"
                :default-expand-all="true"

                >

                <span slot-scope="{ node, data }">
                    <span>
                    <i :class="data.menuIco"></i>{{ node.label }}
                    </span>
                </span>
                </el-tree>
    </div></el-col>
    <el-col :span="12">
    <div class="grid-content bg-purple">

                <el-form ref="menu" :model="menu" label-width="120px">
                <el-form-item label="菜单名称" prop="menuTitle">
                <el-input v-model="menu.menuTitle"></el-input>
                </el-form-item>

                 <el-form-item label="菜单链接" prop="menuLink">
                    <el-input v-model="menu.menuLink"></el-input>
                 </el-form-item>

                <el-form-item label="菜单图标" prop="menuIco">
                <el-input v-model="menu.menuIco"></el-input>
                </el-form-item>

                <el-form-item label="父级菜单" prop="pmenuTitle">
                <el-input v-model="menu.pmenuTitle" :disabled="true" ></el-input>
                <input type="text"  v-model="menu.menuPid" style="display: none">
                </el-form-item>

                <el-form-item label="菜单描述" prop="menuTitle">
                <el-input v-model="menu.menuAlt"></el-input>
                </el-form-item>

                <el-form-item label="菜单排序" prop="menu_order">
                <el-input v-model="menu.menu_order"></el-input>
                </el-form-item>

                <el-form-item label="创建子菜单" prop="istop" >
                     <el-switch v-model="menu.istop" @change="istop" style="padding: 10px"></el-switch>
                </el-form-item>

                <el-form-item>
                    <el-select v-model="menu.isnew" placeholder="请选择"
                     @change="changesave">
                    <el-option
                    label="修改"
                    value="update">
                    </el-option>
                    <el-option
                    label="新增"
                    value="insert">
                    </el-option>
                    </el-select>
                </el-form-item>

                  <el-form-item>
                    <el-button type="primary" @click="submirFrom('ruleFrom')">保存</el-button>
                    <el-button type="primary" @click="deletemenu()">删除</el-button>
                  </el-form-item>
                </el-form>

    </div>
    </el-col>


    </el-row></div>


 <script>

   new Vue({
            el: '#app',
            data:function() {
               return{
                   list:[],
                data:[],
                defaultProps:{
                children: 'list',
                label: 'menuTitle'
                },
                menu:{
                    isnew:'insert'
                },
                rules:[],
                copymenu:{},
                menuid:[],
                menuids:'',
                }


            },

            created:function(){
                this.inittree();
            },
            methods:{
                    istop(value){
                       if (value)
                        {
                          this.copymenu=this.menu;
                          var Pid=this.menu.menuId;
                          var pTitle=this.menu.menuTitle;
                          console.log(pTitle)
                          this.menu={};
                          this.menu.isnew='insert'
                          this.menu.menuPid=Pid;
                          this.menu.pmenuTitle=pTitle;

                        }else {
                          this.menu=this.copymenu;
                         // var pid=this.menu.menuId;
                          this.menu.isnew='update'

                        }
                        this.menu.istop=value
                     },
                    changesave(){
                        if (this.menu.isnew=='insert')
                        {
                            var pid=this.menu.menuPid;
                            var ptitle=this.menu.pmenuTitle;
                            this.menu={};
                            this.menu.menuPid=pid;
                            this.menu.pmenuTitle=ptitle;
                            this.menu.isnew='insert'

                        }
                        else if (this.menu.isnew=='update')
                        {
                             this.menu=this.copymenu;
                             this.menu.isnew='update'

                        }

                     },
                //表单提交的  //验证未写
                    submirFrom(ruleFrom){
                        this.saveorupdate();

                     },
                    deletemenu(){
                        var self=this;


                        axios.get("<%=basePath%>admin/menu/deletemenu",{params:{'menuid':self.menuids }}
                        ) .then(function (response){
                        if (response.data.code == '10000') {
                        self.$message({
                        type: 'success',
                        message: '菜单删除成功!'});
                        self.formLabelAlign={};
                        }
                        }).catch(function (error){
                        self.$message({
                        type: 'error',
                        message: '菜单删除失败'
                        });
                        });
                        self.inittree();
                    },
                    saveorupdate(){
                    var self=this;
                    if (this.menu.list!=null)
                    {
                        delete this.menu.list
                    }
                    axios.post("<%=basePath%>admin/menu/saveorupadte",Qs.stringify(self.menu)

                    ) .then(function (response){

                            self.data=response.data.object;
                            console.log("response"+response.data)
                            self.inittree();
                            self.$message({
                            type: 'success',
                            message: '保存成功',
                            duration:1000
                            });

                     }).catch(function (error) {
                            self.$message({
                            type: 'error',
                            message: '网络异常'
                            });

                    });
                    },
                    inittree:function()
                    {
                    var self=this;
                    axios.get("<%=basePath%>admin/menu/list",

                    ).then(function (response) {
                    self.data=response.data.object;
                    console.log("response"+response.data)
                    }).catch(function (error) {
                    self.$message({
                    type: 'error',
                    message: '网络异常'
                    });

                    });

                    },
                    handleNodeClick(data,node) {
                    this.menu=data;
                    this.copymenu=data;
                    this.menu.isnew='修改';
                    this.menuid=[];
                    console.log(data);
                    console.log(node);
                    var menuarry=data.list;
                    if (this.menu.menuPid==0)
                    {
                    this.menu.pmenuTitle="顶级目录"
                    }else
                    {
                    this.menu.pmenuTitle=node.parent.label;
                    }
                    if (menuarry.length==0){
                        this.menuid[0]=this.menu.menuId;
                    }else{
                        for(var i=0;i<menuarry.length;i++)
                        {
                            console.log("+++++"+menuarry[0].menuId);
                            this.menuid.push(menuarry[i].menuId);

                        }
                          this.menuid.push(this.menu.menuId);
                    }
                    this.menuids=this.menuid.join(',')
                    console.log("------"+this.menuids);

                    }

            }
    });
</script>
</body>
</html>
