<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<c:set var="ctx"
	value="${pageContext.request.contextPath}${fns:getAdminPath()}" />
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户管理</title>
<link
	href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	type="text/css" rel="stylesheet" />

<link rel="stylesheet"
	href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
	type="text/css" />
	<meta name="decorator" content="default" />
<style>
.container-fluid {
	padding-right: 10px;
	padding-left: 10px;
}
</style>
</head>

<body>

	
	<form:form id="userlist" method="post" modelAttribute="sysUser"
		class="form-horizontal" role="form" action="${ctx}/sysmgr/user/query">

		<div class="container-fluid">
			<div class="row-fluid ">
				<div class="row">
					<div class="col-md-12">
						<ul class="nav nav-tabs-title">
			                <li class="active"><span><i class="fa fa-gear"></i>  用户检索</span></li>
			                <li class="buttons">
				                <button type="submit" class="btn btn-warning btn-sm">
								<i class="fa fa-search"></i>&nbsp;&nbsp;查 询
								</button>
								<button type="button" class="btn btn-primary btn-sm">
									<i class="fa fa-bug"></i>&nbsp;&nbsp;清 屏
								</button>
							</li>
			            </ul>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-md-3 form-inline">
						用户名称：<form:input class="input-medium" type="text" path="displayName" />
					</div>
					<div class="col-md-3 form-inline">
						登录名称：<form:input class="input-medium" type="text" path="loginName" />
					</div>
					<div class="col-md-3 form-inline">
                        <li><label>机构名称：</label><sys:treeselect id="officeID" name="officeID" value="${sysUser.officeID}" labelName="officeName" labelValue="${user.officeName}"
                                                                title="机构" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true"/></li>
					</div>
					<div class="col-md-3 form-inline">
                        <li><label>公司名称：</label><sys:treeselect id="companyID" name="companyID" value="${sysUser.companyID}" labelName="companyName" labelValue="${user.companyName}"
                                                                title="公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true"/></li>

					</div>
				</div>
	            <br>
				<div class="row">
					<div class="col-md-3 form-inline">
						组别名称：<form:input class="input-medium" type="text" path="groupName" />
					</div>
					
				</div>
			</div>
		</div>
		<hr>
		<div class="container-fluid">
			<div class="row-fluid ">
				<div class="row">
					
					<div class="col-md-12">
						<ul class="nav nav-tabs-title">
			                <li class="active"><span><i class="fa fa-bars"></i> 检索结果</span></li>
			                <li class="buttons"><a href="${ctx}/sysmgr/user/insert"
							class="btn btn-success btn-sm"><i class="fa fa-th-large"></i>&nbsp;&nbsp;添
								加</a></li>
			            </ul>
					</div>
					
				</div>
				<br>
				<div class="row">
					<table class="table table-bordered table-striped table-hover">
						<thead>
							<tr>
								<th style="text-align:center;">序号</th>
								<th style="text-align:center;">登陆名</th>
								<th style="text-align:center;">用户名</th>
								<th style="text-align:center;">用户类型</th>
								<th style="text-align:center;">状态</th>
								<th style="text-align:center;">生效日期</th>
								<th style="text-align:center;">失效日期</th>
								<th style="text-align:center;">手机</th>
								<th style="text-align:center;">FAX</th>
								<th style="text-align:center;">QQ</th>
								<th style="text-align:center;" hidden="hidden">>租户</th>
								<th style="text-align:center;">公司</th>
								<th style="text-align:center;">组别</th>
								<th style="text-align:center;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${userList}" var="user" varStatus="status">
								<tr>
									<td style="text-align:center">${status.index + 1}</td>
									<td>${user.loginName}</td>
									<td>${user.displayName}</td>
									<td><c:if test="${user.userType=='USER_TYPE01'}">
                                平台用户
                            </c:if> <c:if
											test="${user.userType=='USER_TYPE02'}">
                                租户用户
                            </c:if> <c:if
											test="${user.userType=='USER_TYPE03'}">
                                客户
                            </c:if></td>
									<td style="text-align:center"><c:if test="${user.enabled}">
                                启用
                            </c:if> <c:if test="${not user.enabled}">
                                禁用
                            </c:if></td>
									<td><fmt:formatDate value="${user.startDate}" type="both"
											pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatDate value="${user.endDate}" type="both"
											pattern="yyyy-MM-dd" /></td>
									<td>${user.mobile}</td>
									<td>${user.fax}</td>
									<td>${user.qq}</td>
									<td hidden="hidden">${user.tenantName}</td>
									<td>${user.companyName}</td>
									<td>${user.officeName}</td>

									<td>
										<%-- <sec:authorize ifNotGranted="ROLE_ADMIN">--%> <a
										href="${ctx}/sysmgr/user/modify/${user.uuid}"> <i
											class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;修改
									</a> <a href="${ctx}/sysmgr/userParamsSet/modify?userId=${user.id}">
											<i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;参数
									</a> <a href="javascript:void(0);" id="toggleStatus${user.id}"
										userid="${user.id}"> <c:if test="${user.enabled}">
												<i class="fa fa-ban" aria-hidden="true"></i>&nbsp;禁用
                                    </c:if> <c:if test="${not user.enabled}">
												<i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp;启用
                                    </c:if>
									</a> <%-- </sec:authorize>--%> <a href="javascript:void(0);"
										id="resetPassword${user.id}" userid="${user.id}"
										title="重置密码为88888888,登陆错误计数清零"> <i class="fa fa-repeat"
											aria-hidden="true"></i>&nbsp;重置密码
									</a>
									</td>

								</tr>

							</c:forEach>
						</tbody>
					</table>
					<sys:pagination paginator="${userListPaginator}" formId="userlist" />
				</div>
			</div>
		</div>
		
	</form:form>

	<script type="text/javascript">
	   function addUser(){
	      layer.alert("新增用户");
	   }
	</script>	
</body>
</html>
