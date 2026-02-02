package com.hst.ViewController;

import com.hst.entity.GotraMaster;
import com.hst.service.GotraMasterService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
public class GotraController {

    private final GotraMasterService service;

    public GotraController(GotraMasterService service) {
        this.service = service;
    }

    @GetMapping("/gotra")
    public String gotraList(Model model, Principal principal) {

        List<GotraMaster> list = service.findAllActive();

        model.addAttribute("gotraList", list);
        model.addAttribute("isAdmin", principal != null);

        return "gotra";
    }

    @PostMapping("/admin/gotra/save")
    @ResponseBody
    public String save(
            @RequestParam(required = false) Long id,
            @RequestParam String gotraName
    ) {
        GotraMaster g = (id != null) ? service.findById(id) : new GotraMaster();
        g.setGotraName(gotraName);
        service.save(g);
        return "OK";
    }

    @DeleteMapping("/admin/gotra/delete/{id}")
    @ResponseBody
    public String delete(@PathVariable Long id) {
        service.delete(id);
        return "OK";
    }
}
