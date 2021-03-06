package com.webapps.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
import com.webapps.common.bean.Page;
import com.webapps.common.bean.ResultDto;
import com.webapps.common.entity.User;
import com.webapps.common.form.UserRequestForm;
import com.webapps.common.utils.PasswordEncryptUtil;
import com.webapps.mapper.IUserMapper;
import com.webapps.service.IUserService;

@Service
@Transactional
public class UserServiceImpl implements IUserService {
	
	private static Logger logger = Logger.getLogger(UserServiceImpl.class);
	
	@Autowired
	private IUserMapper iUserMapper;

	@Override
	public Page loadUserList(Page page,UserRequestForm user) throws Exception {
		int startRow = page.getStartRow();
		int endRow = page.getEndRow();
		int count = iUserMapper.queryCount(user);
		List<User> list = iUserMapper.queryPage(startRow, endRow, user);
		page.setResultList(list);
		page.setRecords(count);
		return page;
	}

	@Override
	public User login(User user) throws Exception {
		String account = user.getAccount();
		User user1 = iUserMapper.queryUserByAccount(account);
		String tempPwd = user.getPassword();
		String salt = user1.getToken();
		if(user1!=null){
			boolean flag = PasswordEncryptUtil.authenticate(tempPwd, user1.getPassword(),salt);
			if(flag){
				return user1;
			}
		}
		return null;
	}

	@Override
	public int insert(User user) throws Exception {
		int result = iUserMapper.insert( user);
		return result;
	}

	@Override
	public ResultDto<User> saveUser(User user) throws Exception {
		ResultDto<User> dto = new ResultDto<User>();
		dto.setResult("success");
		if(user.getId()!=null){
			iUserMapper.updateById(user.getId(), user);
			dto.setData(user);
			return dto;
		}else{
			String password = user.getPassword();
			String token = PasswordEncryptUtil.generateSalt();
			user.setToken(token);
			String encryptPwd = PasswordEncryptUtil.getEncryptedPassword(password, token);
			user.setPassword(encryptPwd);
			try {
				int result = iUserMapper.insert(user);
				if(result==0){
					dto.setData(user);
					dto.setResult("fail");
					dto.setErrorMsg("新增失败");
					return dto;
				}
			} catch (DuplicateKeyException e) {
				logger.error(e.getMessage());
				dto.setData(user);
				dto.setResult("fail");
				dto.setErrorMsg("该账号已被注册，请更换重试");
				return dto;
			}
		}
		return dto;
	}

	@Override
	public User getById(Integer id) throws Exception {
		User user = iUserMapper.getById(id);
		return user;
	}

	@Override
	public ResultDto<User> deleteUserById(Integer id) throws Exception {
		iUserMapper.deleteById(id);
		ResultDto<User> dto = new ResultDto<User>();
		dto.setResult("success");
		return dto;
	}
	
	
	
}
