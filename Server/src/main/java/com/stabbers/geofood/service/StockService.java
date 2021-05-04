package com.stabbers.geofood.service;

import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.repository.ShopRepository;
import com.stabbers.geofood.repository.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StockService {

    @Autowired
    private StockRepository stockRepository;

    public StockEntity saveStock(StockEntity stock) {
        return stockRepository.save(stock);
    }

    public StockEntity findByName(String name) {
        return stockRepository.findByName(name);
    }

    public List<StockEntity> getAllStocks() {
        return stockRepository.findAll();
    }

    public StockEntity findById(int id){
        return  stockRepository.findById(id).orElse(new StockEntity());
    }
}