package com.landingDoobo.service;

import com.landingDoobo.dao.MainDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MainService {

    private final MainDao mainDao;

    public Map<String, Object> selectOneMainBanner() { return mainDao.selectOneMainBanner(); }
    public Map<String, Object> selectOneDevInfo() { return mainDao.selectOneDevInfo(); }
    public List<Map<String, Object>> selectListExp() { return mainDao.selectListExp(); }
    public List<Map<String, Object>> selectListProject() { return mainDao.selectListProject(); }
    public List<Map<String, Object>> selectListFaq() { return mainDao.selectListFaq(); }
    public Map<String, Object> selectOneContectInfo() { return mainDao.selectOneContectInfo(); }
    public Map<String, Object> selectOneProjectDetail(Map<String, Object> paramMap) {
        return mainDao.selectOneProjectDetail(paramMap);
    }
}
