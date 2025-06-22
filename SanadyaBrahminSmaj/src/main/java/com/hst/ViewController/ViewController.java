package com.hst.ViewController;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.security.JwtTokenProvider;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ViewController {
	@Autowired
	JwtTokenProvider jwtTokenProvider;
	@Autowired
	UserRepository userRepository;
	
    @GetMapping("/")
    public String home() {
        return "home"; // resolves to /WEB-INF/views/index.jsp
    }

    @GetMapping("/login")
    public String login() {
        return "home"; // resolves to /WEB-INF/views/login.jsp
    }
    @GetMapping("/member/profile")
    public String profile(HttpServletRequest request, Model model) {
        String token = null;

        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("authToken".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null) {
            return "redirect:/"; // No login
        }

        String mobile = jwtTokenProvider.getUsernameFromToken(token);
        Optional<User> optionalUser = userRepository.findByMobile(mobile);
        if (optionalUser.isEmpty()) {
            return "redirect:/";
        }

        model.addAttribute("user", optionalUser.get());
        return "profile"; // profile.jsp
    }

	@GetMapping("/api/auth/logout")
	public String logout(HttpServletResponse response) {
	    Cookie cookie = new Cookie("authToken", null);
	    cookie.setPath("/");
	    cookie.setMaxAge(0); // expire now
	    response.addCookie(cookie);
	    return "home";
	}

}
