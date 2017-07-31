package com.webapps.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.webapps.common.entity.Province;
import com.webapps.common.entity.User;
import com.webapps.common.form.ProvinceRequestForm;

/**
 * Created by xieshuai on 2017-6-28.
 */
public interface IProvinceMapper extends IBaseMapper<User>{
	
	public int queryCount(@Param("province")ProvinceRequestForm province);
	
	public List<Province> queryProvinceList(@Param("startRow")int startRow,@Param("endRow")int endRow,@Param("Province")ProvinceRequestForm province);
	
	public List<Province> queryAll();
	
	public Province queryProvinceByName(String name);
	
	public Province getProvinceByCode(String code);
	
	public int batchUpdate(List<Province> list);

}