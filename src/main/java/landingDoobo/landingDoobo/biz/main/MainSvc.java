package landingDoobo.landingDoobo.biz.main;

import landingDoobo.landingDoobo.dao.main.MainDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("mainSvc")
public class MainSvc {

    @Resource
    private MainDao mainDao;

    public Map<String, Object> selectOneMainBanner() {
        return mainDao.selectOneMainBanner();
    }

    public Map<String, Object> selectOneDevInfo() {
        return mainDao.selectOneDevInfo();
    }

    public List<Map<String, Object>> selectListExp() {
        return mainDao.selectListExp();
    }

    public List<Map<String, Object>> selectListProject() {
        return mainDao.selectListProject();
    }

    public List<Map<String, Object>> selectListfaq() {
        return mainDao.selectListfaq();
    }

    public Map<String, Object> selectOneContectInfo() {
        return mainDao.selectOneContectInfo();
    }

    public Map<String, Object> selectOneProjectDetail(Map<String, Object> paramMap) {
        return mainDao.selectOneProjectDetail(paramMap);
    }
}
