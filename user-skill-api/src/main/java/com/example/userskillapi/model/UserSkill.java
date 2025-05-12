package com.example.userskillapi.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@IdClass(UserSkillId.class)
@Getter
@Setter
public class UserSkill {

	@Id
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@Id
	@ManyToOne
	@JoinColumn(name = "skill_id")
	private Skill skill;

	private int yearOfProficiency;

	// Getters and Setters omitted for brevity
}
