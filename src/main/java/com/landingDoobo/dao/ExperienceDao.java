package com.landingDoobo.dao;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface ExperienceDao {
    List<Map<String, Object>> selectExpList();
    Map<String, Object> selectExpOne(Map<String, Object> paramMap);
    int insertExp(Map<String, Object> paramMap);
    int updateExp(Map<String, Object> paramMap);
    int deleteExp(Map<String, Object> paramMap);
    int restoreExp(Map<String, Object> paramMap);
}
