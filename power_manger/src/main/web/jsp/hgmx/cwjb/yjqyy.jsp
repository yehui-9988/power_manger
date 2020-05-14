<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2020/4/21
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body><%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2020/3/4
  Time: 17:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% String id=request.getParameter("id");%>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <title>研究前用药</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <!-- import JavaScript -->
    <script src="https://cdn.bootcss.com/qs/6.5.1/qs.min.js"></script>
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
</head>
<body>

<style>
    .el-table-add-row {
        margin-top: 10px;
        width: 100%;
        height: 24px;
        border: 1px dashed #c1c1cd;
        border-radius: 3px;
        cursor: pointer;
        justify-content: center;
        display: flex;
        line-height: 24px;
    }

</style>
<div id="app">
    <el-row style="margin-top: 2px">
        <el-col :span="3">
            <el-button type="success"  round size="small" @click="addMasterUser()" style="margin-bottom:3px;margin-top: 3px">添加数据</el-button>
        </el-col>
    </el-row>
    <el-row>

        <el-col :span="24">

            <el-table size="mini" :data="master_user.data" empty-text="暂无研究前用药" border style="width: 100%;"highlight-current-row>
                <el-table-column type="index" label="序号"></el-table-column>

                <el-table-column v-for="(v,i) in master_user.columns" :prop="v.field" :label="v.title" style="width:40%">
                    <template slot-scope="scope">
                            <span v-if="scope.row.isSet">
                                <el-input size="mini" placeholder="请输入内容" v-model="master_user.sel[v.field]">
                                </el-input>
                            </span>
                        <span v-else>{{scope.row[v.field]}}</span>

                    </template>
                </el-table-column>
                <el-table-column label="操作" style="width:20%">
                    <template slot-scope="scope">
                            <span class="el-tag el-tag--info el-tag--mini" style="cursor: pointer;" @click="savedata(scope.row,scope.$index,false)">
                               保存
                            </span>
                            <span class="el-tag el-tag--danger el-tag--mini" style="cursor: pointer;" @click="deleterow(scope.row,scope.$index,true)">
                                删除
                            </span>

                    </template>
                </el-table-column>
            </el-table>
        </el-col>

    </el-row>


</div>



<script>
    var generateId = {
        _count: 1,
        get(){return ((+new Date()) + "_" + (this._count++))}
    };
    new Vue({
        el: '#app',
        data(){
            return{
                paramid:<%=id%>,
                master_user: {
                    sel:[],
                    columns: [
                        { field: "vcdrugname", title: "商品名或通用民", width: "100px"},
                        { field: 'vczjl', title: "每日总剂量", width:"100px"  },
                        { field: 'vcgycj', title: "给药途径", width:"100px"  },
                        { field: 'begintime', title: "开始时间", width:"100px"  },
                        { field: 'endtime', title: "结束时间", width:"100px"  },
                        { field: 'vccontent', title: "主诉内容", width:"200px"  },
                    ],
                    data:[],
                },
                pasthistory:{}

            }
        },
        created:function(){
            this.readMasterUser();
            this.clearall();
        },
        methods: {
            loadtabeldata(){
                {
                    var self=this;
                    var data={
                        'id':this.paramid
                    }
                    axios.get("<%=basePath%>admin/pretreatment/select",{
                        params: data
                    }).then(function (response) {
                        self.master_user.data=response.data.object
                        console.log("研究前药"+self.master_user.data);
                    }).catch(function (error) {
                        console.log(error);
                    });
                }

            },
            //读取表格数据
            readMasterUser() {
                this.loadtabeldata();
                this.master_user.data.map(i => {
                    i.isSet=false;//给后台返回数据添加`isSet`标识
                    return i;
                });
            },
            //添加账号
            addMasterUser() {
                let j = { id: 0, vcdrugname: "",vczjl:" ",icaseid:<%=id%>,vctype:3, vcgycj: "", dtbegin:" " ,dtend:"",vccontent:"",isSet: true};
                this.master_user.data.push(j);
                this.master_user.sel = j
            },
            //保存
            savedata(row,index,cg)
            {
                if (row.isSet&&!cg)
                {
                    var  self=this;
                    var  data =this.master_user.sel;
                    for (let k in data)
                        row[k] = data[k];
                    self.pasthistory=row;

                    axios.post("<%=basePath%>admin/pretreatment/save",Qs.stringify(self.pasthistory))
                        .then(function (response) {
                            if (response.data.code==10000)
                            {
                                self.$message({
                                    type: 'success',
                                    message: "保存成功!"
                                });
                                row.isSet=false;

                                self.loadtabeldata();
                                console.log("数据"+self.master_user.data)
                            }

                            //然后这边重新读取表格数据


                        }).catch(function (error) {
                        console.log(error);
                    });



                }else {
                    this.$message('此记录已经被保存,请不要重复操作');
                }

            },
            //删除
            deleterow(row,index)
            {

                var data={
                    'preid':row.preid
                }
                if (row.preid==null)
                {
                    this.master_user.data.splice(index, 1)
                    return false;
                }
                var self=this;
                axios.get("<%=basePath%>admin/pretreatment/delete",{params:data})
                    .then(function (response) {
                        if (response.data.code==10000)
                        {
                            self.$message({
                                type: 'success',
                                message: "删除成功!"
                            });

                        }else
                        {

                        }
                        self.loadtabeldata();
                    })

            },
            //清除表格
            clearall()
            {
                if (this.paramid==0)
                {

                    this.master_user.data=[];
                }

            }


        }
    });
</script>
</body>
</html>
