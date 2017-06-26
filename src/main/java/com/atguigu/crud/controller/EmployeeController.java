package com.atguigu.crud.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * ����Ա��crud����
 *
 */

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeservice;
	
	
	/**
	 * ��������ɾ������һ
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids") String ids){
		//����ɾ��
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList();
			String[] str_ids = ids.split("-");
			//��װid�ļ���
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeservice.deleteBatch(del_ids);
		}else{
			//����ɾ��
			Integer id = Integer.parseInt(ids);
			employeeservice.deleteEmp(id);
		}
		
		return Msg.success();
	}
	/**
	 * ����Ա����Ϣput����sql�����ԭ��:
	 * tomcat:
	 * 		1.���������е����ݣ���װ��һ��map��
	 * 		2.request.getParameter("empName")�ͻ�����map��ȡֵ��
	 * 		3.springMVC��װPOJO�����ʱ��,���POJO��ÿ�����Ե�ֵ��
	 * 			request.getParameter("email")��ʽ�õ�
	 * ajax����put�������������⣺
	 * 				PUT�����������е����ݣ�request.getParameter("empName")�ò���
	 * 				TOMCATһ����PUT�����װ�������е�����Ϊmap��ֻ��POST��ʽ������Ż��װ������Ϊmap
	 * ���������
	 * web.xml������HttpPutFormContentFilter
	 * ���ã����������е����ݽ�����װ��һ��map
	 * request�����°�װ��request.getParemeter()����д���ͻ���Լ���װ��map ��ȡ����
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg updateEmp(Employee employee,HttpServletRequest request){
		System.out.println("�������ص�ֵ:" + request.getParameter("gender"));
		System.out.println("��Ҫ���µ�Ա������" + employee);
		employeeservice.updateEmp(employee);
		return Msg.success();
	}
	/**
	 * ����Ա��Id��ѯԱ��
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee = employeeservice.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	/**
	 * ����У��
	 */
	
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName") String empName){
		//�ж��û����Ƿ�Ϸ�
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg", "�û���������2-5λ���Ļ���6-16λӢ�ĺ����ֵ����! java����");
		}
		//���ݿ��û����ظ�У��
		boolean b = employeeservice.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "�û��������ã�  java����");
		}
	}
	/**
	 * Ա������post����
	 * 1.֧��JSR303У��
	 * 2.����Hibernate-validator  @Valid BindingResult ��װУ��Ľ��
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//У��ʧ�ܣ�Ӧ�÷���ʧ�ܣ���ģ̬����У��ʧ�ܵĴ�����Ϣ
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fielderror : errors){
				System.out.println("������ֶ�����"+fielderror.getField());
				System.out.println("�������Ϣ:"+fielderror.getDefaultMessage());
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
	 * ajax��ȡ��ҳ����
	 * ����jackson ������json����
	 * @return
	 */
	//@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1") Integer pn){
		//�ⲻ��һ����ҳ��ѯ
				//����PageHelper��ҳ���
				//�ڲ�ѯ֮ǰֻ��Ҫ����,����ҳ���Լ�ÿҳ�Ĵ�С
				PageHelper.startPage(pn, 5);
				//startPage���������һ����ѯ����һ����ҳ
				List<Employee> emps = employeeservice.getAll();
				//ʹ��pageinfo��װ��ѯ��Ľ����ֻ��Ҫ��pageinfo����ҳ�������
				//��װ��ϸ�ķ�ҳ��Ϣ���������ǲ�ѯ����������,����������ʾ��ҳ��
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}
	/**
	 * ��ѯԱ������(��ҳ��ѯ)
	 *ҳ��ת������ʽ��ȡ��ҳ����
	 */
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,
			Model model){
		
		//�ⲻ��һ����ҳ��ѯ
		//����PageHelper��ҳ���
		//�ڲ�ѯ֮ǰֻ��Ҫ����,����ҳ���Լ�ÿҳ�Ĵ�С
		PageHelper.startPage(pn, 5);
		//startPage���������һ����ѯ����һ����ҳ
		List<Employee> emps = employeeservice.getAll();
		//ʹ��pageinfo��װ��ѯ��Ľ����ֻ��Ҫ��pageinfo����ҳ�������
		//��װ��ϸ�ķ�ҳ��Ϣ���������ǲ�ѯ����������,����������ʾ��ҳ��
		PageInfo page = new PageInfo(emps,5);
		//ModelAndView mv=new ModelAndView("list");
		//mv.addObject("emps", emps);
		//System.out.println(emps);
		//return mv;
		model.addAttribute("pageInfo",page);
		return "list";
	}
}
