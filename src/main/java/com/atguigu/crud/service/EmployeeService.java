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

	// ��ѯ����Ա����Ϣ�������ϲ�����Ϣ��
	public List<Employee> getAll() {

		// �趨������򣬼�����Ա��id����
		EmployeeExample example = new EmployeeExample();
		example.setOrderByClause("`emp_id` ASC");
		
		return employeeMapper.selectByExampleWithDept(example);
	
	}

	// ����Ա����Ϣ
	public void saveEmp(Employee employee) {

		employeeMapper.insertSelective(employee);
	}

	//�������ݿ����Ƿ��Ѿ�����empName������Ѿ����ˣ��򷵻�false�����󷵻�true��������û�������)
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

	
	// ����Ա����Ϣ
	public void updateEmp(Employee employee) {
		
		employeeMapper.updateByPrimaryKeySelective(employee);
		
	}

	
	// ɾ������Ա������Ϣ
	public void deleteEmp(Integer id) {
		
		employeeMapper.deleteByPrimaryKey(id);
	}
	

	// ����ɾ��Ա����Ϣ
	public void deleteBatch(List<Integer> ids) {
		
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		// delete from tbl_emp where id in (...)
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}


}
