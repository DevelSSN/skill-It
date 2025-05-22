package com.example.userskillapi.controller;

import com.example.userskillapi.model.User;
import com.example.userskillapi.model.UserSkill;
import com.example.userskillapi.model.Skill;
import com.example.userskillapi.repository.UserRepository;
import com.example.userskillapi.service.JwtService;
import com.example.userskillapi.repository.SkillRepository;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Collections;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

	private final UserRepository userRepository;
	private final JwtService jwtService;
	private final PasswordEncoder passwordEncoder;
	private final SkillRepository skillRepository;

	@PostMapping("/login")
	public ResponseEntity<?> authenticate(@RequestBody LoginRequest loginRequest) {
		User user = userRepository.findByEmail(loginRequest.getEmail())
			.orElse(null);

		if (user == null || !passwordEncoder.matches(loginRequest.getPassword(), user.getPassword())) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
		}

		String jwt = jwtService.generateToken(user);

		Map<String, Object> response = new HashMap<>();
		response.put("jwt", jwt);

		Map<String, String> userData = new HashMap<>();
		userData.put("name", user.getName());
		userData.put("email", user.getEmail());
		userData.put("profilePhoto", user.getProfilePhoto());

		response.put("user", userData);

		return ResponseEntity.ok(response);
	}

	@PostMapping("/signup")
	public ResponseEntity<?> signUp(@RequestBody SignUpRequest signUpRequest) {
		System.out.println(signUpRequest.toString());

		if (userRepository.findByEmail(signUpRequest.getEmail()).isPresent()) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("Email already in use");
		}

		// Create user without skills first
		User user = User.builder()
			.name(signUpRequest.getName())
			.email(signUpRequest.getEmail())
			.password(passwordEncoder.encode(signUpRequest.getPassword()))
			.phoneNumber(signUpRequest.getPhoneNumber())
			.profilePhoto(signUpRequest.getProfilePhoto())
			.build();

		// Map skill DTOs to UserSkill entities
		List<UserSkill> userSkills = signUpRequest.getSkills().stream()
			.map(skillDto -> {
				Skill skill = skillRepository.findBySkillName(skillDto.getSkill().getSkillName())
					.orElseGet(() -> skillRepository.save(
								Skill.builder()
								.skillName(skillDto.getSkill().getSkillName())
								.build()
								));

				return UserSkill.builder()
					.user(user)
					.skill(skill)
					.proficiency(skillDto.getProficiency())
					.build();
			})
		.toList();

		// Set skills to user
		user.setSkills(userSkills);

		// Save user (with cascade, UserSkills will be saved too)
		userRepository.save(user);

		String jwt = jwtService.generateToken(user); // <-- your service that creates token

		return ResponseEntity.status(HttpStatus.CREATED).body(Collections.singletonMap("token", jwt));
	}
}

@Getter @Setter
class LoginRequest {
	private String email;
	private String password;
}

@Getter
class SignUpRequest {
	private String name;
	private String email;
	private String password;
	private String phoneNumber;
	private String profilePhoto;
	private List<SkillDTO> skills;

	@Override
	public String toString()
	{ return "["+name+","+email+","+password+","+phoneNumber+","+profilePhoto+"]";}
}

@Getter
@Setter
class SkillDTO
{
	private Skill skill;
	private int proficiency;
}
