package com.landingDoobo.controller.admin;

import com.landingDoobo.service.CodeService;
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
@RequestMapping("/admin/code")
@RequiredArgsConstructor
public class CodeAdminController {

    private final CodeService codeService;

    @RequestMapping("")
    public String page() {
        return "/admin/code/codeMgmt";
    }

    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list() {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            returnMap.put("list", codeService.selectCodeList());
            returnMap.put("result", "success");
        } catch (Exception e) {
            log.error("code list 오류: {}", e.getMessage(), e);
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
            codeService.updateCode(paramMap);
            returnMap.put("result", "success");
            returnMap.put("message", "저장되었습니다.");
        } catch (Exception e) {
            log.error("code save 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL");
            returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }
}
