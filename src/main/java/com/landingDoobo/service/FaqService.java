package com.landingDoobo.service;

import com.landingDoobo.dao.FaqDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class FaqService {

    private final FaqDao faqDao;

    public List<Map<String, Object>> selectFaqList() { return faqDao.selectFaqList(); }
    public Map<String, Object> selectFaqOne(Map<String, Object> p) { return faqDao.selectFaqOne(p); }
    public int saveFaq(Map<String, Object> p) {
        if (p.get("seq") != null && !p.get("seq").toString().isEmpty()) return faqDao.updateFaq(p);
        return faqDao.insertFaq(p);
    }
    public int deleteFaq(Map<String, Object> p)  { return faqDao.deleteFaq(p); }
    public int restoreFaq(Map<String, Object> p) { return faqDao.restoreFaq(p); }
}
