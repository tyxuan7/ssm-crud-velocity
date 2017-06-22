package com.atguigu.crud.controller;

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

/**
 * 处理员工crud请求
 *
 */

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeservice;
	
	/**
	 * 按照员工Id查询员工
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee = employeeservice.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	/**
	 * 姓名校验
	 */
	
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName") String empName){
		//判断用户名是否合法
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg", "用户名可以是2-5位中文或者6-16位英文和数字的组合! java返回");
		}
		//数据库用户名重复校验
		boolean b = employeeservice.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用！  java返回");
		}
	}
	/**
	 * 员工保存post请求
	 * 1.支持JSR303校验
	 * 2.导入Hibernate-validator  @Valid BindingResult 封装校验的结果
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中校验失败的错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fielderror : errors){
				System.out.println("错误的字段名："+fielderror.getField());
				System.out.println("错误的信息:"+fielderror.getDefaultMessage());
				map.put(fielderror.getField(), fielderror.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeservice.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	/**
	 * 
	 * ajax获取分页数据
	 * 导入jackson 包处理json数据
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1") Integer pn){
		//这不是一个分页查询
				//引入PageHelper分页插件
				//在查询之前只需要调用,传入页码以及每页的大小
				PageHelper.startPage(pn, 5);
				//startPage后面紧跟的一个查询就是一个分页
				List<Employee> emps = employeeservice.getAll();
				//使用pageinfo包装查询后的结果，只需要将pageinfo交给页码就行了
				//封装详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}
	/**
	 * 查询员工数据(分页查询)
	 *页面转发的形式获取分页数据
	 */
	//@RequestMapping("/emps")
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
