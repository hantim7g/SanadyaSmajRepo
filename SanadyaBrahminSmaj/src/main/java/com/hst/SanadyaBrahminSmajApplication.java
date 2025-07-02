package com.hst;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class SanadyaBrahminSmajApplication {

	
	public static void main(String[] args) {
		SpringApplication.run(SanadyaBrahminSmajApplication.class, args);
	}
//	   @Override
//	    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
//	        return builder.sources(MyApp.class);
//	    }
}
