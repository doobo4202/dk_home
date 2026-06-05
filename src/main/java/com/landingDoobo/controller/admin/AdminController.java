package com.landingDoobo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @RequestMapping({"", "/", "/main"})
    public String main() {
        return "/admin/main";
    }
}
