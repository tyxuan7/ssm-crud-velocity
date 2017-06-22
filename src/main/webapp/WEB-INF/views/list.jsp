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
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>depiName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender == "M" ? "男" : "女"}</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-primary btn-sm">编辑</button>
								<button class="btn btn-danger btn-sm">删除</button>
							</td>
						</tr>
					</c:forEach>
					
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				当前${pageInfo.pageNum }页,总${pageInfo.pages }页,总${pageInfo.total }条记录
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					  <ul class="pagination">
					  	<c:if test="${pageInfo.pageNum == 1 }">
					  		<li class="disabled"><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					  	</c:if>
					  	<c:if test="${pageInfo.pageNum != 1 }">
					  		<li ><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					  	</c:if>
					  	<c:if test="${pageInfo.hasPreviousPage }">
						  	<li>
						      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
					  	</c:if>					  						   
					    <c:forEach items="${pageInfo.navigatepageNums }" var="page_num">
					    	<c:if test="${page_num == pageInfo.pageNum}">
					    		<li class="active"><a href="#">${page_num }</a></li>	
					    	</c:if>
					    	<c:if test="${page_num != pageInfo.pageNum}">
					    		<li ><a href="${APP_PATH}/emps?pn=${page_num }">${page_num }</a></li>
					    	</c:if>				    
					    </c:forEach>
					    <c:if test="${pageInfo.hasNextPage }">
					    	 <li>
							      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
							        <span aria-hidden="true">&raquo;</span>
							      </a>
					    	</li>
					    </c:if>
					   
					   	<c:if test="${pageInfo.isLastPage ==true }">
					   		 <li class="disabled"><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
					   	</c:if>
					   	<c:if test="${pageInfo.isLastPage ==false }">
					   		<li ><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
					   	</c:if>
					    
					  </ul>
				</nav>
			</div>
		</div>
		<div class="row"></div>
	</div>
</body>
</html>