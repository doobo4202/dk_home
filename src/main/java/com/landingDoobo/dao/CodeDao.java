package com.landingDoobo.dao;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface CodeDao {
    List<Map<String, Object>> selectCodeList();
    List<Map<String, Object>> selectByBigCd(String bigCd);
    int updateCode(Map<String, Object> paramMap);
}
