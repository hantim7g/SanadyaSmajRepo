package com.hst.ViewController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "home"; // resolves to /WEB-INF/views/index.jsp
    }

    @GetMapping("/login")
    public String login() {
        return "login"; // resolves to /WEB-INF/views/login.jsp
    }
}
