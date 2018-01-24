package com.atguigu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

//使用Spring单元测试提供的测试请求功能，来测试crud

@RunWith(SpringJUnit4ClassRunner.class)
// @WebAppConfiguration 可以自动装配自己的ioc
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml" })
public class MvcTest {

	// 传入SpringMVC自己的ioc
	@Autowired
	WebApplicationContext context;

	// 虚拟MVC请求，得到请求结果
	MockMvc mockMvc;

	// 每次都需要初始化，则配置@Before
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testPage() throws Exception {

		// 模拟一个get请求，并拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();

		// 请求成功后，请求域中会有pageInfo，可以取出pageInfo来验证数据
		MockHttpServletRequest request = result.getRequest();

		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");

		System.out.println("当前页码：" + pi.getPageNum());
		System.out.println("总页数：" + pi.getPages());
		System.out.println("总记录数：" + pi.getTotal());

		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.print("" + i);
		}
		
		System.out.println();

		List<Employee> list = pi.getList();
		for (Employee employee : list) {
			System.out.println("ID: " + employee.getEmpId() + "--- Name: " + employee.getEmpName());
		}
		
		for (Employee employee : list) {
			System.out.println(employee.getDepartment());
		}
	}

}
