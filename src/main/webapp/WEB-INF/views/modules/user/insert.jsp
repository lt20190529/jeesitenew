<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<link
	href="${pageContext.request.contextPath}/static/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css"
	type="text/css" rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/static/bootstrapvalidator-master/dist/css/bootstrapValidator.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/bootstrap3-dialog-master/css/bootstrap-dialog.min.css" rel="stylesheet">

<link rel="stylesheet"
	href="${ctxStatic}/jquery-easyui/themes/default/easyui.css"
	type="text/css" />
	
	
	

<script src="${pageContext.request.contextPath}/static/bootstrap3-dialog-master//js/bootstrap-dialog.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrapvalidator-master/dist/js/bootstrapValidator.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/bootstrapvalidator-master/dist/js/language/zh_CN.js"></script>
<script
	src="${pageContext.request.contextPath}/static/sinoui/0.5.0/lib/validation/jquery.validate.min.js"></script>

<meta name="decorator" content="default" />
<script type="text/javascript">

	$(function() {
		
		$('#startDate').datetimepicker({
			format : 'yyyy-mm-dd',
			minView : 'month',
			language : 'zh-CN',
			autoclose : true,
			pickerPosition : 'bottom-left', //位置：相对图标而言
			initialDate:new Date(),
			todayHighlight : true //当天高亮显
		}).on("click", function() {
			
		});
		$('#endDate').datetimepicker({
			format : 'yyyy-mm-dd',
			minView : 'month',
			language : 'zh-CN',
			autoclose : true,
			pickerPosition : 'bottom-left', //位置：相对图标而言
			initialDate:new Date(),
			todayHighlight : true //当天高亮显示
		}).on("click", function() {
			
		});

		
		$('#loginName').focus();   //聚焦第一个input

		
		
		//BootStrap表单校验
		$('#userInsert').bootstrapValidator({
	        message: 'This value is not valid',        //验证错误时的信息
	        feedbackIcons: {        //验证时显示的图标
	            //valid: 'glyphicon glyphicon-ok',      //正确图标
	            //invalid: 'glyphicon glyphicon-remove',        //错误图标
	            //validating: 'glyphicon glyphicon-refresh'        //正在更新图标
	        },
	        fields: {       //要验证哪些字段
		            loginName: {        //与表单里input的name属性对应
		                message: 'username is not valid',       //验证错误时的信息，当然这里是可以使用中文的
		                validators: {
		                    notEmpty: {       //非空判断
		                        message: 'The cannot be empty'        //验证错误时的信息，
		                    },
		                    remote: {//ajax验证。server result:{"valid",true or false} 
		                        url: "${ctx}/sysmgr/user/checkLoginName",
		                        message: '用户名已存在,请重新输入',
		                        delay: 2000,//ajax刷新的时间是1秒一次
		                        type: 'POST',
	                        		//自定义提交数据，默认值提交当前input value
		                        data: function() {
		                        		return {
		                        			loginName : $("input[name=loginName]").val(),
		                                   // method : "checkUserName"//UserServlet判断调用方法关键字。
		                             };
		                         }
		                    }
		                }
		            },
		            email: {
		                validators: {
		                    notEmpty: {
		                        message: 'email cannot be empty'
		                    },
		                    emailAddress: {           //是不是正确的email格式
		                        message: 'not a valid email address'             
		                    }
		                }
		            }
	        }
	    });
		
		
		
		//提交
		$('#userInsert').submit(function() {
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			if (startDate>=endDate){
				layer.alert("失效日期要晚于生效日期!");
				return false;
			}
		     
		});

	});
</script>
<style>

.vat {
	vertical-align: top
}

.container-fluid {
	padding-right: 10px;
	padding-left: 10px;
}

.row-fluid {
	padding-right: 30px;
	padding-left: 80px;
}
</style>
</head>

<body>
    <sys:alertbar data="${alertInfo}"/>
	<form:form id="userInsert" method="post" modelAttribute="sysUser"
		class="form-horizontal" role="form" action="${ctx}/sysmgr/user/insert">
		<div class="container-fluid">
			<div class="row-fluid ">
				<div class="row">
					<div class="col-md-5">
						<h4>
							<span class="glyphicon glyphicon-plus-sign">&nbsp;新增用户</span>
						</h4>
					</div>
				</div>

				<hr>


				<div class="col-md-4 form-inline">
					<label class="col-sm-4">登录名：</label>
					<div class="col-sm-8">
						<form:input path="loginName" class="" required="true" />
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户名：</label>
					<div class="col-sm-8">
						<form:input path="displayName" class="" required="true" />
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户编码：</label>
					<div class="col-sm-8">
						<form:input path="employeeNumber" class="" required="true" />
					</div>
				</div>

				<br> <br>
				<br>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">Email：</label>
					<div class="col-sm-8">
						<form:input path="email" class="" required="true" />
					</div>
				</div>



				<div class="col-md-4 form-inline">
					<label class="col-sm-4">办公电话：</label>
					<div class="col-sm-8">
						<form:input path="officeTel" class="" />
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">手机：</label>
					<div class="col-sm-8">
						<form:input path="mobile" class=""/>
					</div>
				</div>

				<br> <br>
				<br>
	


				<div class="col-md-4 form-inline">
					<label class="col-sm-4">QQ：</label>
					<div class="col-sm-8">
						<form:input path="qq" class=""/>
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">传真：</label>
					<div class="col-sm-8">
						<form:input path="fax" class="" />
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">用户类型：</label>
					<div class="col-sm-8">
						<select id="userType" name="userType"
							style="width:210px;height:26.96px">

							<c:forEach items="${USER_TYPE}" var="ut">
								<option value="${ut.code}">${ut.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>


				<br> <br>
				<br>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">生效日期：</label>
					<div class="col-sm-8">
						<div class='input-group date'>
							<form:input path="startDate"  class="form-control" required="true"
								style="width:170px;height:26.96px" /> <span
								class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>



				<div class="col-md-4 form-inline">
					<label class="col-sm-4">失效日期：</label>
					<div class="col-sm-8">
						<div class='input-group date'>
							<form:input path="endDate" class="form-control" required="true"
								style="width:170px;height:26.96px" /> <span
								class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>

				<div class="col-md-4 form-inline">
					<label class="col-sm-4">是否有效：</label>
					<div class="col-sm-8">
						<form:radiobuttons path="enabled" items="${userStatus}"
							delimiter="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
							labelCssClass="radio-inline" />
					</div>
				</div>

				<br> <br>
				<br>
               
				<hr>


				<div class="col-md-4 form-inline">
					<label class="col-sm-4">所属公司：</label>
					<div class="col-sm-8">
						<div class='input-group date' id='companyD'>
							</label>
							<sys:treeselect id="company" name="company.id"
								value="${user.office.id}" labelName="company.name"
								labelValue="${user.office.name}" title="组别"
								url="/sys/office/treeData?type=1" cssClass="input-large"
								hideBtn="true" smallBtn="true" allowClear="true"
								notAllowSelectParent="true" />

						</div>
					</div>
				</div>



				<div class="col-md-4 form-inline">
					<label class="col-sm-4">所属组别：</label>
					<div class="col-sm-8">
						<div class='input-group date' id='officeD'>
							</label>
							<sys:treeselect id="office" name="office.id"
								value="${user.office.id}" labelName="office.name"
								labelValue="${user.office.name}" title="组别"
								url="/sys/office/treeData?type=2" cssClass="input-large"
								hideBtn="true" smallBtn="true" allowClear="true"
								notAllowSelectParent="true" />

						</div>
					</div>
				</div>

				<br> <br>

				<hr>
				<div class="col-md-12 form-inline">
					<label class="col-sm-1">角色：</label>
					<div class="col-sm-10 col-md-offset-0 text-left " style="">
						<c:forEach items="${roleList}" var="roleList" varStatus="status">
							<label style="vertical-align:middle;padding:0px 20px 0px 20px">
								<input id=${roleList.id } name="roleList" type="checkbox"
								class="vertical-align:middle" style="zoom:140%;"
								value=${roleList.id }>${roleList.name}
							</label>
						</c:forEach>
					</div>
				</div>

				<br>

				<hr>


				<div class="col-xs-12 col-sm-12 col-md-12">
					<div class="form-group sino-form-group-btn col-md-offset-0">
						<button type="submit" class="btn btn-warning col-md-offset-8">
							<i class="fa fa-floppy-o "></i>保 存
						</button>
						<a type="button" href="${ctx}/sysmgr/user/list?page=1"
							class="btn btn-default"><i class="fa fa-undo"></i>返回列表</a>
					</div>
				</div>

			</div>


		</div>
	</form:form>

</body>
</html>
