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
@RequestMapping("/admin/devInfo")
@RequiredArgsConstructor
public class DevInfoAdminController {

    private final CodeService codeService;

    @RequestMapping("")
    public String page() { return "/admin/devInfo/devInfoMgmt"; }

    @RequestMapping("/load")
    @ResponseBody
    public Map<String, Object> load() {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            Map<String, String> dev    = codeService.loadByBigCd("20");
            Map<String, String> banner = codeService.loadByBigCd("10");
            returnMap.put("devNm",    dev.getOrDefault("001",""));
            returnMap.put("devPart",  dev.getOrDefault("002",""));
            returnMap.put("devImg",   dev.getOrDefault("003",""));
            returnMap.put("devText",  dev.getOrDefault("004",""));
            returnMap.put("devMsg",   dev.getOrDefault("005",""));
            returnMap.put("devTag",   dev.getOrDefault("006",""));
            returnMap.put("mainText", banner.getOrDefault("002",""));
            returnMap.put("result", "success");
        } catch (Exception e) {
            log.error("devInfo load 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL"); returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }

    @RequestMapping("/save")
    @ResponseBody
    public Map<String, Object> save(@RequestParam Map<String, Object> paramMap) {
        Map<String, Object> returnMap = new HashMap<>();
        try {
            codeService.saveDevInfo(paramMap);
            returnMap.put("result", "success");
            returnMap.put("message", "저장되었습니다.");
        } catch (Exception e) {
            log.error("devInfo save 오류: {}", e.getMessage(), e);
            returnMap.put("result", "FAIL"); returnMap.put("message", e.getMessage());
        }
        return returnMap;
    }
}
