package com.hst.ViewController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hst.entity.MemberRule;
import com.hst.service.MemberRuleService;

@Controller
@RequestMapping("/member/doc")
public class MemberRuleController {

    @Autowired
    private MemberRuleService service;

    // USER VIEW
    @GetMapping("")
    public String userView(Model model) {
        model.addAttribute("rules", service.getActiveRules());
        model.addAttribute("admin", false);
        return "member-doc";
    }

    // ADMIN VIEW
    @GetMapping("/admin")
    public String adminView(Model model) {
        model.addAttribute("rules", service.getAllRules());
        model.addAttribute("admin", true);
        return "member-doc";
    }

    @PostMapping("/save")
    @ResponseBody
    public String save(@RequestBody MemberRule rule) {
        service.save(rule);
        return "success";
    }

    @PostMapping("/toggle/{id}")
    @ResponseBody
    public String toggle(@PathVariable Long id) {
        service.toggleStatus(id);
        return "updated";
    }

    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public String delete(@PathVariable Long id) {
        service.delete(id);
        return "deleted";
    }

    @GetMapping("/get/{id}")
    @ResponseBody
    public MemberRule get(@PathVariable Long id) {
        return service.findById(id);
    }
}
