package com.landingDoobo.dao;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface FaqDao {
    List<Map<String, Object>> selectFaqList();
    Map<String, Object> selectFaqOne(Map<String, Object> paramMap);
    int insertFaq(Map<String, Object> paramMap);
    int updateFaq(Map<String, Object> paramMap);
    int deleteFaq(Map<String, Object> paramMap);
    int restoreFaq(Map<String, Object> paramMap);
}
