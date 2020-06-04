

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
<style>

    .el-tag{
        margin-left: 400px;
    }

</style>
<body>

<div id="app">
    <el-card class="box-card">
            <el-row style="margin-top: 15px">
                <el-col :span="24">
                    <span>时间：&emsp;&emsp;</span>
                    <el-radio-group  v-for="(radio,index) in array " v-model="array[index]" size="mini" border>
                        <el-radio v-for="(item,index) in radio" :label="item.value">{{item.name}}</el-radio>
                    </el-radio-group>
                </el-col>
            </el-row>
    </el-card>

    <el-row style="margin: 20px 350px; ">
        <el-button type="success" @click="test()" plain>确认保存</el-button>
        <el-button type="danger" plain>重置数据</el-button>
    </el-row>

</div>

<script>
    <% String id=request.getParameter("id");%>
    new Vue({
        el: '#app',
        data() {
            return {
                array:{
                    radio: [{name:'餐前',value:'a1'
                    },{name:'餐后',value:'a2'
                    },{name:'餐前餐后均有',value:'a3'
                    },{name:'其他',value:'a4'
                    }],
                    radio2: [{name:'餐前',value:'a1'
                    },{name:'餐后',value:'a2'
                    },{name:'餐前餐后均有',value:'a3'
                    },{name:'其他',value:'a4'
                    }],
                    radio3: [{name:'餐前',value:'a1'
                    },{name:'餐后',value:'a2'
                    },{name:'餐前餐后均有',value:'a3'
                    },{name:'其他',value:'a4'
                    }],

                },
        /*        radio: [{name:'餐前',value:'a1'
                },{name:'餐后',value:'a2'
                },{name:'餐前餐后均有',value:'a3'
                },{name:'其他',value:'a4'
                }],*/
              /*  radio2: 'B',
                radio3: 'C',
                radio4: 'D',
                radio1: 'E',*/
            };
        },
        methods:{
            changer(e)
            {
                console.log(e);

            },
            test(){
                console.log(this.radio)
            }
        }


    });

</script>
</body>
</html>

