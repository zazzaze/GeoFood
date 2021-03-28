package com.stabbers.geofood.service;

import com.stabbers.geofood.entity.AdminEntity;
import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.repository.ShopRepository;
import com.stabbers.geofood.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShopService {
//    @Bean
//    PasswordEncoder getEncoder() {
//        return new BCryptPasswordEncoder();
//    }

    @Autowired
    private ShopRepository shopRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public ShopEntity saveShop(ShopEntity shop) {
        //shopEntity.setPassword(passwordEncoder.encode(shopEntity.getPassword()));
        // TODO: 27.03.2021 Обработать пароль
        return shopRepository.save(shop);
    }

    public ShopEntity findByName(String name) {
        return shopRepository.findByName(name);
    }

}