
package com.example.userskillapi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
				.csrf().disable()
				.authorizeHttpRequests(authz -> authz
						.requestMatchers("/api/auth/google").permitAll() // use requestMatchers instead of antMatchers
						.anyRequest().authenticated());
		return http.build();
	}
}
