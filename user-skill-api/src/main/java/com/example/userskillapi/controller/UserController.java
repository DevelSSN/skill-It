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
        return ResponseEntity.status(401).body("JWT is missing");
    }

    String userId;
    try {
        userId = jwtService.getUserIdFromToken(jwt);
    } catch (Exception e) {
        return ResponseEntity.status(401).body("Invalid JWT token");
    }

    User user = userRepository.findById(Long.parseLong(userId))
        .orElseThrow(() -> new RuntimeException("User not found"));

    // Delete old skills for the user
    userSkillRepository.deleteByUserId(user.getUserId());

    for (SkillDTO skillDto : applyRequest.getSkills()) {
        Skill skill = skillDto.getSkill();

        // Fetch existing skill entity by name or ID, or create new
        Skill persistedSkill = null;

        if (skill.getSkillId() != null) {
            persistedSkill = skillRepository.findById(skill.getSkillId())
                .orElseThrow(() -> new RuntimeException("Skill not found with id: " + skill.getSkillId()));
        } else if (skill.getSkillName() != null && !skill.getSkillName().isBlank()) {
            persistedSkill = skillRepository.findBySkillName(skill.getSkillName())
                .orElseGet(() -> {
                    // Create and save new skill if not found
                    Skill newSkill = new Skill();
                    newSkill.setSkillName(skill.getSkillName());
                    return skillRepository.save(newSkill);
                });
        } else {
            return ResponseEntity.badRequest().body("Skill information incomplete");
        }

        UserSkill userSkill = new UserSkill();
        userSkill.setUser(user);
        userSkill.setSkill(persistedSkill);
        userSkill.setProficiency(skillDto.getProficiency());

        userSkillRepository.save(userSkill);

        System.out.println("Saved skill for user " + userId + ": " + persistedSkill.getSkillName() +
            " (" + skillDto.getProficiency() + ")");
    }

    return ResponseEntity.ok("Application submitted successfully");
}
}

@Getter
class ApplyRequestDTO {
	private String jwt;
	private List<SkillDTO> skills;

	public List<SkillDTO> getSkills() { return skills; }
	public void setSkills(List<SkillDTO> skills) { this.skills = skills; }
}
