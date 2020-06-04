

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
    <script src="https://cdn.bootcss.com/qs/6.5.1/qs.min.js"></script>
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
    <template>
        <el-row>
            <el-col :span="10">
            </el-col>
            <el-col :span="4">
                <el-tag type="warning" style="text-align: center;">胃脘疼痛</el-tag>
            </el-col>
            <el-col :span="10">
            </el-col>
        </el-row>
        <el-row style="margin-top: 15px">

            <el-col :span="24">

                <span>时间：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.wytime" size="mini" border
                @change="changer">
                    <el-radio label="a1" >餐前&emsp;&emsp;</el-radio>
                    <el-radio label="a2">餐后&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="a3">餐前餐后均有</el-radio>
                    <el-radio label="a4">其他</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>持续：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.wycx" size="mini">
                    <el-radio label="b1">半小时内</el-radio>
                    <el-radio label="b2">半小时-1小时</el-radio>
                    <el-radio label="b3">一小时以上&emsp;</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>程度：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.wycd" size="mini">
                    <el-radio label="c1">无&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c2">轻微&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c3">中等&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c4">严重</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">

                <span>单日频率：</span>
                <el-radio-group v-model="pqxzzz.wydp" size="mini">
                    <el-radio label="d1">无&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d2">偶尔&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d3">有时&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d4">大部分时间</el-radio>
                    <el-radio label="d5">整日不断</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>单周频率：</span>
                <el-radio-group v-model="pqxzzz.wyzp" size="mini">
                    <el-radio label="0">从未有过</el-radio>
                    <el-radio label="0.5">1周&#60;1天&emsp;&emsp;</el-radio>
                    <el-radio label="1">1周1天&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="2.5">1周2-3天&emsp;</el-radio>
                    <el-radio label="4.5">1周4-5天</el-radio>
                    <el-radio label="7">几乎每天</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>
    </template>
    </el-card>
    <el-card class="box-card">
    <template>
        <el-row>


                <el-col :span="10">
                </el-col>
                <el-col :span="4">
                    <el-tag type="warning" style>胃脘胀满</el-tag>
                </el-col>
                <el-col :span="10">
                </el-col>
        </el-row>
        <el-row style="margin-top: 15px">

            <el-col :span="24">
                <span>时间：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.wztime" size="mini">
                <el-radio label="a1" >餐前&emsp;&emsp;</el-radio>
                <el-radio label="a2">餐后&emsp;&emsp;&emsp;&emsp;</el-radio>
                <el-radio label="a3">餐前餐后均有</el-radio>
                <el-radio label="a4">其他</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>持续：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.wzcx " size="mini">
                    <el-radio label="b1">半小时内</el-radio>
                    <el-radio label="b2">半小时-1小时</el-radio>
                    <el-radio label="b3">一小时以上&emsp;</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>程度：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.wzcd" size="mini">
                    <el-radio label="c1">无&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c2">轻微&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c3">中等&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c4">严重</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">

                <span>单日频率：</span>
                <el-radio-group v-model="pqxzzz.wzdp" size="mini">
                    <el-radio label="d1">无&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d2">偶尔&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d3">有时&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d4">大部分时间</el-radio>
                    <el-radio label="d5">整日不断</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>单周频率：</span>
                <el-radio-group v-model="pqxzzz.wzzp" size="mini">
                    <el-radio label="0">从未有过</el-radio>
                    <el-radio label="0.5">1周&#60;1天&emsp;&emsp;</el-radio>
                    <el-radio label="1">1周1天&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="2.5">1周2-3天&emsp;</el-radio>
                    <el-radio label="4.5">1周4-5天</el-radio>
                    <el-radio label="7">几乎每天</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>
    </template>
    </el-card>

    <el-card class="box-card">
    <template>
        <el-row>


            <el-col :span="10">
            </el-col>
            <el-col :span="4">
                <el-tag  size="medium" type="warning" style>腹部胀痛</el-tag>
            </el-col>
            <el-col :span="10">
            </el-col>
        </el-row>
        <el-row style="margin-top: 15px">

            <el-col :span="24">

                <span>时间：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.fztime" size="mini" border>
                    <el-radio label="a1" >餐前&emsp;&emsp;</el-radio>
                    <el-radio label="a2">餐后&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="a3">餐前餐后均有</el-radio>
                    <el-radio label="a4">其他</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>持续：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.fzcx" size="mini">
                    <el-radio label="b1">半小时内</el-radio>
                    <el-radio label="b2">半小时-1小时</el-radio>
                    <el-radio label="b3">一小时以上&emsp;</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>程度：&emsp;&emsp;</span>
                <el-radio-group v-model="pqxzzz.fzcd" size="mini">
                    <el-radio label="c1">无&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c2">轻微&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c3">中等&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="c4">严重</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">

                <span>单日频率：</span>
                <el-radio-group v-model="pqxzzz.fzdp" size="mini">
                    <el-radio label="d1">无&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d2">偶尔&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d3">有时&emsp;&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="d4">大部分时间</el-radio>
                    <el-radio label="d5">整日不断</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>

        <el-row style="margin-top: 15px">
            <el-col :span="24">
                <span>单周频率：</span>
                <el-radio-group v-model="pqxzzz.fzzp" size="mini">
                    <el-radio label="0">从未有过</el-radio>
                    <el-radio label="0.5">1周&#60;1天&emsp;&emsp;</el-radio>
                    <el-radio label="1">1周1天&emsp;&emsp;&emsp;</el-radio>
                    <el-radio label="2.5">1周2-3天&emsp;</el-radio>
                    <el-radio label="4.5">1周4-5天</el-radio>
                    <el-radio label="7">几乎每天</el-radio>
                </el-radio-group>
            </el-col>
        </el-row>
    </template>
    </el-card>
    <!--  --!-->
    <el-card class="box-card">
        <template>
            <el-row>


                <el-col :span="10">
                </el-col>
                <el-col :span="4">
                    <el-tag  size="medium" type="warning" style>恶心呕吐</el-tag>
                </el-col>
                <el-col :span="10">
                </el-col>
            </el-row>
            <el-row style="margin-top: 15px">

                <el-col :span="24">

                    <span>时间：&emsp;&emsp;</span>
                    <el-radio-group v-model="pqxzzz.extime" size="mini" border>
                        <el-radio label="a1" >餐前&emsp;&emsp;</el-radio>
                        <el-radio label="a2">餐后&emsp;&emsp;&emsp;&emsp;</el-radio>
                        <el-radio label="a3">餐前餐后均有</el-radio>
                        <el-radio label="a4">其他</el-radio>
                    </el-radio-group>
                </el-col>
            </el-row>

            <el-row style="margin-top: 15px">
                <el-col :span="24">
                    <span>持续：&emsp;&emsp;</span>
                    <el-radio-group v-model="pqxzzz.excx" size="mini">
                        <el-radio label="b1">半小时内</el-radio>
                        <el-radio label="b2">半小时-1小时</el-radio>
                        <el-radio label="b3">一小时以上&emsp;</el-radio>
                    </el-radio-group>
                </el-col>
            </el-row>

            <el-row style="margin-top: 15px">
                <el-col :span="24">
                    <span>程度：&emsp;&emsp;</span>
                    <el-radio-group v-model="pqxzzz.excd" size="mini">
                        <el-radio label="c1">无&emsp;&emsp;&emsp;</el-radio>
                        <el-radio label="c2">轻微&emsp;&emsp;&emsp;&emsp;</el-radio>
                        <el-radio label="c3">中等&emsp;&emsp;&emsp;&emsp;</el-radio>
                        <el-radio label="c4">严重</el-radio>
                    </el-radio-group>
                </el-col>
            </el-row>

            <el-row style="margin-top: 15px">
                <el-col :span="24">

                    <span>单日频率：</span>
                    <el-radio-group v-model="pqxzzz.exdp" size="mini">
                        <el-radio label="d1">无&emsp;&emsp;&emsp;</el-radio>
                        <el-radio label="d2">偶尔&emsp;&emsp;&emsp;&emsp;</el-radio>
                        <el-radio label="d3">有时&emsp;&emsp;&emsp;&emsp;</el-radio>
                        <el-radio label="d4">大部分时间</el-radio>
                        <el-radio label="d5">整日不断</el-radio>
                    </el-radio-group>
                </el-col>
            </el-row>

            <el-row style="margin-top: 15px">
                <el-col :span="24">
                    <span>单周频率：</span>
                    <el-radio-group v-model="pqxzzz.exzp" size="mini">
                        <el-radio label="0">从未有过</el-radio>
                        <el-radio label="0.5">1周&#60;1天&emsp;&emsp;</el-radio>
                        <el-radio label="1">1周1天&emsp;&emsp;&emsp;</el-radio>
                        <el-radio label="2.5">1周2-3天&emsp;</el-radio>
                        <el-radio label="4.5">1周4-5天</el-radio>
                        <el-radio label="7">几乎每天</el-radio>
                    </el-radio-group>
                </el-col>
            </el-row>
        </template>
    </el-card>

    <el-row style="margin: 20px 350px; ">
        <el-button type="success" @click="submit()" plain>确认保存</el-button>
        <el-button type="danger" @click="resetdata()" plain>重置数据</el-button>
    </el-row>

</div>

<script>
    <% String id=request.getParameter("id");%>
    new Vue({
        el: '#app',
        data() {
            return {
                array:[],
                icaseid:<%=id%>,
                pqxzzz:{icaseid:<%=id%>,
                    wytime:'',
                    wycx:'',
                    wycd:'',
                    wydp:'',
                    wyzp:'',
                    wztime:'',
                    wzcx:'',
                    wzcd:'',
                    wzdp:'',
                    wzzp:'',
                    fztime:'',
                    fzcx:'',
                    fzcd:'',
                    fzdp:'',
                    fzzp:'',
                    extime:'',
                    excx:'',
                    excd:'',
                    exdp:'',
                    exzp:'',
                    vctype:'1'
                },
                temp:[],
            };
        },
        created :function(){
            this.getdata();
        },
        methods:{
            changer(e)
            {

                console.log(e)
                this.temp.push(e);
                console.log(this.temp);

            },
            submit() {
                var self=this;
                axios.post("<%=basePath%>admin/pqxzzz/savepqxzzz",
                    Qs.stringify(self.pqxzzz)
                ).then(function (response) {
                    if (response.data.code == '10000') {
                        self.$message({
                            type: 'success',
                            message: '保存成功!'
                        });
                        self.getdata();
                    }
                }).catch(function (error) {
                    self.$message({
                        type: 'error',
                        message: '保存失败!'
                    });
                });

       },
            getdata(){
                var self=this;
                var data={
                    icaseid:self.icaseid,
                    vctype:'1'
                }
                axios.get("<%=basePath%>admin/pqxzzz/selectpqxzzz",{params:data}
                ).then(function (response) {
                    if(response.data.object!=null)
                    {
                        self.pqxzzz=response.data.object;
                    }
                }).catch(function (error) {
                    self.$message({
                        type: 'error',
                        message: '网络错误!'
                    });
                });
            },
            resetdata(){
                var temp=this.pqxzzz;
                this.pqxzzz={};
                this.pqxzzz.id=temp.id;
                this.pqxzzz.icaseid=temp.icaseid;
                this.pqxzzz.vctype=temp.vctype;
            }
        }


    });

</script>
</body>
</html>

