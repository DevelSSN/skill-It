package com.example.userskillapi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import jakarta.servlet.Filter;
import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor // Lombok will generate the constructor automatically
public class SecurityConfig {

	// This will be injected by Spring
	private GoogleTokenVerifier googleTokenVerifier;

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
				.csrf(csrf -> csrf.disable())
				.authorizeHttpRequests(auth -> auth
						.requestMatchers("/api/user/me").authenticated()
						.anyRequest().permitAll())
				.addFilterBefore(googleIdTokenAuthFilter(), UsernamePasswordAuthenticationFilter.class);

		return http.build();
	}

	@Bean
	public Filter googleIdTokenAuthFilter() {
		return new GoogleIdTokenAuthenticationFilter(googleTokenVerifier);
	}
}
