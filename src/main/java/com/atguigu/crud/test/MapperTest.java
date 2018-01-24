package com.atguigu.crud.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCRUD() {


		// 插入部门测试
		// departmentMapper.insertSelective(new Department(null, "开发部"));
		// departmentMapper.insertSelective(new Department(null, "测试部"));
		List<Department> list = departmentMapper.selectByExample(null);
		
		System.out.println(list.size());
		
		// 插入员工测试
		/*for (int i = 0; i < 1000; i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 4) + i;
			employeeMapper.insertSelective(new Employee(null, uuid, 1, "F", uuid + "@google.com"));
		}
		System.out.println("批量添加结束");*/
	}
}
