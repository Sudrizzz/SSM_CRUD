<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<!-- 路径采用以 / 开始的相对路径 ，找资源是是以服务器的根路径-->
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>

<title>员工列表</title>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 两个按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<br />
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M" ? "男" : "女"}</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-info btn-sm">
									<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<div class="col-md-6">
				当前第${pageInfo.pageNum }页，共${pageInfo.pages }页，共${pageInfo.total }条记录
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
				  	
				  	<c:forEach items="${pageInfo.navigatepageNums }" var="pageNum">
				  		<c:if test="${pageNum == pageInfo.pageNum }">
				  			<li class="active"><a href="#">${pageNum }</a></li>
				  		</c:if>
				  		<c:if test="${pageNum != pageInfo.pageNum }">
				  			<li><a href="${APP_PATH }/emps?pn=${pageNum }">${pageNum }</a></li>
				  		</c:if>
				  	</c:forEach>
				  	
				    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages }">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
	
	
</body>
</html>