package com.example.user_skill_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;

@SpringBootApplication
public class UserSkillApiApplication {

	@GetMapping("/")
	public String print() {
		return "Hello World";
	}

	public static void main(String[] args) {
		SpringApplication.run(UserSkillApiApplication.class, args);
	}

}
