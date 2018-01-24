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
<script src="${APP_PATH}/static/js/jquery.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<title>Ա���б�</title>
</head>
<body>


	<!-- ����Ա����ģ̬�� -->
	<div class="modal fade" id="empUpdate" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">����Ա��</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">����</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">����</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="emp_update_email" name="email">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">�Ա�</label> 
							<div class="col-sm-10">
								<label class="radio-inline"> 
									<input type="radio"
									name="gender" id="emp_gender_M" value="M" checked="checked"> ��
								</label> 
								<label class="radio-inline"> 
									<input type="radio"
									name="gender" id="emp_gender_F" value="F"> Ů
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">����</label> 
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">ȡ��</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">����</button>
				</div>
			</div>
		</div>
	</div>



	<!-- ���Ա����ģ̬�� -->
	<div class="modal fade" id="empAdd" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">����Ա��</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">����</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="emp_Name" name="empName"
									placeholder="����">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">����</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="emp_email" name="email"
									placeholder="email@google.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">�Ա�</label> 
							<div class="col-sm-10">
								<label class="radio-inline"> 
									<input type="radio"
									name="gender" id="emp_gender_M" value="M" checked="checked"> ��
								</label> 
								<label class="radio-inline"> 
									<input type="radio"
									name="gender" id="emp_gender_F" value="F"> Ů
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">����</label> 
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add">
								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">ȡ��</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">����</button>
				</div>
			</div>
		</div>
	</div>

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
				<button class="btn btn-primary" id="emp_add_btn">����</button>
				<button class="btn btn-danger" id="emp_delete_btn">ɾ��</button>
			</div>
		</div>
		<br />
		<!-- ��� -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>����</th>
							<th>�Ա�</th>
							<th>����</th>
							<th>����</th>
							<th>����</th>
						</tr>
					</thead>
					<tbody id="emps_table"></tbody>
				</table>
			</div>
		</div>
		<!-- ��ҳ��Ϣ -->
		<div class="row">
			<!-- ��ҳ�ı���Ϣ -->
			<div class="col-md-6" id="page_info"></div>
			<!-- ��ҳ������ -->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>


	<script type="text/javascript">
	
		//����һ���ܼ�¼�������������Ա������תҳ����
		var totalRecord;
	
		//ҳ�������ɣ�ͨ��Ajax�������󣬵õ���ҳ����
		$(function() {
			//����ҳ�� ֱ����ת����һҳ
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//1������ɹ�֮�󣬽�������ʾԱ����Ϣ
					build_emps_table(result);
					//2��������ҳ��Ϣ
					build_page_info(result);
					//3��������ʾ��ҳ����Ϣ
					build_page_nav(result);
				}

			});
		}

		//������ʾԱ����Ϣ
		function build_emps_table(result) {
			//�ڹ�����Ϣ���֮ǰ���Ƚ���������ݣ���ֹ�����ص�
			$("#emps_table").empty();

			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkboxTd = $("<td><input type='checkbox' class='checkbox' /></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender == 'M' ? "��" : "Ů");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn").attr("emp_id", item.empId)
													.append($("<span></span>").addClass("glyphicon glyphicon-edit"))
													.append(" �༭");
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn").attr("emp_id", item.empId)
												   .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
												   .append(" ɾ��");
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

				$("<tr></tr>").append(checkboxTd).append(empIdTd).append(empNameTd).append(genderTd)
							  .append(emailTd).append(deptNameTd).append(btnTd)
							  .appendTo("#emps_table");
			});
		}

		// ��¼��ǰҳ��
		var currentPage;
		
		//������ʾ��ҳ��Ϣ
		function build_page_info(result) {
			$("#page_info").empty();

			currentPage = result.extend.pageInfo.pageNum;
			
			$("#page_info").append(
					"��ǰ��" + result.extend.pageInfo.pageNum + "ҳ����"
							+ result.extend.pageInfo.pages + "ҳ����"
							+ result.extend.pageInfo.total + "����¼");
			
			totalRecord = result.extend.pageInfo.total;
		}

		//������ʾ��ҳ����Ϣ
		function build_page_nav(result) {
			$("#page_nav").empty();

			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("��ҳ").attr("href", "#"));
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

			var lastPageLi = $("<li></li>").append($("<a></a>").append("ĩҳ").attr("href", "#"));
			
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

		
		//�������Ԫ��
		function reset(ele) {
			//��ձ�����
			$(ele)[0].reset();
			
			//��ձ���ʽ
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//���������ť����������Ա����ģ̬��
		$("#emp_add_btn").click(function() {
			//�ڵ���ģ̬��ʱ��Ӧ������ձ��ڵ��������ݣ���ֹ�Ѿ�У��ɹ��������ظ�¼�����ݿ�
			//ʹ��dom�����������
			//$("#empAdd form")[0].reset();
			reset("#empAdd form");
			
			//�ڵ���ģ̬��֮ǰ��Ӧ���ȷ�������ȡ��������Ϣ�������������б���
			getDepts("#dept_add");
			
			//����ģ̬��
			$("#empAdd").modal({
				backdrop : "static"
			});
		});
		
		function getDepts(ele) {
			// ��������֮ǰ��Ӧ�����������ѡ�����ڵ����ݣ���ֹ�����ظ�
			$(ele).empty();
			//����ajax�����õ�������Ϣ
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function (result) {
					//console.log(result);
					//��ʾ������Ϣ����䵽�����б���
					$.each(result.extend.depts, function (index, item) {
						var optionEle = $("<option></option>").append(item.deptName)
							.attr("value", item.deptId);
						optionEle.appendTo(ele);
					})
				}
			})
		}
		
		
		$("#emp_save-btn").click(function () {
			//���������ύ������������
			//����֮ǰӦ���ȶ����ݵ���ȷ�Խ���У��
			if (!validate_add_form()) {
				return false;
			}
			
			//����û���У��ʧ�ܣ�ֱ�ӷ���false����ֹ��Ȼ������ӵ����ݿ�
			if ($("#emp_save-btn").attr("ajax-va") == "error") {
				return false;
			}
			
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAdd form").serialize(),
				success:function(result) {
					//alert(result.msg);
					//����ɹ������б���Ȳ���
					if (result.code == 100) {
						//��Ϣ����ɹ�֮��
						//1���ر�ģ̬��
						$("#empAdd").modal("hide");
						
						//2����ת�����һҳ
						to_page(totalRecord);
						
					//����ʧ�ܣ���ʾ������Ϣ
					} else {
						if (undefined != result.extend.errorFields.email) {
							show_validate_info("#emp_email", "error", "�����ʽ����ȷ");
						};
						if (undefined != result.extend.errorFields.empName) {
							show_validate_info("#emp_Name", "error", "������2-4�����ֻ�3-9��Ӣ���ַ����");
						};
					}
				}
			});
		});
		
		
		function validate_add_form() {
			
			//У��������ʽ
			var empName = $("#emp_Name").val();
			var regName = /(^[a-zA-Z0-9_-]{3,9}$)|(^[\u2E80-\u9FFF]{2,4}$)/;
			//alert(regName.test(empName));
			if (!regName.test(empName)) {
				//alert("������2-4�����ֻ�3-9��Ӣ���ַ���ɣ�");
				//$("#emp_Name").parent().addClass("has-error");
				//$("#emp_Name").next("span").text("������2-4�����ֻ�3-9��Ӣ���ַ����");
				show_validate_info("#emp_Name", "error", "������2-4�����ֻ�3-9��Ӣ���ַ����");
				return false;
			} else {
				//$("#emp_Name").parent().addClass("has-success");
				//$("#emp_Name").next("span").text("");
				show_validate_info("#emp_Name", "success", "");
			};
			
			
			//У�������ʽ
			var email = $("#emp_email").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			//alert(regEmail.test(email));
			if (!regEmail.test(email)) {
				//alert("�����ʽ����ȷ��");
				show_validate_info("#emp_email", "error", "�����ʽ����ȷ");
				return false;
			} else {
				show_validate_info("#emp_email", "success", "");
			};
			
			return true;
		}
		
		//У����ʵʱ����
		function show_validate_info(ele, status, msg) {
			//��У��֮ǰ��Ӧ�������֮ǰ��У����Ϣ����ֹ��ʾУ����Ϣ����ȷ
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
			//����ajax����У���û����Ƿ������ݿ������е��û����ظ�
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName=" + empName,
				type:"POST",
				success:function(result) {
					if (result.code == 100) {
						show_validate_info("#emp_Name", "success", "�û�������");
						$("#emp_save-btn").attr("ajax-va", "success");
					} else if (result.code == 200) {
						show_validate_info("#emp_Name", "error", result.extend.va_msg);
						$("#emp_save-btn").attr("ajax-va", "error");
					}
				}
			});
		});
		
		
		// �������ɵ�Ա����Ϣ�༭��ɾ����ť���¼�
		// �����Ǻ����ɵİ�ť���ɰ�jquery������live����
		// �°���live�������Ƴ���ֻ����on���������¼�
		$(document).on("click", ".edit_btn", function () {
			// ���༭��ť������Ա��id���ݸ����°�ť
			$("#emp_update_btn").attr("emp_id", $(this).attr("emp_id"));
			// ����ģ̬��֮ǰ��Ӧ����ȥ���ݿ��ѯ������Ϣ
			getDepts("#dept_update");
			// ����id�鵽Ա����Ϣ
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
			
			// 1��У�������ʽ
			var email = $("#emp_update_email").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_info("#emp_update_email", "error", "�����ʽ����ȷ");
				return false;
			} else {
				show_validate_info("#emp_update_email", "success", "");
			};
			
			// 2������ajax������б���
			$.ajax({
				url:"${APP_PATH}/emp/" + $(this).attr("emp_id"),
				// ���Ҫֱ�ӷ���PUT������Ҫ����HttpPutFormContentFilter
				type:"PUT",
				data:$("#empUpdate form").serialize(),
				
				// ������HttpPutFormContentFilter����ʹ�������д��
				// type:"POST",
				// data:$("#empUpdate form").serialize() + "&_method=PUT",
				
				success:function(result) {
					// alert(result.msg);
					//1���ر�ģ̬��
					$("#empUpdate").modal("hide");
					
					//2����ת�����һҳ
					to_page(currentPage);
				}
			});
		});
		
		
		
		// ɾ������Ա��
		$(document).on("click", ".del_btn", function () {
			
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("emp_id");
			
			if (confirm("ȷ��ɾ����" + empName + "����")) {
				$.ajax({
					url:"${APP_PATH}/emp/" + empId,
					type:"DELETE",
					success:function(result) {
						// console.log(result);
						alert("ɾ���ɹ�");
						to_page(currentPage);
					}
				});
			};
			
		});
		
		// ѡ��ȫѡ�򣬵�ѡ��ȫ��ѡ��
		$("#check_all").click(function() {
			// alert($(this).prop("checked"));
			$(".checkbox").prop("checked", $(this).prop("checked"));
		}); 
		
		// ����ѡ��ȫ��ѡ��ʱ��ȫѡ��ҲӦ���Զ�ѡ��
		$(document).on("click", ".checkbox", function() {
			var flag = ($(".checkbox:checked").length == $(".checkbox").length);
			$("#check_all").prop("checked", flag);
		});
		
		// ����ɾ��
		$("#emp_delete_btn").click(function() {
			// ƴ����ʾ��Ϣ
			var empNames = "";
			// ƴ��id
			var empIds = "";
			$.each($(".checkbox:checked"), function() {
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			// ȥ����β����Ķ���
			empNames = empNames.substring(0, empNames.length - 1);
			// ȥ����β����ĺ���
			empIds = empIds.substring(0, empIds.length - 1);
			if (confirm("ȷ��Ҫɾ����" + empNames + "����")) {
				$.ajax({
					url:"${APP_PATH}/emp/" + empIds,
					type:"DELETE",
					success:function(result) {
						// console.log(result);
						alert("����ɾ���ɹ�");
						to_page(currentPage);
					}
				});
			}
		});
		
		
	</script>
</body>
</html>