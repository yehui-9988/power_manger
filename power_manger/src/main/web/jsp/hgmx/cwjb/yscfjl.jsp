<%--
  Created by IntelliJ IDEA.
  User: YeHui
  Date: 2020/5/11
  Time: 13:33
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
<style>
    .el-dialog__body {
        padding: 3px 2px;
    }

</style>
<body>
<div id="app">
    <el-upload
            action="<%=basePath%>admin/pretreatment/upload"
            list-type="picture-card"
            :auto-upload="true"
            :file-list="fileList"
            :on-preview="handlePictureCardPreview"
            :on-success="handleAvatarSuccess"
            :on-remove="handleRemove"
    >
        <i class="el-icon-plus"></i>
    </el-upload>
    <el-dialog :visible.sync="dialogVisible"
               top="5vh"
               width="70%"
    >
        <img style="padding-top: 5px;" width="100%" :src="dialogImageUrl" alt="检查报告单">
    </el-dialog>
</div>


<script>
    new Vue({
        el:"#app",
        data(){
            return {
                dialogImageUrl: '',
                dialogVisible: false,
                disabled: false,
                fileList: [],
                yscfjl:{},
                icaseid:<%=id%>

            }
        },
        created:function(){
            this.selectdata();


        },
        methods:
            {
                handleRemove(file) {
                    var self=this;
                    var data={
                        'id':file.id
                    }
                    axios.get("<%=basePath%>admin/pretreatment/deleteyscfjl", {params:data})
                        .then(function (response) {
                            if (response.data.code == 10000) {
                                self.$message({
                                    type: 'success',
                                    message: "删除成功!"
                                });

                            }

                        }).catch(function (error) {
                        console.log(error);
                    });
                },
                handlePictureCardPreview(file) {
                    this.dialogImageUrl = file.url;
                    this.dialogVisible = true;

                },
                handleDownload(file) {
                    console.log(file);
                },
                //上传医生诊疗记录
                handleAvatarSuccess(res, file) {
                    this.dialogImageUrl = URL.createObjectURL(file.raw);

                    this.yscfjl.url = res.object;
                    this.yscfjl.icaseid = this.icaseid;
                    var self = this;
                    axios.post("<%=basePath%>admin/pretreatment/uploadyscfjl", Qs.stringify(self.yscfjl))
                        .then(function (response) {
                            if (response.data.code == 10000) {
                                self.$message({
                                    type: 'success',
                                    message: "上传成功!"
                                });
                            }

                        }).catch(function (error) {
                        self.$message({
                            type: 'error',
                            message: "上传失败!"
                        });
                        console.log(error);
                    });
                },
                //初始化查询检查报告单
                selectdata(){
                    var self=this;
                    var data={
                        'icaseid':self.icaseid
                    }
                    axios.get("<%=basePath%>admin/pretreatment/selectyscfjl", {params:data})
                        .then(function (response) {
                            if (response.data.code == 10000) {
                                self.fileList=response.data.object;
                                for (var i=0;i<self.fileList.length;i++)
                                {
                                    self.fileList[i].url='<%=basePath%>'+self.fileList[i].url;
                                }
                            }

                        }).catch(function (error) {
                        console.log(error);
                    });


                }

            }





    });
</script>









</body>
</html>
