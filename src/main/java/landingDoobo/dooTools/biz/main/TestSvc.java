package landingDoobo.dooTools.biz.main;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import landingDoobo.dooTools.dao.main.TestDao;

@Service("testSvc")
public class TestSvc {

	@Resource
    private TestDao testDao;
	
	public String selectString() {
		return testDao.selectString();
	}
	
	public  Map<String, Object> selectList(Map<String, Object> requestMap) {
		return testDao.selectList(requestMap);
	}
	
	public  List<Map<String, Object>> selectArray(Map<String, Object> requestMap) {
		return testDao.selectArray(requestMap);
	}
}
