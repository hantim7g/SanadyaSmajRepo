package com.hst.ViewController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hst.entity.OfficeBearer;
import com.hst.repository.OfficeBearerRepository;
import com.hst.service.UserService;
@Controller
@RequestMapping("/officials")
public class OfficeBearerController {

    @Autowired
    private OfficeBearerRepository repo;

    @Autowired
    private UserService userService;
    
    /* PUBLIC VIEW */
    @GetMapping
    public String view(Model model) {
        model.addAttribute("officials",
        		userService.findAllByOrderBySmajRolePriorityAsc());
        return "officials/officials-view";
    }

    /* ADMIN PAGE */
    @GetMapping("/admin")
    public String admin(Model model) {
        model.addAttribute("officials",
            repo.findAll(Sort.by("displayOrder")));
        return "officials/officials-admin";
    }

    /* SAVE (ADD / EDIT) */
    @PostMapping("/admin/save")
    @ResponseBody
    public String save(OfficeBearer o) {
        repo.save(o);
        return "OK";
    }

    /* TOGGLE ACTIVE */
    @PostMapping("/admin/toggle/{id}")
    @ResponseBody
    public String toggle(@PathVariable Long id) {
        OfficeBearer o = repo.findById(id).orElseThrow();
        o.setActive(!o.getActive());
        repo.save(o);
        return "OK";
    }

    /* SAVE ORDER */
    @PostMapping("/admin/order")
    @ResponseBody
    public String saveOrder(@RequestBody List<Long> ids) {
        for (int i = 0; i < ids.size(); i++) {
            OfficeBearer o = repo.findById(ids.get(i)).orElseThrow();
            o.setDisplayOrder(i);
            repo.save(o);
        }
        return "OK";
    }
}
