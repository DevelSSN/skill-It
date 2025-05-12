package com.example.userskillapi.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long userId;

	@Column(unique = true)
	private String googleSub;

	private String name;

	private String phoneNumber;

	@Column(unique = true)
	private String email;

	private String profilePhoto;

	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private List<UserSkill> skills;

}
