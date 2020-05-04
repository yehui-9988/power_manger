<%--
  Created by IntelliJ IDEA.
  User: YEHUI
  Date: 2020/2/29
  Time: 1:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <title>肠胃疾病tab</title>
    <link href="<%=basePath%>static/icon/iconfont.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
</head>
<body>


    <div id="app">

        <template>
            <el-tabs v-model="editableTabsValue" type="card"
            >
                <el-tab-pane
                        v-for="(item, index) in editableTabs"
                        :key="item.name"
                        :label="item.title"
                        :name="item.name"
                >
                    <iframe :src="item.src" width="100%" height="100%"  frameborder="0"> </iframe>
                </el-tab-pane>
            </el-tabs>
        </template>

    </div>

    <script>

        new Vue({
            el: '#app',
            data() {
                return {
                    editableTabsValue: '2',
                    editableTabs: [{
                        title: '核对数据',
                        name: '1',
                        src:''
                    }, {
                        title: '病史和生命体征',
                        name: '2',
                        src:'<%=basePath%>jsp/hgmx/cwjb/hdsj.jsp'
                    },{
                        title: '研究前用药',
                        name: '3',
                        src:'<%=basePath%>jsp/hgmx/cwjb/yjqyy.jsp'

                    },{
                        title: '临床诊断',
                        name: '4',

                    },{
                        title: '脾气虚症状',
                        name: '5',

                    },{
                        title: '检查单报告',
                        name: '6',

                    },{
                        title: '医生处方记录',
                        name: '7',

                    },





                    ],
                }
            },
            methods: {
                onSubmit() {
                    console.log('submit!');
                },
                handleClick(tab, event) {


                },

            }


        });


    </script>



</body>
</html>
