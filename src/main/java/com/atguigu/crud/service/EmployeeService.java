package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	// 查询所有员工信息，并带上部门信息。
	public List<Employee> getAll() {

		// 设定排序规则，即按照员工id排序
		EmployeeExample example = new EmployeeExample();
		example.setOrderByClause("`emp_id` ASC");
		
		return employeeMapper.selectByExampleWithDept(example);
	
	}

	// 新增员工信息
	public void saveEmp(Employee employee) {

		employeeMapper.insertSelective(employee);
	}

	//检验数据库中是否已经存在empName，如果已经有了，则返回false，苟泽返回true（输入的用户名可用)
	public boolean checkUser(String empName) {
		
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		
		long count = employeeMapper.countByExample(example);
		
		return count == 0;
	}

	
	public Employee getEmp(Integer id) {
		
		Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
		
		return employee;
	}

	
	// 更新员工信息
	public void updateEmp(Employee employee) {
		
		employeeMapper.updateByPrimaryKeySelective(employee);
		
	}

	
	// 删除单个员工的信息
	public void deleteEmp(Integer id) {
		
		employeeMapper.deleteByPrimaryKey(id);
	}
	

	// 批量删除员工信息
	public void deleteBatch(List<Integer> ids) {
		
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		// delete from tbl_emp where id in (...)
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}


}
