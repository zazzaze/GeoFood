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

    @Autowired
    private ShopRepository shopRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    final String lorem = "Lorem ipsum";

    public ShopEntity saveShop(ShopEntity shop) {
        shop.setLocation(lorem);
        return shopRepository.save(shop);
    }

    public List<ShopEntity> getAllShops() {
        return shopRepository.findAll();
    }

    public List<ShopEntity> getNearShop(double x, double y, double r) {
        return shopRepository.findNearShops(x, y, r);
    }

    public ShopEntity findById(int id) {
        return shopRepository.findById(id).orElse(new ShopEntity());
    }

}