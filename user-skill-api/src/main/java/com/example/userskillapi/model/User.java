package com.example.userskillapi.model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User implements UserDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long userId;

	private String name;

	private String password;

	private String phoneNumber;

	@Column(unique = true)
	private String email;

	private String profilePhoto;

	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private List<UserSkill> skills;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(); // No roles or authorities for now
	}

	@Override
	public String getUsername() {
		return email;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}
}
