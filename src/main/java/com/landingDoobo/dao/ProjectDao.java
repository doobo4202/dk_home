package com.landingDoobo.dao;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface ProjectDao {
    List<Map<String, Object>> selectProjectList();
    Map<String, Object> selectProjectOne(Map<String, Object> paramMap);
    int insertProject(Map<String, Object> paramMap);
    int updateProject(Map<String, Object> paramMap);
    int deleteProject(Map<String, Object> paramMap);
    int restoreProject(Map<String, Object> paramMap);
}
