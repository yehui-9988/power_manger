<%--
  Created by IntelliJ IDEA.
  User: YeHui
  Date: 2020/5/30
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8"><link rel="icon" href="https://jscdn.com.cn/highcharts/images/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        /* css 代码  */
    </style>
    <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="http://cdn.highcharts.com.cn/highcharts/highcharts.js"></script>
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>

</head>
<body>
<div id="container" style="max-width:800px;height:400px;margin-top: 10px"></div>
<div id="app">

    <el-row style="margin-top: 10px">

        <el-col :span="3" :offset="4"> <el-input v-model="icaseid" placeholder="请输入病案号"></el-input></el-col>
        <el-col :span="2" :offset="1"> <el-button type="primary" @click="drawmap()">数据生成</el-button> </el-col>

    </el-row>

</div>



<script>
    new Vue({
        el: '#app',
        data() {
            return {
                icaseid:'',
                temparr:[],
                temparr1:[],
                charstest:{
                    chart: {
                        type: 'line'
                    },
                    title: {
                        text: '脾气虚证症状单周变化'
                    },
                    xAxis: {
                        categories: ['胃脘疼痛', '胃脘胀满', '腹部胀痛', '恶心呕吐']
                    },
                    yAxis: {
                        title: {
                            text: '单周疼痛频率/天'
                        }
                    },
                    plotOptions: {
                        line: {
                            dataLabels: {
                                // 开启数据标签
                                enabled: true
                            },
                            // 关闭鼠标跟踪，对应的提示框、点击事件会失效
                            enableMouseTracking: false
                        }
                    },
                    series:[{
                        name: '基线数据',
                        data: []
                    }, {
                        name: '随访数据',
                        data: []
                    }]
                },


            };
        },
        created:function(){
            this.getdata();
        },
        methods:{
            drawmap()
            {
                var self=this;
                var data={
                    icaseid:self.icaseid,
                }
                axios.get("<%=basePath%>admin/pqxzzz/drawpic",{params:data}
                ).then(function (response) {
                    if(response.data.object!=null)
                    {
                        console.log(self.charstest.series)
                        self.charstest.series=[{name:'',data:[]},{name:'',data:[] }];
                        self.temparr=[];
                        self.temparr1=[];
                        self.temparr.push(parseFloat(response.data.object[0].wyzp),
                            parseFloat(response.data.object[0].wzzp),
                            parseFloat(response.data.object[0].fzzp),
                            parseFloat(response.data.object[0].exzp));
                        self.temparr1.push(parseFloat(response.data.object[1].wyzp),
                            parseFloat(response.data.object[1].wzzp),
                            parseFloat(response.data.object[1].fzzp),
                            parseFloat(response.data.object[1].exzp));
                        if ( response.data.object[0].vctype=='0')
                        {
                            self.charstest.series[0].data=self.temparr;
                            self.charstest.series[0].name='基线数据';
                            self.charstest.series[1].name='随访数据';
                        }else {
                            self.charstest.series[0].data=self.temparr;
                            self.charstest.series[0].name='随访数据';
                            self.charstest.series[1].name='基线数据';
                        }
                        self.charstest.series[1].data=self.temparr1;

                       // var chart = Highcharts.chart('container',self.charstest);
                        var chart = Highcharts.chart('container',self.charstest);
                    }
                }).catch(function (error) {

                    self.$message({
                        type: 'error',
                        message: '病案号-'+self.icaseid+'-无效，无法生成对比图'
                    });

                });


            },
            getdata(){
                var chart = Highcharts.chart('container',this.charstest);

            }
        }


    });
</script>
</body>
</html>
