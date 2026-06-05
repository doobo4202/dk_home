package com.landingDoobo.service;

import com.landingDoobo.dao.ExperienceDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ExperienceService {

    private final ExperienceDao experienceDao;

    public List<Map<String, Object>> selectExpList() { return experienceDao.selectExpList(); }
    public Map<String, Object> selectExpOne(Map<String, Object> p) { return experienceDao.selectExpOne(p); }
    public int saveExp(Map<String, Object> p) {
        if (p.get("seq") != null && !p.get("seq").toString().isEmpty()) return experienceDao.updateExp(p);
        return experienceDao.insertExp(p);
    }
    public int deleteExp(Map<String, Object> p)  { return experienceDao.deleteExp(p); }
    public int restoreExp(Map<String, Object> p) { return experienceDao.restoreExp(p); }
}
