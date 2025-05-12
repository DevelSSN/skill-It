package com.example.userskillapi.config;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.example.userskillapi.model.User;
import com.example.userskillapi.repository.UserRepository;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

	private final UserRepository userRepository;

	public CustomOAuth2UserService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		OAuth2User oAuth2User = super.loadUser(userRequest);

		// Extract user details (you can adjust this based on your DB schema)
		String email = oAuth2User.getAttribute("email");
		String name = oAuth2User.getAttribute("name");
		String profilePicture = oAuth2User.getAttribute("picture");

		// Save or update the user in the database
		User user = userRepository.findByEmail(email).orElse(new User());
		user.setName(name);
		user.setEmail(email);
		user.setProfilePhoto(profilePicture);

		// Save the user in the DB (This could also be done in a transaction)
		userRepository.save(user);

		// You can store other attributes as needed

		return new DefaultOAuth2User(
				oAuth2User.getAuthorities(),
				oAuth2User.getAttributes(),
				"name" // The attribute to use for the user's name
		);
	}
}
