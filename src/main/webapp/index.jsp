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
<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css">
<script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.8.3.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary btn-sm">新增</button>
				<button class="btn btn-danger btn-sm">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
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
		var maxPage;
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
		console.log(maxPage)
		function build_emps_table(_res){
			//清空table内容
			$("#emps_table tbody").empty();
			var emps = _res.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var ediBtn = $("<button></button>").addClass("btn btn-primary btn-sm").append("编辑");
				var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm").append("删除");
				var btnTd = $("<td></td>").append(ediBtn).append(delBtn);
				$('<tr></tr>').append(empIdTd)
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
		}
		//解析显示分页条
		/*<nav aria-label="Page navigation">
			  <ul class="pagination">
			  
			  		<li class="disabled"><a href="${APP_PATH}/emps?pn=1">首页</a></li>
			  
			  		<li ><a href="${APP_PATH}/emps?pn=1">首页</a></li>
			  
				  	<li>
				      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
			  
			    		<li class="active"><a href="#">${page_num }</a></li>	
			    
			    		<li ><a href="${APP_PATH}/emps?pn=${page_num }">${page_num }</a></li>
			   
			    	 <li>
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
			    	</li>
			    
			   
			   	
			   		 <li class="disabled"><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
			   
			   		<li ><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
		
			   		"+ empsInfo.pageNum + 1 +"       "+ empsInfo.pageNum - 1 +"
			  </ul>
		</nav>*/
		function build_page_nav(_res){
			var _html = "";
			var empsInfo =  _res.extend.pageInfo;
			var emps = _res.extend.pageInfo.navigatepageNums;
			var _nav = "<nav aria-label='Page navigation'>";
			var _ul = "<ul class='pagination'>"
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
					}
				})
			}
			
		}
		//最大值禁触发ajax
		//function maxDisable(num){
			//var maxPage = _res.extend.pageInfo.pages;

		//}
		
	</script>
</body>
</html>