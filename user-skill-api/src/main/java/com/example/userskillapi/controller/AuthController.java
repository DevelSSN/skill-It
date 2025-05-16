package com.example.userskillapi.controller;

import com.example.userskillapi.config.GoogleTokenVerifier;
import com.example.userskillapi.model.User;
import com.example.userskillapi.repository.UserRepository;
import com.example.userskillapi.service.JwtService;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

	private final GoogleTokenVerifier googleTokenVerifier;
	private final UserRepository userRepository;
	private final JwtService jwtService;

	@PostMapping("/google")
	public ResponseEntity<?> loginWithGoogle(@RequestBody Map<String, String> request) throws Exception {
		String idToken = request.get("idToken");
		GoogleIdToken.Payload payload = googleTokenVerifier.verify(idToken);

		String email = payload.getEmail();
		String name = (String) payload.get("name");
		String picture = (String) payload.get("picture");

		User user = userRepository.findByEmail(email).orElseGet(User::new);
		user.setEmail(email);
		user.setName(name);
		user.setProfilePhoto(picture);

		userRepository.save(user);

		String jwt = jwtService.generateToken(user);
		return ResponseEntity.ok(Map.of("token", jwt));
	}
}
