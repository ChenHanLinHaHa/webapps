<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增或修改公司信息</title>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<style>
	 col-md-2, span{
		display:-moz-inline-box;
		display:inline-block;
		width:80px;
	}
</style>

<script type="text/javascript">
	$(function(){
		if("${result}"){
			alert("result");
		}
	});
	function next(){
		$(#"handleType").val("edit_next");
		$("#.saveForm").submit();
	}
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-md-offset-2">
				<h4>
					编辑公司信息
				</h4>
			</div>
		</div>
		<form id="saveForm" class="form-horizontal" action="${ctx}/company/saveCompany" method="post">
			<input type="hidden" id="id" name="id" value="${company.id}">
			<input type="hidden" id="handleType" name="handleType" value="edit_save">
			<div class="form-group">
				<label class="col-md-2 control-label" for="name">公司名称：</label>
				<div class="col-md-4" >
					<input type="text" id="name" name="name" class="form-control" placeholder="请输入姓名" value="${company.name }">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 control-label" for="contactName">联系人：</label>
				<div class="col-md-4" >
					<input type="text" id="contactName" name="contactName" class="form-control" placeholder="联系人" value="${company.contactName }">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 control-label" for="telephone">联系电话：</label>
				<div class="col-md-4" >
					<input type="text" id="telephone" name="telephone" class="form-control" placeholder="请输入联系电话" value="${company.telephone }">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 control-label" for="mobile">手机号：</label>
				<div class="col-md-4" >
					<input type="mobile" id="mobile" name="mobile" class="form-control" placeholder="请输入手机号" value="${company.mobile }">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 control-label" for="email">email：</label>
				<div class="col-md-4" >
					<input type="email" id="email" name="email" class="form-control" placeholder="请输入email" value="${company.email }">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 control-label" for="enterpriseLegalPerson" >法人代表：</label>
				<div class="col-md-4" >
					<input type="text" id="enterpriseLegalPerson" name="enterpriseLegalPerson" class="form-control" placeholder="请输入法人代表" value="${company.enterpriseLegalPerson }">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 control-label" for="address">地址：</label>
				<div class="col-md-4" >
					<input type="text" id="address" name="address" class="form-control" placeholder="请输入公司地址" value="${company.address }">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 control-label" for="briefs">公司简介：</label>
				<div class="col-md-4" >
					<textarea class ="form-control" id="briefs" name="briefs" rows="5" value="${company.briefs }"></textarea>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-2 control-label" for="environment">公司环境：</label>
				<div class="col-md-4" >
					<textarea class ="form-control" id="environment" name=""environment"" rows="5" value="${company.environment }"></textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-3" >
				</div>
				<button type="submit" class="btn btn-primary">
					下一步
				</button>
				<button type="submit" class="btn btn-primary">
					保存
				</button>
			</div>
		</form>
	</div>
</body>
</html>