package com.stabbers.geofood.repository;

import com.stabbers.geofood.entity.ShopEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ShopRepository extends JpaRepository<ShopEntity, Integer> {
    ShopEntity findByName(String name);

    @Query(value = "SELECT * FROM shop WHERE ABS(latitude  - ?1) < 0.00005 * ?3 AND ABS(longitude - ?2) < 0.00005 * ?3", nativeQuery = true)
    List<ShopEntity> findNearShops(double x, double y, double r);
}