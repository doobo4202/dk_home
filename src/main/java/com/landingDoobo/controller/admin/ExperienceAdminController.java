package com.landingDoobo.controller.admin;

import com.landingDoobo.service.ExperienceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/admin/experience")
@RequiredArgsConstructor
public class ExperienceAdminController {

    private final ExperienceService experienceService;

    @RequestMapping("")
    public String page() {
        return "/admin/experience/expMgmt";
    }

    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list() {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            returnMap.put("list", experienceService.selectExpList());
            returnMap.put("result", "success");
        } catch (Exception e) {
            log.error("exp list 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL");
            returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }

    @RequestMapping("/detail")
    @ResponseBody
    public Map<String, Object> detail(@RequestParam Map<String, Object> paramMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            returnMap.put("detail", experienceService.selectExpOne(paramMap));
            returnMap.put("result", "success");
        } catch (Exception e) {
            log.error("exp detail 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL");
            returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }

    @RequestMapping("/save")
    @ResponseBody
    public Map<String, Object> save(@RequestParam Map<String, Object> paramMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            experienceService.saveExp(paramMap);
            returnMap.put("result", "success");
            returnMap.put("message", "저장되었습니다.");
        } catch (Exception e) {
            log.error("exp save 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL");
            returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map<String, Object> delete(@RequestParam Map<String, Object> paramMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            experienceService.deleteExp(paramMap);
            returnMap.put("result", "success");
            returnMap.put("message", "삭제되었습니다.");
        } catch (Exception e) {
            log.error("exp delete 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL"); returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }

    @RequestMapping("/restore")
    @ResponseBody
    public Map<String, Object> restore(@RequestParam Map<String, Object> paramMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            experienceService.restoreExp(paramMap);
            returnMap.put("result", "success");
            returnMap.put("message", "복원되었습니다.");
        } catch (Exception e) {
            log.error("exp restore 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL"); returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }
}
