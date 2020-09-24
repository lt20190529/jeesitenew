/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecDao;
import com.thinkgem.jeesite.modules.rec.dao.ErpRecDetailDao;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 入库Service
 * @author lxt
 * @version 2018-07-26
 */
@Service
@Transactional(readOnly = true)
public class ErpRecService extends CrudService<ErpRecDao, ErpRec> {


	
	@Autowired
	private ErpRecDao erpRecDao;

	@Autowired
	private ErpRecDetailDao erpRecDetailDao;
	
	public ErpRec get(String id) {
		ErpRec erpRec = erpRecDao.findErpRecById(id);
		erpRec.setErpRecDetailList(erpRecDetailDao.findErpRecdetailListByRecId(id));

		return erpRec;
	}
	
	public Page<ErpRec> findPage(Page<ErpRec> page, ErpRec erpRec) {
		erpRec.setPage(page);
		page.setList(erpRecDao.findList(erpRec));
		return page;
	}
	
	//获取入库最大编码
	@Transactional(readOnly = false)
	public String GetMaxNo(Map<String,Object> map) {
			return erpRecDao.GetMaxNo(map);
	}
	
	//保存入库信息
	@Transactional(readOnly = false)
	public void save(ErpRec erpRec) {
		erpRec.setAuditFlag("N"); //审核标志
        super.save(erpRec);                                                     //保存主表信息，根据是entity.getIsNewRecord()否是新纪录执行insert 或者  update
		for (ErpRecDetail erpRecDetail : erpRec.getErpRecDetailList()){         //循环处理子表信息
			if (erpRecDetail.getId() == null){
				continue;
			}
			if (StringUtils.isBlank(erpRecDetail.getId())){
				erpRecDetail.setIsNewRecord(false);
				erpRecDetail.setRecid(erpRec.getId());
				//erpRecDetail.setId(IdGen.uuid());
                erpRecDetail.preInsert();
				erpRecDetailDao.insertE(erpRecDetail);
			}else{
                erpRecDetail.setRecid(erpRec.getId());
				erpRecDetail.preUpdate();
				erpRecDetailDao.updateE(erpRecDetail);
			}
            //erpRecDetail.setRecid(erpRec.getId());
			//erpRecDetail.setSubid(Integer.parseInt(erpRecDetail.getId()));
            //erpRecDetail.preInsert();                                      //调用基类中记录创建人createruser 创建日期createrdata等字段
			//erpRecDetailDao.insertE(erpRecDetail);
		}
	}
	
	public List<ErpRecDetail> findErpRecdetailListByRecId(String id) {
		return erpRecDetailDao.findErpRecdetailListByRecId(id);
	}
	
	@Transactional(readOnly = false)
	public void deleteE(String detailid) {
		erpRecDetailDao.deleteE(detailid);
	}
	
	@Transactional(readOnly = false)
	public void delete(ErpRec erpRec) {
		super.delete(erpRec);
		erpRecDetailDao.delete(new ErpRecDetail());
	}
	//入库审核过程
	@Transactional(readOnly = false)
	public String AuditRecById(Map<String,Object> map) {
			return erpRecDao.AuditRecById(map);
	}
	
	
	
}