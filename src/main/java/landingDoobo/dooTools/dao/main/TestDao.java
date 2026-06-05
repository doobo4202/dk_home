package landingDoobo.dooTools.dao.main;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TestDao {

	String selectString();
	
	Map<String, Object> selectList(Map<String, Object> requestMap);
	
	List<Map<String, Object>> selectArray(Map<String, Object> requestMap);
}
