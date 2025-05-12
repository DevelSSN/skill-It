package com.example.userskillapi.model;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Skill {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long skillId;

	@Column(unique = true, nullable = false)
	private String skillName;

	@OneToMany(mappedBy = "skill", cascade = CascadeType.ALL)
	private List<UserSkill> users;

	// Getters and Setters omitted for brevity
}
