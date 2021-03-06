package com.webapps.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public class DateUtil {
	
	public static String SIMPLE_PATTERN = "yyyy-MM-dd";
	
	public static String FULL_PATTERN = "yyyy-MM-dd hh:mm:ss";
	
	public static String format(Date date,String pattern){
		if(date==null){
			return null;
		}
		if(StringUtils.isBlank(pattern)){
			return null;
		}
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		String dateStr = format.format(date);
		return dateStr;
	}
	
	public static Date parseDateByStr(String dateStr,String pattern){
		if(StringUtils.isBlank(dateStr)||StringUtils.isBlank(pattern)){
			return null;
		}
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		Date date = null;
		try {
			date = format.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	
	public static String getSimplePatternCurrentDateStr(){
		SimpleDateFormat format = new SimpleDateFormat(SIMPLE_PATTERN);
		String dateStr = format.format(new Date());
		return dateStr;
	}
	
	public static Date getSimplePatternCurrentDate(){
		SimpleDateFormat format = new SimpleDateFormat(SIMPLE_PATTERN);
		String dateStr = getSimplePatternCurrentDateStr();
		try {
			Date date = format.parse(dateStr);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static String getFullPatternCurrentTimeStr(){
		SimpleDateFormat format = new SimpleDateFormat(FULL_PATTERN);
		String dateStr = format.format(new Date());
		return dateStr;
	}
	
	public static Date getSimplePatternCurrentTime(){
		SimpleDateFormat format = new SimpleDateFormat(FULL_PATTERN);
		String dateStr = getFullPatternCurrentTimeStr();
		try {
			Date date = format.parse(dateStr);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

}
