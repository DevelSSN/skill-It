package com.example.userskillapi.controller;

import com.example.userskillapi.model.User;
import com.example.userskillapi.model.UserSkill;
import com.example.userskillapi.repository.UserRepository;
import com.example.userskillapi.service.JwtService;

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

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

	private final UserRepository userRepository;
	private final JwtService jwtService;
	private final PasswordEncoder passwordEncoder;

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
		response.put("user", user);
		return ResponseEntity.ok(response);
	}

	@PostMapping("/signup")
	public ResponseEntity<?> signUp(@RequestBody SignUpRequest signUpRequest) {
		System.out.println(signUpRequest.toString());
		if (userRepository.findByEmail(signUpRequest.getEmail()).isPresent()) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("Email already in use");
		}

		User user = User.builder()
				.name(signUpRequest.getName())
				.email(signUpRequest.getEmail())
				.password(passwordEncoder.encode(signUpRequest.getPassword()))
				.phoneNumber(signUpRequest.getPhoneNumber())
				.profilePhoto(signUpRequest.getProfilePhoto())
				.skills(signUpRequest.getSkills())
				.build();

		userRepository.save(user);
		return ResponseEntity.status(HttpStatus.CREATED).body(user);
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
	private List<UserSkill> skills;

	@Override
	public String toString()
	{ return "["+name+","+email+","+password+","+phoneNumber+","+profilePhoto+"]";}
}
