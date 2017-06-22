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
	EmployeeMapper employeemapper;
	
	/**
	 * 查询所有员工
	 * @return
	 */

	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeemapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeemapper.insertSelective(employee);
	}

	/**
	 * 员工名字字段校验
	 * 检验用户名是否可用
	 * @return 0 true:代表当前姓名可用 false:代表不可用
	 */
	
	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		 long count = employeemapper.countByExample(example);
		return count == 0;
	}
	
	/**
	 * 按照员工Id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeemapper.selectByPrimaryKey(id);
		return employee;
	}
	
}
