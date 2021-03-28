package com.stabbers.geofood.repository;

import com.stabbers.geofood.entity.ShopEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ShopRepository extends JpaRepository<ShopEntity, Integer> {
    ShopEntity findByName(String name);
}