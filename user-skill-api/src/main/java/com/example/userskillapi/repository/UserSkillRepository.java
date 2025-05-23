package com.example.userskillapi.repository;

import com.example.userskillapi.model.UserSkill;
import com.example.userskillapi.model.UserSkillId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import jakarta.transaction.Transactional;
import java.util.List;

public interface UserSkillRepository extends JpaRepository<UserSkill, UserSkillId> {

	@Query("SELECT us FROM UserSkill us WHERE us.user.id = :userId")
	List<UserSkill> findByUserId(Long userId);

	@Transactional
	@Modifying
	@Query("DELETE FROM UserSkill us WHERE us.user.id = :userId")
	void deleteByUserId(Long userId);


	@Transactional
	@Modifying
	@Query("DELETE FROM UserSkill us WHERE us.user.email = :email")
	void deleteByUserEmail(String email);
}
