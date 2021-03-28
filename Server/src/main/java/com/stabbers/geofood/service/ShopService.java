package com.stabbers.geofood.service;

import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.repository.ShopRepository;
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
        shop.setShopLogoFileName(shop.getName() + ".png");
        return shopRepository.save(shop);
    }

    public List<ShopEntity> getAllShops() {
        return shopRepository.findAll();
    }

    public ShopEntity findById(int id){
        return  shopRepository.findById(id).orElse(new ShopEntity());
    }

//    public ShopEntity findByName(String name) {
//        return shopRepository.findByName(name);
//    }

}