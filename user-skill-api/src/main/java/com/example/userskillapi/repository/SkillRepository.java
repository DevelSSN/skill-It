package com.example.userskillapi.repository;

import com.example.userskillapi.model.Skill;
import com.example.userskillapi.model.UserSkill;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.List;

public interface SkillRepository extends JpaRepository<Skill, Long> {
	Optional<Skill> findBySkillName(String skillName);
}
