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

//����Ա������ɾ�Ĳ�

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	// ������������Ա��ɾ��
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids") String ids) {

		if (ids.contains("-")) {
			List<Integer> delIds = new ArrayList<Integer>();
			
			// �ָ�id�ַ��������������
			String[] strings = ids.split("-");
			// ��id��ӵ�������
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

	// Ա���ĸ��£�ʹ��put����
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {

		employeeService.updateEmp(employee);

		return Msg.success();
	}

	// �ñ�Ų�ĸ�Ա������Ϣ
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {

		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	// ����û�������û����Ƿ����
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam("empName") String empName) {
		// ���У���û����Ƿ���ϱ��ʽ����
		String regex = "(^[a-zA-Z0-9_-]{3,9}$)|(^[\\u2E80-\\u9FFF]{2,4}$)";
		if (!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "������2-4�����ֻ�3-9��Ӣ���ַ����");
		}

		// У���û����Ƿ��Ѿ������ݿ��д���
		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		}
		return Msg.fail().add("va_msg", "�û����Ѵ��ڣ�����������");
	}

	// ����ͨ��post�����Ҳ���id���ύΪ����Ա��
	// �����˺�˵�JSR303��֤
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			// ��������д�����У��ʧ�ܣ�Ӧ����ʧ�ܵĵط���ʾ��������Ϣ
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

		// ����PageHelper��ҳ��������з�ҳ��ѯ
		// ��ѯʱ�������ѯҳ���Լ�ÿҳ�Ľ������
		PageHelper.startPage(pn, 5);

		// startPage��������Ĳ�ѯ����һ����ҳ��ѯ
		List<Employee> emps = employeeService.getAll();

		// ʹ��pageInfo�Բ�ѯ������а�װ��ֻ��Ҫ��pageInfo����ҳ��Ϳ�����
		// �������"5"��������ʾ��ҳ��
		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);

		model.addAttribute("pageInfo", page);

		return "list";
	}

}
