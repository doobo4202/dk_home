package landingDoobo.dooTools.biz.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TestCtr {
	
	@Resource
    private TestSvc testSvc;

	@RequestMapping("/dooTools/mainPage")
	public String mainPage() {
	
		String Page = "/dooTools/main/mainPage";
		
		return Page;
	}
	
	@RequestMapping("/dooTools/mvcTester")
	public String text() {
		
		String page = "/main/" + testSvc.selectString();
		
		return page;
	}
	
	@RequestMapping("/dooTools/mvcTester/selectMap")
	public @ResponseBody Map<String, Object> selectList(@RequestParam Map<String, Object> requestMap) {
		log.info("시작~~~!");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> selectList = new HashMap<String, Object>();
		
		log.info("requestMap : " + requestMap);
		
		selectList = testSvc.selectList(requestMap);
		returnMap.put("testMap", selectList);
		
		log.info("returnMap : " + selectList);
		
		return returnMap;
	}
	
	@RequestMapping("/dooTools/mvcTester/selectList")
	public @ResponseBody Map<String, Object> selectArray(@RequestParam Map<String, Object> requestMap) {
		log.info("시작~~~!");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> selectList = new ArrayList<Map<String, Object>>();
		
		log.info("requestMap : " + requestMap);

		selectList = testSvc.selectArray(requestMap);
		returnMap.put("selectList", selectList);
		
		log.info("selectList : " + selectList);
		
		return returnMap;
	}
}
