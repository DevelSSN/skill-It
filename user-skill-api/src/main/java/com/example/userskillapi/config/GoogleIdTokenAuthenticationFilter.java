package com.example.userskillapi.config;

import java.io.IOException;
import java.util.Collections;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class GoogleIdTokenAuthenticationFilter extends OncePerRequestFilter {

	private final GoogleTokenVerifier tokenVerifier;

	public GoogleIdTokenAuthenticationFilter(GoogleTokenVerifier tokenVerifier) {
		this.tokenVerifier = tokenVerifier;
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response,
			FilterChain filterChain) throws ServletException, IOException {

		String authHeader = request.getHeader("Authorization");
		if (authHeader != null && authHeader.startsWith("Bearer ")) {
			String idToken = authHeader.substring(7);
			try {
				Payload payload = tokenVerifier.verify(idToken);

				String googleSub = payload.getSubject();
				String email = payload.getEmail();

				var auth = new UsernamePasswordAuthenticationToken(
						googleSub,
						null,
						Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")));
				SecurityContextHolder.getContext().setAuthentication(auth);
			} catch (Exception e) {
				response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid ID Token");
				return;
			}
		}

		filterChain.doFilter(request, response);
	}
}
