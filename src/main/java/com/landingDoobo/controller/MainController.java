package com.landingDoobo.controller;

import com.landingDoobo.service.MainService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MainController {

    private final MainService mainService;

    @RequestMapping("/")
    public String index() {
        return "redirect:/ld/mainPage";
    }

    @RequestMapping("/ld/mainPage")
    public String mainPage() {
        return "/landingDoobo/main/mainPage";
    }

    @RequestMapping("/ld/main/schBaseMain")
    @ResponseBody
    public Map<String, Object> schBaseMain(@RequestParam Map<String, Object> requestMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            returnMap.put("bannerInfo", mainService.selectOneMainBanner());
            returnMap.put("devInfo", mainService.selectOneDevInfo());
            returnMap.put("expList", mainService.selectListExp());
            returnMap.put("projectList", mainService.selectListProject());
            returnMap.put("faqList", mainService.selectListFaq());
            returnMap.put("contectInfo", mainService.selectOneContectInfo());
            returnMap.put("result", "success");
            returnMap.put("message", "성공");
        } catch (Exception e) {
            log.error("schBaseMain 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL");
            returnMap.put("message", "처리 중 오류가 발생했습니다.");
        }
        return returnMap;
    }

    @RequestMapping("/project/projectDetail")
    public ModelAndView projectDetailPage(@RequestParam Map<String, Object> requestMap) {
        ModelAndView model = new ModelAndView("/landingDoobo/main/projectDetail");
        model.addObject("seq", requestMap.get("seq"));
        return model;
    }

    @RequestMapping("/project/schProjectDetail")
    @ResponseBody
    public Map<String, Object> schProjectDetail(@RequestParam Map<String, Object> requestMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            returnMap.put("detail", mainService.selectOneProjectDetail(requestMap));
            returnMap.put("result", "success");
            returnMap.put("message", "성공");
        } catch (Exception e) {
            log.error("schProjectDetail 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL");
            returnMap.put("message", "처리 중 오류가 발생했습니다.");
        }
        return returnMap;
    }
}
