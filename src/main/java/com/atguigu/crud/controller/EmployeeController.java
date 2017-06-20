package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工crud请求
 *
 */

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeservice;
	
	
	/**
	 * 查询员工数据(分页查询)
	 *
	 */
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,
			Model model){
		
		//这不是一个分页查询
		//引入PageHelper分页插件
		//在查询之前只需要调用,传入页码以及每页的大小
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟的一个查询就是一个分页
		List<Employee> emps = employeeservice.getAll();
		//使用pageinfo包装查询后的结果，只需要将pageinfo交给页码就行了
		//封装详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		return "list";
	}
}
