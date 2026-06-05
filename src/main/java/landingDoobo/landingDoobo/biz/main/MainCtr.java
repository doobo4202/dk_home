package landingDoobo.landingDoobo.biz.main;

import landingDoobo.dooTools.biz.main.TestSvc;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class MainCtr {

    @Autowired
    MainSvc mainSvc;

    @RequestMapping("/ld/mainPage")
    public String mainPage() {

        String page = "/landingDoobo/main/mainPage";

        return page;
    }

    @RequestMapping("/ld/main/schBaseMain")
    public @ResponseBody Map<String, Object> schBaseMain(@RequestParam Map<String, Object> requestMap) {
        Map<String, Object> returnMap = new HashMap<String, Object>();

        try {
            // 메인 정보 조회
            Map<String, Object> bannerInfo = mainSvc.selectOneMainBanner();

            // 개발자 정보 조회
            Map<String, Object> devInfo = mainSvc.selectOneDevInfo();

            // 경력 정보 조회
            List<Map<String, Object>> expList = mainSvc.selectListExp();

            // 경력 정보 조회
            List<Map<String, Object>> projectList = mainSvc.selectListProject();

            // FAQ 정보 조회
            List<Map<String, Object>> faqList = mainSvc.selectListfaq();
            
            // 연락처 정보 조회
            Map<String, Object> contectInfo = mainSvc.selectOneContectInfo();

            returnMap.put("bannerInfo", bannerInfo);
            returnMap.put("devInfo", devInfo);
            returnMap.put("expList", expList);
            returnMap.put("projectList", projectList);
            returnMap.put("faqList", faqList);
            returnMap.put("contectInfo", contectInfo);

            returnMap.put("result", "success");
            returnMap.put("message", "성공");
        }catch (Exception e) {
            log.error("▶▶ schBaseMain API 호출 중 오류 발생 : {}", e.getMessage(), e);

            returnMap.put("result", "FAIL");
            returnMap.put("message", "처리 중 오류가 발생했습니다.");
        }

        return returnMap;
    }

    @RequestMapping("/project/projectDetail")
    public ModelAndView projectDetailPage(@RequestParam Map<String, Object> requestMap) {
        Map<String, Object> paramMap = requestMap;
        ModelAndView model = new ModelAndView();

        try {
            model.setViewName("/landingDoobo/main/projectDetail");
            model.addObject("seq", paramMap.get("seq"));
        }catch (Exception ignored) {

        }

        return model;
    }

    @RequestMapping("/project/schProjectDetail")
    public @ResponseBody Map<String, Object> schProjectDetail(@RequestParam Map<String, Object> requestMap) {
        Map<String, Object> returnMap = new HashMap<String, Object>();
        Map<String, Object> paramMap = requestMap;

        try {
            // 프로젝트 상세 조회
            Map<String, Object> detail = mainSvc.selectOneProjectDetail(paramMap);
            returnMap.put("detail", detail);

            returnMap.put("result", "success");
            returnMap.put("message", "성공");
        }catch (Exception e) {
            log.error("▶▶ schBaseMain API 호출 중 오류 발생 : {}", e.getMessage(), e);

            returnMap.put("result", "FAIL");
            returnMap.put("message", "처리 중 오류가 발생했습니다.");
        }

        return returnMap;
    }
}

