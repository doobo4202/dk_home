package com.landingDoobo.dao;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface MainDao {
    Map<String, Object> selectOneMainBanner();
    Map<String, Object> selectOneDevInfo();
    List<Map<String, Object>> selectListExp();
    List<Map<String, Object>> selectListProject();
    List<Map<String, Object>> selectListFaq();
    Map<String, Object> selectOneContectInfo();
    Map<String, Object> selectOneProjectDetail(Map<String, Object> paramMap);
}
