package com.example.userskillapi.model;

import jakarta.persistence.*;
import lombok.*;
import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@IdClass(UserSkillId.class)
public class UserSkill {

    @Id
    @ManyToOne
    @JoinColumn(name = "user_id")
	@JsonBackReference
    private User user;

    @Id
    @ManyToOne
    @JoinColumn(name = "skill_id")
	@JsonBackReference
    private Skill skill;

    private int proficiency;
}
