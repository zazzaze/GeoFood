package com.stabbers.geofood.repository;

import com.stabbers.geofood.entity.AdminEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminRepository extends JpaRepository<AdminEntity, Integer> {
    AdminEntity findByLogin(String login);
}
