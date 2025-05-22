package com.example.userskillapi.controller;

import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.userskillapi.model.User;
import com.example.userskillapi.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

	private final UserRepository userRepository;

	@GetMapping("/{id}")
	public ResponseEntity<User> getUserWithSkills(@PathVariable Long id) {
		return userRepository.findById(id)
				.map(ResponseEntity::ok)
				.orElse(ResponseEntity.notFound().build());
	}

	@GetMapping
	public List<User> getUsersWithDifferentSkills() {
		return userRepository.findAll(PageRequest.of(0, 20)).getContent();
	}
}
