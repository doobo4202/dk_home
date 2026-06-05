package com.landingDoobo.controller.admin;

import com.landingDoobo.service.FaqService;
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
@RequestMapping("/admin/faq")
@RequiredArgsConstructor
public class FaqAdminController {

    private final FaqService faqService;

    @RequestMapping("")
    public String page() {
        return "/admin/faq/faqMgmt";
    }

    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list() {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            returnMap.put("list", faqService.selectFaqList());
            returnMap.put("result", "success");
        } catch (Exception e) {
            log.error("faq list 오류: {}", e.getMessage(), e);
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
            returnMap.put("detail", faqService.selectFaqOne(paramMap));
            returnMap.put("result", "success");
        } catch (Exception e) {
            log.error("faq detail 오류: {}", e.getMessage(), e);
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
            faqService.saveFaq(paramMap);
            returnMap.put("result", "success");
            returnMap.put("message", "저장되었습니다.");
        } catch (Exception e) {
            log.error("faq save 오류: {}", e.getMessage(), e);
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
            faqService.deleteFaq(paramMap);
            returnMap.put("result", "success"); returnMap.put("message", "삭제되었습니다.");
        } catch (Exception e) {
            log.error("faq delete 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL"); returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }

    @RequestMapping("/restore")
    @ResponseBody
    public Map<String, Object> restore(@RequestParam Map<String, Object> paramMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            faqService.restoreFaq(paramMap);
            returnMap.put("result", "success"); returnMap.put("message", "복원되었습니다.");
        } catch (Exception e) {
            log.error("faq restore 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL"); returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }
}
