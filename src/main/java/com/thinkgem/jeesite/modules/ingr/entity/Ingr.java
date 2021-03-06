/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ingr.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 入库Entity
 * @author lxt
 * @version 2018-07-26
 */
public class Ingr extends DataEntity<Ingr> {

	private static final long serialVersionUID = 1L;
	private String ingrid;
	private String no;		// 单据编号
	private String depid;		// dep
	private String depdesc;
	private ErpVendor vendor;		// 供货商

	private BigDecimal  amtrp;	//进价金额
	private BigDecimal  amtsp;	//售价金额
	private User auditBy;  	// 审核人
	private Date auditDate;	// 更新日期
	private String auditFlag; 	// 审核标志（已审:Y  未审：N）

	private List<IngrDetail> ingrDetailList;		// 子表列表

	public Ingr() {
		super();
	}

	public Ingr(String id){
		super(id);
	}

	public String getIngrid() {
		return ingrid;
	}

	public void setIngrid(String ingrid) {
		this.ingrid = ingrid;
	}

	@Length(min=0, max=50, message="单据编号长度必须介于 0 和 50 之间")
	@ExcelField(title="单据编号", align=0, sort=1)
	
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	
	@ExcelField(title="进价金额", align=1, sort=4)
	public BigDecimal getAmtrp() {
		return amtrp;
	}

	public void setAmtrp(BigDecimal amtrp) {
		this.amtrp = amtrp;
	}
    
	@ExcelField(title="售价金额", align=1, sort=5)
	public BigDecimal getAmtsp() {
		return amtsp;
	}

	public void setAmtsp(BigDecimal amtsp) {
		this.amtsp = amtsp;
	}
	@ExcelField(value="auditBy.name",title="审核人", align=2, sort=6)
	public User getAuditBy() {
		return auditBy;
	}

	public void setAuditBy(User auditBy) {
		this.auditBy = auditBy;
	}

	public Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}

	public String getAuditFlag() {
		return auditFlag;
	}

	public void setAuditFlag(String auditFlag) {
		this.auditFlag = auditFlag;
	}

	public List<IngrDetail> getIngrDetailList() {
		return ingrDetailList;
	}

	public void setIngrDetailList(List<IngrDetail> ingrDetailList) {
		this.ingrDetailList = ingrDetailList;
	}

	public String getDepid() {
		return depid;
	}

	public void setDepid(String depid) {
		this.depid = depid;
	}

	//@ExcelField(value="dep.departmentDesc",title="部门", align=0, sort=2)
	@ExcelField(title="部门", align=0, sort=2)
	public String getDepdesc() {
		return depdesc;
	}

	public void setDepdesc(String depdesc) {
		this.depdesc = depdesc;
	}

	@ExcelField(title="供货商", align=0, sort=3)
	public ErpVendor getVendor() {
		return vendor;
	}

	public void setVendor(ErpVendor vendor) {
		this.vendor = vendor;
	}


	@Override
	public String toString() {
		return "Ingr{" +
				"ingrid='" + ingrid + '\'' +
				", no='" + no + '\'' +
				", depid='" + depid + '\'' +
				", depdesc='" + depdesc + '\'' +
				", vendor=" + vendor +
				", amtrp=" + amtrp +
				", amtsp=" + amtsp +
				", auditBy=" + auditBy +
				", auditDate=" + auditDate +
				", auditFlag='" + auditFlag + '\'' +
				", ingrDetailList=" + ingrDetailList +
				'}';
	}
}