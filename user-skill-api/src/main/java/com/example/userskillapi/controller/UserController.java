package com.example.userskillapi.controller;

import java.util.List;
import com.example.userskillapi.controller.SkillDTO;
import com.example.userskillapi.service.JwtService;

import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;

import com.example.userskillapi.model.User;
import com.example.userskillapi.model.UserSkill;
import com.example.userskillapi.model.Skill;
import com.example.userskillapi.repository.UserRepository;
import com.example.userskillapi.repository.UserSkillRepository;
import com.example.userskillapi.repository.SkillRepository;

import lombok.RequiredArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

	private final UserRepository userRepository;
	private final UserSkillRepository userSkillRepository;
	private final SkillRepository skillRepository;
	private final JwtService jwtService;

	@GetMapping("/{id}")
	public ResponseEntity<User> getUserWithSkills(@PathVariable Long id) {
		return userRepository.findById(id)
			.map(ResponseEntity::ok)
			.orElse(ResponseEntity.notFound().build());
	}

	@GetMapping
	public List<User> getUsersWithDifferentSkills() {
		return userRepository.findDistinctUsersWithSkills();
	}

	@PostMapping(value = "/apply", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> submitApplication(@RequestBody ApplyRequestDTO applyRequest) {
		if (applyRequest.getSkills() == null || applyRequest.getSkills().isEmpty()) {
			return ResponseEntity.badRequest().body("Skills list cannot be empty");
		}

		String jwt = applyRequest.getJwt();
		if (jwt == null || jwt.isBlank()) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("JWT is missing");
		}

		String email;
		try {
			email = jwtService.getUserEmailFromToken(jwt); // Use `getEmailFromToken()` instead of `getUserIdFromToken()`
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token");
		}

		User user = userRepository.findByEmail(email)
			.orElseThrow(() -> new RuntimeException("User not found"));

		// Delete old skills by email
		userSkillRepository.deleteByUserEmail(email);

		// Save new skills
		for (FlatSkillDTO dto : applyRequest.getSkills()) {
			Skill skill = skillRepository.findBySkillName(dto.getSkill())
				.orElseGet(() -> skillRepository.save(
							Skill.builder().skillName(dto.getSkill()).build()
							));

			UserSkill userSkill = new UserSkill();
			userSkill.setUser(user);
			userSkill.setSkill(skill);
			userSkill.setProficiency(dto.getYears());
			userSkillRepository.save(userSkill);
		}

		return ResponseEntity.ok("Application submitted successfully");
	}
}

@Getter
@Setter
class ApplyRequestDTO {
	private String jwt;
	private List<FlatSkillDTO> skills;
}

@Getter
@Setter
class FlatSkillDTO {
	private String skill;
	private int years;
}
