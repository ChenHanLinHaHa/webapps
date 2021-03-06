<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>后台管理系统</title>	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${ctx}/js/common/jquery/jquery-ui-1.12.1/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/js/common/jquery/jqGrid/css/ui.jqgrid.css" type="text/css" />
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="${ctx}/js/common/jquery/jqGrid/js/grid.base.js"></script>
<script src="${ctx}/js/common/jquery/jqGrid/js/grid.common.js"></script>
<script src="${ctx}/js/common/jquery/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script src="${ctx}/js/common/jquery/jqGrid/js/jquery.jqGrid.js"></script>

<script type="text/javascript">
	var dataGrid = null;
	jQuery(document).ready(function(){
		dataGrid = jQuery("#list").jqGrid({
		    url:"${ctx}/user/loadUserList",
		    datatype: "json",
		    mtype : "POST",
		    height:650,
		    width:950,
		    jsonReader : {
								root : "resultList", // json中代表实际模型数据的入口
								page : "page.page", // json中代表当前页码的数据   
								records : "page.records", // json中代表数据行总数的数据   
								total : 'page.total', // json中代表页码总数的数据 
								repeatitems : false // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
							},
		    colNames : [ '姓名', '账号', '性别', '身份证号', '类型', '学历', '操作' ],
		    colModel : [ {
								label : 'name',
								name : 'name',
								align : 'center',
								sortable : false
							}, {
								label : 'account',
								name : 'account',
								align : 'center',
								sortable : false
							}, {
								label : 'gender',
								name : 'gender',
								align : 'center',
								sortable : false,
								formatter:function(cellValue,options,rowObject){
									if(cellValue==1){
										return '男';
									}else{
										return '女';
									}
								}
							}, {
								label : 'idCardNo',
								name : 'idCardNo',
								align : 'center',
								sortable : false
							}, {
								label : 'userType',
								name : 'userType',
								align : 'center',
								sortable : false,
								formatter:function(cellValue,options,rowObject){
									if(cellValue==1){
										return '超级管理员';
									}else if(cellValue==2){
										return '普通管理员';
									}else if(cellValue==3){
										return '个人用户';
									}else if(cellValue==4){
										return '企业用户';
									}
								}
							}, {
								label : 'educationId',
								name : 'educationId',
								align : 'center',
								sortable : false,
								formatter:function(cellValue,options,rowObject){
									if(cellValue==1){
										return '小学';
									}else if(cellValue==2){
										return '初中';
									}else if(cellValue==3){
										return '高中';
									}else if(cellValue==4){
										return '中专';
									}else if(cellValue==5){
										return '职高';
									}else if(cellValue==6){
										return '大专';
									}else if(cellValue==7){
										return '本科';
									}else if(cellValue==8){
										return '硕士';
									}else if(cellValue==9){
										return '博士';
									}else if(cellValue==10){
										return '博士后';
									}else if(!cellValue){
										return "未填写";
									}
								}
							},{
								label : 'operate',
								name : 'operate',
								align : 'center',
								sortable : false
							} ],
		    pager: '#pager',
		    rowNum:50,
		    rowList:[50,100,200],
		    sortname: 'id',
		    viewrecords: true,
		    sortorder: "desc",
		    caption: "人员列表",
		    gridComplete : function() { //在此事件中循环为每一行添加日志、废保和查看链接
								var ids = jQuery("#list").jqGrid('getDataIDs');
								for ( var i = 0; i < ids.length; i++) {
									var id = ids[i];
									var rowData = $('#list').jqGrid('getRowData', id);
									operateClick = '<a href="${ctx}/user/toUserInfoPage?type=edit&id='+id+'" style="color:blue">编辑</a> <a href="#" style="color:blue" onclick="deleteById('+ id + ')" >删除</a>';
									jQuery("#list").jqGrid('setRowData', id, {
										operate : operateClick
									});
								}
							}
		});
	});
	
	function search(){
		var params = {};
		var keyWords = $.trim($("#keyWords").val());
		var gender = $("#genderType").val();
		var educationId = $("#eductionId").val();
		if(keyWords){
			params.keyWords=keyWords;
		}
		if(gender){
			params.gender=gender;
		}
		if(educationId){
			params.educationId=educationId;
		}
		dataGrid.jqGrid("setGridParam",{
		    postData:$("#searchForm").serialize(),
		    page:1
		}).trigger("reloadGrid");
	}
	
	function save(){
		var pwd = $.trim($("#password").val());
		var confirmPwd = $.trim($("#confirmPassword").val());
		if(pwd==null||pwd==''){
			alert("请输入密码！");
			return;
		}
		if(confirmPwd==null||confirmPwd==''){
			alert("请输入确认密码");
			return;
		}
		if(pwd!=confirmPwd){
			alert("两次输入的密码不一致");
			return;
		}
		$.ajax({
			url:"${ctx}/user/saveUser",
			type:"POST",
			dataType:"JSON",
			data:$("#saveForm").serialize(),
			success:function(response){
				$('#addModal').modal('hide');
				alert("保存成功");
				dataGrid.trigger("reloadGrid");
			}
		});
	}
	
	function getById(id){
		$.ajax({
			url:"${ctx}/user/getById",
			type:"POST",
			dataType:"JSON",
			data:{
				"id":id
			},
			success:function(response){
				if(response.result=='success'){
					setValueForUpdate(response.data);
					$('#updateModal').modal('show');
				}else{
					alert('加载用户信息失败');
					return ;
				}
			}
		});
	}
	
	function setValueForUpdate(userInfo){
		if(userInfo){
			$("#name").val(userInfo.name);
			$("#age").val(userInfo.age);
			$("#idCardNo").val(userInfo.idCardNo);
			$("#mobile").val(userInfo.mobile);
			if(userInfo.gender){
				if(userInfo.gender==0){
					$("#select_id option[value='0']").attr("selected", true);
				}else{
					$("#select_id option[value='1']").attr("selected", true);
				}
			}
			$("#email").val(userInfo.email);
			$("#address").val(userInfo.address);
			$("#homeAddress").val(userInfo.homeAddress);
			$("#id").val(userInfo.id);
		}
	}
	
	function update(){
		$.ajax({
			url:"${ctx}/user/updateUser",
			type:"POST",
			dataType:"JSON",
			data:$("#updateForm").serialize(),
			success:function(response){
				$('#updateModal').modal('hide');
				alert("保存成功");
				dataGrid.trigger("reloadGrid");
			}
		});
	}
		
	function deleteById(id){
		$.ajax({
			url:"${ctx}/user/deleteById",
			type:"POST",
			dataType:"JSON",
			data:{
				"id":id
			},
			success:function(response){
				alert("删除成功");
				dataGrid.trigger("reloadGrid");
			}
		});
	}
	
</script>
<style>
	.input-group-sm {
		margin-bottom: 10px;
	}
	.input-group-sm label{
		width:100%;
	}
	.input-group-sm label span{
		width:30%;
		text-align:right;
		display:inline-block;
	}
	.input-group-sm label input{
		width:50%;
		display:inline-block;
	}
</style>
</head>
<body>
	<div class="container-fluid">
		<form id="searchForm">
			<div class="row" style="margin-bottom:5px">
				<div class="col-md-3">
					<label>
						<span>姓名/账号/身份证:</span>
						<input type="text" id="keyWords" name="keyWords" >
					</label>
				</div>
				<div class="col-md-2">
					<label>
						<span>学历:</span>
						<select id="eductionId" name="educationId">
							<option value="" selected>-请选择-</option>
							<option value="1">小学</option>
							<option value="2">初中</option>
							<option value="3">高中</option>
							<option value="4">中专</option>
							<option value="5">职高</option>
							<option value="6">大专</option>
							<option value="7">本科</option>
							<option value="8">硕士</option>
							<option value="9">博士</option>
							<option value="10">博士后</option>
						</select>
					</label>
				</div>
				<div class="col-md-2">
					<label>
						<span>性别:</span>
						<select id="genderType" name="gender">
							<option value="" selected>-请选择-</option>
							<option value="1">男</option>
							<option value="0">女</option>
						</select>
					</label>
				</div>
				<div class="col-md-2">
					<button type='button' class="btn btn-primary btn-sm" data-toggle="modal" onclick="search()">
							查询
					</button>
				</div>
			</div>
			<div class="row" style="margin-bottom:5px">
				<div class="col-md-3">
				</div>
				<div class="col-md-2">
				</div>
				<div class="col-md-2">
				</div>
				<div class="col-md-2">
					<a type='button' class="btn btn-primary btn-sm" href="${ctx}/user/toUserInfoPage?type=add">
						添加新用户
					</a>
				</div>
			</div>
		</form>
		<div class="row">
			<div class="col-md-9">
				<table id="list"></table>
				<div id="pager"></div>
			</div>
		</div>
	</div>
</body>
</html>