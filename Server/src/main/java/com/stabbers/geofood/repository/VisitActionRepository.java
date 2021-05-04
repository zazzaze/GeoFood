package com.stabbers.geofood.repository;

import com.stabbers.geofood.entity.RoleEntity;
import com.stabbers.geofood.entity.VisitActionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VisitActionRepository extends JpaRepository<VisitActionEntity, Integer> {

    VisitActionEntity findByName(String name);
}