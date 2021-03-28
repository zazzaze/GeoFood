package com.stabbers.geofood.service;

import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.repository.ShopRepository;
import com.stabbers.geofood.repository.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class StockService {
//    @Bean
//    PasswordEncoder getEncoder() {
//        return new BCryptPasswordEncoder();
//    }

    @Autowired
    private StockRepository stockRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public StockEntity saveShop(StockEntity stock) {
        //shopEntity.setPassword(passwordEncoder.encode(shopEntity.getPassword()));
        // TODO: 27.03.2021 Обработать пароль
        return stockRepository.save(stock);
    }

    public StockEntity findByName(String name) {
        return stockRepository.findByName(name);
    }



}