package com.example.userskillapi.service;

import com.example.userskillapi.model.User;
import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.Date;

@Service
public class JwtService {

	private final SecretKey secretKey;

	// Base64-encoded string from application.properties
	public JwtService(@Value("${jwt.secret}") String base64Secret) {
		this.secretKey = Keys.hmacShaKeyFor(Decoders.BASE64.decode(base64Secret));
	}

	public String generateToken(User user) {
		return Jwts.builder()
				.subject(user.getEmail())
				.claim("name", user.getName())
				.claim("id", user.getUserId())
				.issuedAt(new Date())
				.expiration(new Date(System.currentTimeMillis() + 86400000)) // 1 day
				.signWith(secretKey, Jwts.SIG.HS256)
				.compact();
	}

	public boolean validateToken(String token) {
		try {
			Jwts.parser()
					.verifyWith(secretKey)
					.build()
					.parseSignedClaims(token);
			return true;
		} catch (JwtException e) {
			return false;
		}
	}

	public String getUsernameFromToken(String token) {
		Claims claims = Jwts.parser()
				.verifyWith(secretKey)
				.build()
				.parseSignedClaims(token)
				.getPayload();
		return claims.getSubject();
	}
}
