package com.hst.ViewController;

import com.hst.entity.User;
import com.hst.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminUserController {

    @Autowired
    private UserService userService;

    @GetMapping("/memberList")
    public String listUsers(Model model) {
        List<User> userList = userService.getAllUsersWithPaymentInfo();
        model.addAttribute("userList", userList);
        return "memberListAdmin"; // users.jsp
    }




    @PostMapping("/approveUser/{id}")
    @ResponseBody
    public ResponseEntity<?> approveUser(@PathVariable Long id) {
        userService.approveUser(id);
        return ResponseEntity.ok("User approved");
    }


    @GetMapping("/users/filter")
    public String filterUsers(@RequestParam(required = false) String name,
                              @RequestParam(required = false) String city,
                              @RequestParam(required = false) Boolean approved,
                              @RequestParam(required = false) Boolean due,
                              Model model) {
        List<User> filteredUsers = userService.filterUsers(name, city, approved, due);
        model.addAttribute("userList", filteredUsers);
        return "fragments/user-cards :: userCardList";
    }
}
