package com.stabbers.geofood.repository;

import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    UserEntity findByLogin(String login);
    //UserEntity addNewShop(UserEntity user, ShopEntity shop);
}