package com.stabbers.geofood.service;

import com.stabbers.geofood.entity.AdminEntity;
import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {
//    @Bean
//    PasswordEncoder getEncoder() {
//        return new BCryptPasswordEncoder();
//    }

    @Autowired
    private UserRepository userEntityRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserEntity saveUser(UserEntity newUser) {
        newUser.setPassword(passwordEncoder.encode(newUser.getPassword()));
        return userEntityRepository.save(newUser);
    }

    public UserEntity findByLogin(String login) {
        return userEntityRepository.findByLogin(login);
    }

    public UserEntity findByLoginAndPassword(String login, String password) {
        UserEntity user = findByLogin(login);
        if (user != null) {
            if (passwordEncoder.matches(password, user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    public UserEntity addNewShop(UserEntity user, ShopEntity shop) {
        user.addShop(shop);
        return user;
    }

    public List<ShopEntity> getAllShops(UserEntity user, ShopEntity shop){
        return user.getShops();
    }

}