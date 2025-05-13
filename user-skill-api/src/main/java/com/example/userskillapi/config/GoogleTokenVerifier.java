
package com.example.userskillapi.config;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Collections;

@Component
public class GoogleTokenVerifier {

	private final GoogleIdTokenVerifier verifier;

	public GoogleTokenVerifier(@Value("${google.client-id}") String clientId) {
		this.verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), GsonFactory.getDefaultInstance())
				.setAudience(Collections.singletonList(clientId))
				.build();
	}

	public GoogleIdToken.Payload verify(String idToken) throws Exception {
		GoogleIdToken token = verifier.verify(idToken);
		if (token == null) {
			throw new Exception("Invalid ID token.");
		}
		return token.getPayload();
	}
}
