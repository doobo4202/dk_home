package com.landingDoobo.service;

import com.landingDoobo.dao.CodeDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CodeService {

    private final CodeDao codeDao;

    public List<Map<String, Object>> selectCodeList() { return codeDao.selectCodeList(); }
    public int updateCode(Map<String, Object> paramMap) { return codeDao.updateCode(paramMap); }

    /** C_BIG_CD 기준으로 코드 목록을 {소분류코드 → 값} 맵으로 변환 */
    public Map<String, String> loadByBigCd(String bigCd) {
        List<Map<String, Object>> list = codeDao.selectByBigCd(bigCd);
        Map<String, String> result = new HashMap<>();
        for (Map<String, Object> row : list) {
            String smallCd = String.valueOf(row.get("C_SMALL_CD"));
            String value   = row.get("S_VALUE") != null ? String.valueOf(row.get("S_VALUE")) : "";
            result.put(smallCd, value);
        }
        return result;
    }

    /** 개발자 정보 저장 (C_BIG_CD='20') + 배너 (C_BIG_CD='10') */
    public void saveDevInfo(Map<String, Object> p) {
        String[][] devFields = {
            {"20","001", str(p,"devNm")},
            {"20","002", str(p,"devPart")},
            {"20","003", str(p,"devImg")},
            {"20","004", str(p,"devText")},
            {"20","005", str(p,"devMsg")},
            {"20","006", str(p,"devTag")},
            {"10","002", str(p,"mainText")}
        };
        for (String[] f : devFields) {
            Map<String, Object> m = new HashMap<>();
            m.put("cBigCd", f[0]); m.put("cSmallCd", f[1]); m.put("sValue", f[2]);
            codeDao.updateCode(m);
        }
    }

    /** 연락처 저장 (C_BIG_CD='30') */
    public void saveContact(Map<String, Object> p) {
        String[][] fields = {
            {"30","001", str(p,"contactMail")},
            {"30","002", str(p,"contactCall")},
            {"30","003", str(p,"contactTalk")}
        };
        for (String[] f : fields) {
            Map<String, Object> m = new HashMap<>();
            m.put("cBigCd", f[0]); m.put("cSmallCd", f[1]); m.put("sValue", f[2]);
            codeDao.updateCode(m);
        }
    }

    private String str(Map<String, Object> p, String key) {
        return p.get(key) != null ? String.valueOf(p.get(key)) : "";
    }
}
