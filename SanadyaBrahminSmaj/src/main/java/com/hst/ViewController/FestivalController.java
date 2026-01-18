package com.hst.ViewController;

import com.hst.entity.Festival;
import com.hst.service.FestivalService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FestivalController {

    private final FestivalService service;

    public FestivalController(FestivalService service) {
        this.service = service;
    }

    @GetMapping("/festivals")
    public String festivals(Model model, Principal principal) {

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");

        List<Map<String, Object>> viewList = service.findAllActive().stream().map(f -> {
            Map<String, Object> m = new HashMap<>();
            m.put("id", f.getId());
            m.put("festivalDate", f.getFestivalDate().format(formatter));
            m.put("rawDate", f.getFestivalDate());
            m.put("festivalName", f.getFestivalName());
            m.put("description", f.getDescription());
            return m;
        }).toList();

        model.addAttribute("festivalList", viewList);
        model.addAttribute("isAdmin", principal != null);

        return "festivals";
    }

    @PostMapping("/admin/festival/save")
    @ResponseBody
    public String save(
            @RequestParam(required = false) Long id,
            @RequestParam String festivalDate,
            @RequestParam String festivalName,
            @RequestParam String description
    ) {
        Festival f = (id != null) ? service.findById(id) : new Festival();

        f.setFestivalDate(java.time.LocalDate.parse(festivalDate));
        f.setFestivalName(festivalName);
        f.setDescription(description);

        service.save(f);
        return "OK";
    }

    @DeleteMapping("/admin/festival/delete/{id}")
    @ResponseBody
    public String delete(@PathVariable Long id) {
        service.delete(id);
        return "OK";
    }
}
