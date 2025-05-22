package com.example.userskillapi.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Skill {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long skillId;

	@Column(unique = true, nullable = false)
	private String skillName;

	@OneToMany(mappedBy = "skill", cascade = CascadeType.ALL)
	private List<UserSkill> users;
}
