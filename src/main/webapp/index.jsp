<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css">
<script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

	
	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" >员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal modalForm">
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p  name="empName" class="form-control-static" id="empName_update_static" ></p>
			       <span  class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email">
			       <span  class="help-block"></span>
			    </div>
			  </div>
			   
			  <div class="form-group">
			  	<label  class="col-sm-2 control-label">gender</label>
			  	<div class="col-sm-10">
			      	<label class="radio-inline">
			  			<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  	<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
			    </div>
			  	
			  </div>
			  
			  <div class="form-group">
			  	<label  class="col-sm-2 control-label">deptName</label>
			  	<div class="col-sm-4">
			      	<select class="form-control" name="dId" id="dept_update_select">
					  
					</select>
			    </div>
			  	
			  </div>
			  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	

	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal modalForm">
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName"  >
			       <span  class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
			       <span  class="help-block"></span>
			    </div>
			  </div>
			   
			  <div class="form-group">
			  	<label  class="col-sm-2 control-label">gender</label>
			  	<div class="col-sm-10">
			      	<label class="radio-inline">
			  			<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  	<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
			    </div>
			  	
			  </div>
			  
			  <div class="form-group">
			  	<label  class="col-sm-2 control-label">deptName</label>
			  	<div class="col-sm-4">
			      	<select class="form-control" name="dId" id="dept_add_select">
					  
					</select>
			    </div>
			  	
			  </div>
			  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary btn-sm empAddModalBtn">新增</button>
				<button class="btn btn-danger btn-sm emp_delete_all_btn">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all" />
							</th>
							<th>id</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>depiName</th>
							<th>操作</th>
						</tr>
					</thead>
					
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 page_info_area" >
				
			</div>
			<div class="col-md-6 page_nav_area" >
				
			</div>
		</div>
		<div class="row"></div>
	</div>
	
	<script type="text/javascript">
		var maxPage,totalRecord,currentPage;

		//$(function(){
			//去首页
			//to_page(1);
			$.ajax({
					url:"${APP_PATH}/emps",
					data:"pn=1",
					async:false,
					type:"get",
					success:function(_res){
						//console.log(_res);
						build_emps_table(_res);
						build_page_info(_res);
						build_page_nav(_res);
						maxPage = _res.extend.pageInfo.pages;
					}			
				})
		//})
		
		function build_emps_table(_res){
			//清空table内容
			$("#emps_table tbody").empty();
			var emps = _res.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkboxId = $("<td><input type='checkbox' class='check_item' /></td>");
				var empIdTd = $("<td></td>").append(item.empId).addClass("firstTd");
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var ediBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append("编辑");
				var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm del_btn").append("删除");
				var btnTd = $("<td></td>").append(ediBtn).append(delBtn);
				$('<tr></tr>').append(checkboxId)
							  .append(empIdTd)
							  .append(empNameTd)
							  .append(genderTd)
							  .append(emailTd)
							  .append(deptNameTd)
							  .append(btnTd)
							  .appendTo("#emps_table tbody");
				
			})
		}
		
		//解析显示分页信息
		function build_page_info(_res){
			var emps = _res.extend.pageInfo;
			$(".page_info_area").html("当前 " + emps.pageNum + 
										" 页,总 " + emps.pages +
										" 页,总 " + emps.total + " 条记录 ");
			totalRecord = emps.pages;
			currentPage = emps.pageNum;
		}
		//解析显示分页条
		function build_page_nav(_res){
			var _html = "";
			var empsInfo =  _res.extend.pageInfo;
			var emps = _res.extend.pageInfo.navigatepageNums;
			var _nav = "<nav aria-label='Page navigation'>";
			var _ul = "<ul class='pagination'>";
			var firstPageLi = "<li  class='"+ (empsInfo.hasPreviousPage == false?'disabled':'') +"'><a href='#' onclick=to_page(1)>首页</a></li>";
			var prePageLi = "<li class='"+ (empsInfo.hasPreviousPage == false?'disabled':'')+"'>"+
							     "<a href='#' aria-label='Previous' onclick=to_page(" + (empsInfo.pageNum - 1)+ ")>"+
							        "<span aria-hidden='true'>&laquo;</span>"+
							     "</a>"+
							  "</li>";
			var nextPageLi = "<li class='"+ (empsInfo.hasNextPage == false?'disabled':'') +" '>"+
							     "<a href='#' aria-label='Previous' onclick=to_page("+ (empsInfo.pageNum + 1) +")>"+
							        "<span aria-hidden='true'>&raquo;</span>"+
							     "</a>"+
		  					"</li>";
			var lastPageL = "<li class='"+(empsInfo.hasNextPage == false?'disabled':'') +" '><a href='#' onclick=to_page("+ empsInfo.pages +")>末页</a></li>";
			
			 _html = _nav + _ul + firstPageLi + prePageLi;
			
			$.each(emps,function(index,item){
				var numLi = "<li class='"+ (empsInfo.pageNum == item?'active':'') + "' >" 
							+"<a href='#' onclick='to_page("+item+")'>"+item+"</a>"
							+"</li>";
				_html += numLi;
			
			})
			
			_html += nextPageLi + lastPageL +"</ul></nav>"
			
			$('.page_nav_area').html(_html);
			
		}
		function to_page(pn){
			if(pn>0&&pn<=maxPage){
				$.ajax({
					url:"${APP_PATH}/emps",
					data:"pn="+pn,
					type:"get",
					success:function(_res){
						//console.log(_res);
						build_emps_table(_res);
						build_page_info(_res);
						build_page_nav(_res);
						maxPage = _res.extend.pageInfo.pages;
					}
				})
			}
			
		}
		//最大值禁触发ajax
		//function maxDisable(num){
			//var maxPage = _res.extend.pageInfo.pages;

		//}
		function rest_form(ele){
			$(ele)[0].reset();
			//清空表单样式及内容 
			$(ele).find("*").removeClass("has-error has-sucess");
			$(ele).find(".help-block").text("");
		}
		//
		//新增模态框
		$(".empAddModalBtn").click(function(){
			//清楚表单数据（表单重置）
			rest_form("#empAddModal form");
			//发送ajax获取下拉列表数据
			getDepts("#dept_add_select");
			//模态框
			$('#empAddModal').modal({
				backdrop:"static"
			})
		})
		//查出下拉列表数据
		function getDepts(ele){
			//清空下拉列表
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				success:function(_res){
					var _depts = _res.extend.depts;
					//显示部门信息
					//$('#dept_add_select').append("");
					$.each(_depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						$(ele).append(optionEle);
						//optionEle.appendTo(#dept_add_select);
					})
				}
			})
		}
		
		//校验表单数据
		function validate_add_form(){
			var empName = $("#empName_add_input").val();
			var email = $("#email_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
							
			
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合!");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合!");
				return false;
				
			}else{
				//$("#empName_add_input").parent().removeClass("has-error");
				show_validate_msg("#empName_add_input","sucess","");
				
			}
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确!");
				show_validate_msg("#email_add_input","error","邮箱格式不正确!");
				return false;				
			}else{
				show_validate_msg("#email_add_input","sucess","");
			}
			return true;
		}
		//校验规则
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-error has-sucess");
			if("sucess" == status){
				$(ele).parent().addClass("has-sucess");
				$(ele).siblings("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).siblings("span").text(msg);
			}
		}
		
		//检验用户名是否可用
		$("#empName_add_input").on('change',function(){
			var _empName = $(this).val();
			console.log(_empName);
			//发送ajax请求
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName=" + _empName,
				type:"post",
				success:function(_res){
					if(_res.code == 100){
						show_validate_msg("#empName_add_input","sucess","用户名可用！");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",_res.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			})
		})
		
		//新增保存
		$("#emp_save_btn").click(function(){
			
			//前端校验
			if(!validate_add_form()){				
				return false;
			}
			//判断之前的ajax用户名的校验是否成功
			if($(this).attr("ajax-va") == "error"){
				return false;
			}
			
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"post",
				data:$('#empAddModal form').serialize(),
				success:function(_res){
					if(_res.msg == 100){
						//alert(_res.msg);
						//1.关闭模态框
						$('#empAddModal').modal('hide');
						//2.跳转最后一页
						//再次发送ajax显示最后一页数据
						to_page(totalRecord);
					}else{
						console.log(_res);
						//显示失败信息
						if(undefined != _res.extend.errorFields.email){
							//显示邮箱错误信息
							show_validate_msg("#email_add_input","error",_res.extend.errorFields.email);
						}
						if(undefined != _res.extend.errorFields.empName){
							//显示员工姓名错误信息
							show_validate_msg("#empName_add_input","error",_res.extend.errorFields.empName);
						}
					}
					
					
				}
			})
		})
		
		//编辑模态框
		$(document).on("click",".edit_btn",function(){
			var id = $(this).parent().siblings('.firstTd').text();
			console.log($(this).parent().siblings('.firstTd').text());
			//1.查出部门信息
			//发送ajax获取下拉列表数据
			getDepts("#dept_update_select");
			//2.查询员工信息
			getEmp(id);
			//传递ID值到更新按钮
			$("#emp_update_btn").attr("edit_id",id);
			//模态框
			$('#empUpdateModal').modal({
				backdrop:"static"
			})
		})
		//单条删除数据
		$(document).on("click",".del_btn",function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).parent().siblings(".firstTd").text();
			console.log(empId);
			//1.弹出是否确认删除对话框
			if(confirm("确认删除【"+empName+"】吗?")){
				//确认触发ajax删除
				$.ajax({
					url:"${APP_PATH}/emp/" + empId,
					type:"delete",
					success:function(_res){
						alert(_res.msg);
						//回到本页
						to_page(currentPage);
					}
				})
			}
		})
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"get",
				success:function(_res){
					console.log(_res);
					var empData = _res.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			})
		}
		//更新按钮
		$("#emp_update_btn").click(function(){
			var id = $(this).attr("edit_id");
			console.log(id);
			//邮箱校验
			//1.校验邮箱信息
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确!");
				show_validate_msg("#email_update_input","error","邮箱格式不正确!");
				return false;				
			}else{
				show_validate_msg("#email_update_input","sucess","");
			}
			//2.发送ajax请求保存更新的员工信息
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"put",
				//data:$('#empUpdateModal form').serialize()+"&_method=PUT",
				data:$('#empUpdateModal form').serialize(),
				success:function(_res){
					//alert(_res.msg);
					//1.关闭模态框
					$('#empUpdateModal').modal("hide");
					//2.回到本页面
					to_page(currentPage);
				}
			})
		})
		//全选功能
		$("#check_all").on("click",function(){
			if($(this).prop("checked")){
				//$(".check_item").prop("checked",$(this).prop("checked"));
				$(".check_item").prop("checked",true);
			}else{
				$(".check_item").prop("checked",false);
			}
		})
		$(document).on("click",".check_item",function(){
			var flag = $(".check_item:checked").length == $(".check_item").length;
			//$("#check_all").prop("checked",flag);
			if(flag){
				$("#check_all").prop("checked",true);
			}else{
				$("#check_all").prop("checked",false);
			}
		})
		//点击全部删除
		$(".emp_delete_all_btn").click(function(){
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			})
			empNames = empNames.substring(0,empNames.length-1);
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			console.log(del_idstr);
			if(confirm("确认删除【"+empNames+"】吗?")){
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/" + del_idstr,
					type:"delete",
					success:function(_res){
						alert(_res.msg);
						//回到本页
						to_page(currentPage);
					}
				})
			}
		})
	</script>
</body>
</html>