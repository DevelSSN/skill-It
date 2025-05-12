package com.example.userskillapi.repository;

import com.example.userskillapi.model.UserSkill;
import com.example.userskillapi.model.UserSkillId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserSkillRepository extends JpaRepository<UserSkill, UserSkillId> {
}
