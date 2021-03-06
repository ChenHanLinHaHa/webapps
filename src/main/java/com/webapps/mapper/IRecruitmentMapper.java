package com.webapps.mapper;

import java.util.List;

import com.webapps.common.entity.Province;
import com.webapps.common.entity.Recruitment;
import com.webapps.common.form.RecruitmentRequestForm;

/**
 * Created by xieshuai on 2017-6-28.
 */
public interface IRecruitmentMapper extends IBaseMapper<Recruitment>,IPageMapper<Recruitment,RecruitmentRequestForm>{
	
	public Province getByCode(String code);
	
	public List<Recruitment> queryByCompanyId(Integer companyId);

}
