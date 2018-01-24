package com.atguigu.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
	private Integer empId;

	//后端进行用户名是否符合要求的验证，防止用户跳过前端验证
	@Pattern(regexp="(^[a-zA-Z0-9_-]{3,9}$)|(^[\\u2E80-\\u9FFF]{2,4}$)", 
			message="姓名由2-4个汉字或3-9个英语字符组成")
	private String empName;

	private Integer dId;

	private String gender;
	
	//后端进行邮箱是否符合要求的验证，防止用户跳过前端验证
	//@Email
	//也可以写成以上的注解
	@Pattern(regexp="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", 
			message="邮箱格式不正确")
	private String email;

	// 查询员工的同时，可以查询其部门。
	private Department department;

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, Integer dId, String gender, String email) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.dId = dId;
		this.gender = gender;
		this.email = email;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName == null ? null : empName.trim();
	}

	public Integer getdId() {
		return dId;
	}

	public void setdId(Integer dId) {
		this.dId = dId;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender == null ? null : gender.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}
}