package com.atguigu.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
	private Integer empId;

	//��˽����û����Ƿ����Ҫ�����֤����ֹ�û�����ǰ����֤
	@Pattern(regexp="(^[a-zA-Z0-9_-]{3,9}$)|(^[\\u2E80-\\u9FFF]{2,4}$)", 
			message="������2-4�����ֻ�3-9��Ӣ���ַ����")
	private String empName;

	private Integer dId;

	private String gender;
	
	//��˽��������Ƿ����Ҫ�����֤����ֹ�û�����ǰ����֤
	//@Email
	//Ҳ����д�����ϵ�ע��
	@Pattern(regexp="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", 
			message="�����ʽ����ȷ")
	private String email;

	// ��ѯԱ����ͬʱ�����Բ�ѯ�䲿�š�
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