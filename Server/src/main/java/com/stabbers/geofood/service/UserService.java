package com.stabbers.geofood.service;

import com.stabbers.geofood.entity.RoleEntity;
import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.repository.RoleRepository;
import com.stabbers.geofood.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepository userEntityRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserEntity saveUser(UserEntity newUser) {
        RoleEntity userRole = roleRepository.findByName("ROLE_USER");
        newUser.setRole(userRole);
        newUser.setPassword(passwordEncoder.encode(newUser.getPassword()));
        return userEntityRepository.save(newUser);
    }

    public UserEntity saveAdmin(UserEntity newUser) {
        RoleEntity userRole = roleRepository.findByName("ROLE_ADMIN");
        newUser.setRole(userRole);
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
}