package com.stabbers.geofood.service;

import com.stabbers.geofood.entity.AdminEntity;
import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {
    @Autowired
    private AdminRepository adminRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public AdminEntity saveAdmin(AdminEntity adminEntity) {
        adminEntity.setPassword(passwordEncoder.encode(adminEntity.getPassword()));
        return adminRepository.save(adminEntity);
    }

    public AdminEntity findByLogin(String login) {
        return adminRepository.findByLogin(login);
    }


//    public AdminEntity findByLoginAndPassword(String login, String password) {
//        AdminEntity userEntity = findByLogin(login);
//        if (userEntity != null) {
//            if (passwordEncoder.matches(password, userEntity.getPassword())) {
//                return userEntity;
//            }
//        }
//        return null;
//    }
}