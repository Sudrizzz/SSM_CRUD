package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

//处理员工的增删改查

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	// 单个或者批量员工删除
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids") String ids) {

		if (ids.contains("-")) {
			List<Integer> delIds = new ArrayList<Integer>();
			
			// 分割id字符串，保存成数组
			String[] strings = ids.split("-");
			// 将id添加到集合中
			for (String id : strings) {
				delIds.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(delIds);
			
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return Msg.success();
	}

	// 员工的更新，使用put请求
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {

		employeeService.updateEmp(employee);

		return Msg.success();
	}

	// 用编号查的该员工的信息
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {

		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	// 检查用户输入的用户名是否可用
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam("empName") String empName) {
		// 后端校验用户名是否符合表达式规则
		String regex = "(^[a-zA-Z0-9_-]{3,9}$)|(^[\\u2E80-\\u9FFF]{2,4}$)";
		if (!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "姓名由2-4个汉字或3-9个英语字符组成");
		}

		// 校验用户名是否已经在数据库中存在
		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		}
		return Msg.fail().add("va_msg", "用户名已存在，请重新输入");
	}

	// 定义通过post方法且不带id的提交为新增员工
	// 增加了后端的JSR303验证
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			// 结果集中有错误，则校验失败，应该在失败的地方显示出错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}

	@ResponseBody
	@RequestMapping("/emps")
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		PageHelper.startPage(pn, 5);

		List<Employee> emps = employeeService.getAll();

		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);

		return Msg.success().add("pageInfo", page);
	}

	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

		// 引入PageHelper分页插件，进行分页查询
		// 查询时，传入查询页码以及每页的结果数量
		PageHelper.startPage(pn, 5);

		// startPage后面紧跟的查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();

		// 使用pageInfo对查询结果进行包装，只需要将pageInfo交给页面就可以了
		// 传入参数"5"是连续显示的页码
		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);

		model.addAttribute("pageInfo", page);

		return "list";
	}

}
