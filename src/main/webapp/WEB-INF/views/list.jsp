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

<!-- ·�������� / ��ʼ�����·�� ������Դ�����Է������ĸ�·��-->
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>

<title>Ա���б�</title>
</head>
<body>
	<!-- ���ʾҳ�� -->
	<div class="container">
		<!-- ���� -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- ������ť -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">����</button>
				<button class="btn btn-danger">ɾ��</button>
			</div>
		</div>
		<br />
		<!-- ��� -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>����</th>
						<th>�Ա�</th>
						<th>����</th>
						<th>����</th>
						<th>����</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M" ? "��" : "Ů"}</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-info btn-sm">
									<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
									�༭
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									ɾ��
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- ��ҳ��Ϣ -->
		<div class="row">
			<div class="col-md-6">
				��ǰ��${pageInfo.pageNum }ҳ����${pageInfo.pages }ҳ����${pageInfo.total }����¼
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH }/emps?pn=1">��ҳ</a></li>
				  	
				  	<c:forEach items="${pageInfo.navigatepageNums }" var="pageNum">
				  		<c:if test="${pageNum == pageInfo.pageNum }">
				  			<li class="active"><a href="#">${pageNum }</a></li>
				  		</c:if>
				  		<c:if test="${pageNum != pageInfo.pageNum }">
				  			<li><a href="${APP_PATH }/emps?pn=${pageNum }">${pageNum }</a></li>
				  		</c:if>
				  	</c:forEach>
				  	
				    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages }">ĩҳ</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
	
	
</body>
</html>