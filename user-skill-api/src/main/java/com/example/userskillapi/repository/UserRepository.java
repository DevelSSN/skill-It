package com.example.userskillapi.repository;

import com.example.userskillapi.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
	Optional<User> findByEmail(String email);

	@Query("SELECT DISTINCT u FROM User u JOIN u.skills s")
	List<User> findDistinctUsersWithSkills();
}
