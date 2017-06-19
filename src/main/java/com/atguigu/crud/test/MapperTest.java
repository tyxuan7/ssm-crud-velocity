package com.atguigu.crud.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.dao.DepartmentMapper;


/**
 * 测试dao层的工作
 *推荐spring的项目就可以使用spring的单元测试，可以自动注入我们需要的组件
 *1.maven导入springtest模板
 *2.@ContextConfiguration指定spring配置文件的位置
 *3.直接@Autowired 要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	/**
	 * 测试DepartmentMapper
	 */
	@Test
	public void testCURD(){
	/*	//1.创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		System.out.println(departmentMapper);
	}
}
