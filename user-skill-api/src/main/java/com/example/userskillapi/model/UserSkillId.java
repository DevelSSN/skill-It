package com.example.userskillapi.model;

import lombok.*;

import java.io.Serializable;
import java.util.Objects;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserSkillId implements Serializable {

    private Long user;
    private Long skill;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof UserSkillId)) return false;
        UserSkillId that = (UserSkillId) o;
        return Objects.equals(user, that.user) && Objects.equals(skill, that.skill);
    }

    @Override
    public int hashCode() {
        return Objects.hash(user, skill);
    }
}
