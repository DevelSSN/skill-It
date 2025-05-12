package com.example.userskillapi.config;

import java.util.Collections;

import org.springframework.stereotype.Component;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

@Component
public class GoogleTokenVerifier {

	private static final String CLIENT_ID = "71081266017-40c73ebg5o7tthk1896p03hjv410029p.apps.googleusercontent.com";

	private final GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
			new NetHttpTransport(),
			GsonFactory.getDefaultInstance()).setAudience(Collections.singletonList(CLIENT_ID)).build();

	public GoogleIdToken.Payload verify(String idTokenString) throws Exception {
		GoogleIdToken idToken = verifier.verify(idTokenString);
		if (idToken != null) {
			return idToken.getPayload();
		} else {
			throw new Exception("Invalid ID token");
		}
	}
}
