package com.landingDoobo.service;

import com.landingDoobo.dao.ProjectDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ProjectService {

    private final ProjectDao projectDao;

    public List<Map<String, Object>> selectProjectList() { return projectDao.selectProjectList(); }
    public Map<String, Object> selectProjectOne(Map<String, Object> p) { return projectDao.selectProjectOne(p); }
    public int saveProject(Map<String, Object> p) {
        if (p.get("seq") != null && !p.get("seq").toString().isEmpty()) return projectDao.updateProject(p);
        return projectDao.insertProject(p);
    }
    public int deleteProject(Map<String, Object> p)  { return projectDao.deleteProject(p); }
    public int restoreProject(Map<String, Object> p) { return projectDao.restoreProject(p); }
}
