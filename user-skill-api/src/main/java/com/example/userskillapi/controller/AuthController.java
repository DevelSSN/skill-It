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
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

	private final AuthenticationManager authenticationManager;
	private final UserRepository userRepository;
	private final JwtService jwtService;
	private final PasswordEncoder passwordEncoder;

	@PostMapping("/login")
	public ResponseEntity<?> authenticate(@RequestBody LoginRequest loginRequest) {
		try {
			Authentication authentication = authenticationManager.authenticate(
					new UsernamePasswordAuthenticationToken(
							loginRequest.getEmail(),
							loginRequest.getPassword()));

			User user = (User) authentication.getPrincipal();
			String jwt = jwtService.generateToken(user);

			Map<String, Object> response = new HashMap<>();
			response.put("jwt", jwt);
			response.put("user", user);

			return ResponseEntity.ok(response);
		} catch (BadCredentialsException e) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
		}
	}

	@PostMapping("/signup")
	public ResponseEntity<?> signUp(@RequestBody SignUpRequest signUpRequest) {
		try {
			if (userRepository.findByEmail(signUpRequest.getEmail()).isPresent()) {
				return ResponseEntity.status(HttpStatus.CONFLICT).body("Email already in use");
			}

			User user = User.builder()
					.name(signUpRequest.getName())
					.email(signUpRequest.getEmail())
					.password(passwordEncoder.encode(signUpRequest.getPassword()))
					.phoneNumber(signUpRequest.getPhoneNumber())
					.profilePhoto(signUpRequest.getProfilePhoto())
					.skills(signUpRequest.getSkills()) // Ensure skills are handled correctly
					.build();

			userRepository.save(user);
			return ResponseEntity.status(HttpStatus.CREATED).body(user);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to sign up: " + e.getMessage());
		}
	}
}

@Getter
@Setter
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
}
