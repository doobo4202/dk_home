package com.landingDoobo.controller.admin;

import com.landingDoobo.service.CodeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/admin/contact")
@RequiredArgsConstructor
public class ContactAdminController {

    private final CodeService codeService;

    @RequestMapping("")
    public String page() { return "/admin/contact/contactMgmt"; }

    @RequestMapping("/load")
    @ResponseBody
    public Map<String, Object> load() {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            Map<String, String> c = codeService.loadByBigCd("30");
            returnMap.put("contactMail", c.getOrDefault("001",""));
            returnMap.put("contactCall", c.getOrDefault("002",""));
            returnMap.put("contactTalk", c.getOrDefault("003",""));
            returnMap.put("result", "success");
        } catch (Exception e) {
            log.error("contact load 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL"); returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }

    @RequestMapping("/save")
    @ResponseBody
    public Map<String, Object> save(@RequestParam Map<String, Object> paramMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            codeService.saveContact(paramMap);
            returnMap.put("result", "success");
            returnMap.put("message", "저장되었습니다.");
        } catch (Exception e) {
            log.error("contact save 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL"); returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }
}
