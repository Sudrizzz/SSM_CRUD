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
<script src="${APP_PATH}/static/js/jquery.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<title>员工列表</title>
</head>
<body>


	<!-- 更新员工的模态框 -->
	<div class="modal fade" id="empUpdate" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">更新员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="emp_update_email" name="email">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label> 
							<div class="col-sm-10">
								<label class="radio-inline"> 
									<input type="radio"
									name="gender" id="emp_gender_M" value="M" checked="checked"> 男
								</label> 
								<label class="radio-inline"> 
									<input type="radio"
									name="gender" id="emp_gender_F" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label> 
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>



	<!-- 添加员工的模态框 -->
	<div class="modal fade" id="empAdd" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="emp_Name" name="empName"
									placeholder="张三">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="emp_email" name="email"
									placeholder="email@google.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label> 
							<div class="col-sm-10">
								<label class="radio-inline"> 
									<input type="radio"
									name="gender" id="emp_gender_M" value="M" checked="checked"> 男
								</label> 
								<label class="radio-inline"> 
									<input type="radio"
									name="gender" id="emp_gender_F" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label> 
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add">
								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

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
				<button class="btn btn-primary" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_btn">删除</button>
			</div>
		</div>
		<br />
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="emps_table"></tbody>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<!-- 分页文本信息 -->
			<div class="col-md-6" id="page_info"></div>
			<!-- 分页导航栏 -->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>


	<script type="text/javascript">
	
		//定义一个总记录数，用于添加完员工的跳转页数。
		var totalRecord;
	
		//页面加载完成，通过Ajax发送请求，得到分页数据
		$(function() {
			//进入页面 直接跳转到第一页
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//1、请求成功之后，解析并显示员工信息
					build_emps_table(result);
					//2、解析分页信息
					build_page_info(result);
					//3、解析显示分页条信息
					build_page_nav(result);
				}

			});
		}

		//解析显示员工信息
		function build_emps_table(result) {
			//在构建信息表格之前，先进行清空数据，防止数据重叠
			$("#emps_table").empty();

			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkboxTd = $("<td><input type='checkbox' class='checkbox' /></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn").attr("emp_id", item.empId)
													.append($("<span></span>").addClass("glyphicon glyphicon-edit"))
													.append(" 编辑");
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn").attr("emp_id", item.empId)
												   .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
												   .append(" 删除");
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

				$("<tr></tr>").append(checkboxTd).append(empIdTd).append(empNameTd).append(genderTd)
							  .append(emailTd).append(deptNameTd).append(btnTd)
							  .appendTo("#emps_table");
			});
		}

		// 记录当前页面
		var currentPage;
		
		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info").empty();

			currentPage = result.extend.pageInfo.pageNum;
			
			$("#page_info").append(
					"当前第" + result.extend.pageInfo.pageNum + "页，共"
							+ result.extend.pageInfo.pages + "页，共"
							+ result.extend.pageInfo.total + "条记录");
			
			totalRecord = result.extend.pageInfo.total;
		}

		//解析显示分页条信息
		function build_page_nav(result) {
			$("#page_nav").empty();

			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				})
			}

			ul.append(firstPageLi);

			$.each(result.extend.pageInfo.navigatepageNums, function(index,item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				})

				ul.append(numLi);
			});

			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
			
			if (result.extend.pageInfo.hasNextPage == false) {
				lastPageLi.addClass("disabled");
			} else {
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				})
			}

			ul.append(lastPageLi);
			var nav = $("<nav></nav>").append(ul);
			nav.appendTo("#page_nav");
		}

		
		//清空所有元素
		function reset(ele) {
			//清空表单内容
			$(ele)[0].reset();
			
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮，弹出新增员工的模态框
		$("#emp_add_btn").click(function() {
			//在弹出模态框时，应该先清空表单内的所有数据，防止已经校验成功的数据重复录入数据库
			//使用dom对象进行重置
			//$("#empAdd form")[0].reset();
			reset("#empAdd form");
			
			//在弹出模态框之前，应该先发送请求取到部门信息，并填入下拉列表中
			getDepts("#dept_add");
			
			//弹出模态框
			$("#empAdd").modal({
				backdrop : "static"
			});
		});
		
		function getDepts(ele) {
			// 请求数据之前，应该先清除下拉选择条内的内容，防止内容重复
			$(ele).empty();
			//发出ajax请求，拿到部门信息
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function (result) {
					//console.log(result);
					//显示部门信息，填充到下拉列表中
					$.each(result.extend.depts, function (index, item) {
						var optionEle = $("<option></option>").append(item.deptName)
							.attr("value", item.deptId);
						optionEle.appendTo(ele);
					})
				}
			})
		}
		
		
		$("#emp_save-btn").click(function () {
			//将表单数据提交给服务器保存
			//保存之前应该先对数据的正确性进行校验
			if (!validate_add_form()) {
				return false;
			}
			
			//如果用户名校验失败，直接返回false，防止依然可以添加到数据库
			if ($("#emp_save-btn").attr("ajax-va") == "error") {
				return false;
			}
			
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAdd form").serialize(),
				success:function(result) {
					//alert(result.msg);
					//处理成功，进行保存等操作
					if (result.code == 100) {
						//信息保存成功之后
						//1、关闭模态框
						$("#empAdd").modal("hide");
						
						//2、跳转到最后一页
						to_page(totalRecord);
						
					//处理失败，显示错误信息
					} else {
						if (undefined != result.extend.errorFields.email) {
							show_validate_info("#emp_email", "error", "邮箱格式不正确");
						};
						if (undefined != result.extend.errorFields.empName) {
							show_validate_info("#emp_Name", "error", "姓名由2-4个汉字或3-9个英语字符组成");
						};
					}
				}
			});
		});
		
		
		function validate_add_form() {
			
			//校验姓名格式
			var empName = $("#emp_Name").val();
			var regName = /(^[a-zA-Z0-9_-]{3,9}$)|(^[\u2E80-\u9FFF]{2,4}$)/;
			//alert(regName.test(empName));
			if (!regName.test(empName)) {
				//alert("姓名由2-4个汉字或3-9个英语字符组成！");
				//$("#emp_Name").parent().addClass("has-error");
				//$("#emp_Name").next("span").text("姓名由2-4个汉字或3-9个英语字符组成");
				show_validate_info("#emp_Name", "error", "姓名由2-4个汉字或3-9个英语字符组成");
				return false;
			} else {
				//$("#emp_Name").parent().addClass("has-success");
				//$("#emp_Name").next("span").text("");
				show_validate_info("#emp_Name", "success", "");
			};
			
			
			//校验邮箱格式
			var email = $("#emp_email").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			//alert(regEmail.test(email));
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确！");
				show_validate_info("#emp_email", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_info("#emp_email", "success", "");
			};
			
			return true;
		}
		
		//校验结果实时反馈
		function show_validate_info(ele, status, msg) {
			//在校验之前，应该先清空之前的校验信息，防止显示校验信息不正确
			$(ele).parent().removeClass("has-success has-error");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		
		$("#emp_Name").change(function() {
			//发送ajax请求，校验用户名是否与数据库中已有的用户名重复
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName=" + empName,
				type:"POST",
				success:function(result) {
					if (result.code == 100) {
						show_validate_info("#emp_Name", "success", "用户名可用");
						$("#emp_save-btn").attr("ajax-va", "success");
					} else if (result.code == 200) {
						show_validate_info("#emp_Name", "error", result.extend.va_msg);
						$("#emp_save-btn").attr("ajax-va", "error");
					}
				}
			});
		});
		
		
		// 给后生成的员工信息编辑和删除按钮绑定事件
		// 由于是后生成的按钮，旧版jquery可以用live方法
		// 新版里live方法被移除，只能用on方法来绑定事件
		$(document).on("click", ".edit_btn", function () {
			// 将编辑按钮附带的员工id传递给更新按钮
			$("#emp_update_btn").attr("emp_id", $(this).attr("emp_id"));
			// 弹出模态框之前。应该先去数据库查询部门信息
			getDepts("#dept_update");
			// 根据id查到员工信息
			getEmp($(this).attr("emp_id"));
			
			$("#empUpdate").modal({
				backdrop : "static"
			});
		});
		
		
		function getEmp(id) {
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"GET",
				success:function(result) {
					// console.log(result);
					var empData = result.extend.emp;
					$("#empName_static").text(empData.empName);
					$("#emp_update_email").val(empData.email);
					$("#empUpdate input[name=gender]").val([empData.gender]);
					$("#empUpdate select").val([empData.dId]);
				}
			});
		}
		
		
		$("#emp_update_btn").click(function() {
			
			// 1、校验邮箱格式
			var email = $("#emp_update_email").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_info("#emp_update_email", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_info("#emp_update_email", "success", "");
			};
			
			// 2、发送ajax请求进行保存
			$.ajax({
				url:"${APP_PATH}/emp/" + $(this).attr("emp_id"),
				// 如果要直接发送PUT请求，需要配置HttpPutFormContentFilter
				type:"PUT",
				data:$("#empUpdate form").serialize(),
				
				// 不配置HttpPutFormContentFilter，则使用下面的写法
				// type:"POST",
				// data:$("#empUpdate form").serialize() + "&_method=PUT",
				
				success:function(result) {
					// alert(result.msg);
					//1、关闭模态框
					$("#empUpdate").modal("hide");
					
					//2、跳转到最后一页
					to_page(currentPage);
				}
			});
		});
		
		
		
		// 删除单个员工
		$(document).on("click", ".del_btn", function () {
			
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("emp_id");
			
			if (confirm("确定删除【" + empName + "】？")) {
				$.ajax({
					url:"${APP_PATH}/emp/" + empId,
					type:"DELETE",
					success:function(result) {
						// console.log(result);
						alert("删除成功");
						to_page(currentPage);
					}
				});
			};
			
		});
		
		// 选中全选框，单选框全部选中
		$("#check_all").click(function() {
			// alert($(this).prop("checked"));
			$(".checkbox").prop("checked", $(this).prop("checked"));
		}); 
		
		// 当单选框全部选中时，全选框也应该自动选中
		$(document).on("click", ".checkbox", function() {
			var flag = ($(".checkbox:checked").length == $(".checkbox").length);
			$("#check_all").prop("checked", flag);
		});
		
		// 批量删除
		$("#emp_delete_btn").click(function() {
			// 拼接提示信息
			var empNames = "";
			// 拼接id
			var empIds = "";
			$.each($(".checkbox:checked"), function() {
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			// 去掉结尾多余的逗号
			empNames = empNames.substring(0, empNames.length - 1);
			// 去掉结尾多余的横线
			empIds = empIds.substring(0, empIds.length - 1);
			if (confirm("确定要删除【" + empNames + "】吗？")) {
				$.ajax({
					url:"${APP_PATH}/emp/" + empIds,
					type:"DELETE",
					success:function(result) {
						// console.log(result);
						alert("批量删除成功");
						to_page(currentPage);
					}
				});
			}
		});
		
		
	</script>
</body>
</html>