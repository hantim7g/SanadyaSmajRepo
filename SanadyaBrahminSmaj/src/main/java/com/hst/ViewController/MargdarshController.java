package com.hst.ViewController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hst.dto.MessageDto;
import com.hst.service.MessageService;


@Controller
public class MargdarshController {

	 @Autowired
	    private MessageService messageService;

	    @GetMapping("/shubhkamna")
	    public String showMessage(Model model) {
	    	  List<MessageDto> messages = messageService.getAllMessage(); // return list
	    	    model.addAttribute("messages", messages);

	    	    model.addAttribute("brandName", "सनाड्य ब्राह्मण महासभा");
	    	    model.addAttribute("pageTitle", "शुभकामना संदेश");

	        return"margDarshn/margdarsh" ;
	        }
}
