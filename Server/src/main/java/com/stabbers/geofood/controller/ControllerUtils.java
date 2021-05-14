package com.stabbers.geofood.controller;

import com.stabbers.geofood.controller.dto.business.AddShopRequest;
import com.stabbers.geofood.controller.dto.business.AddStockRequest;
import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;

import static org.springframework.util.StringUtils.hasText;

public class ControllerUtils {

    public static String getTokenFromHeader(String bearer) {
        if (hasText(bearer) && bearer.startsWith("Bearer ")) {
            return bearer.substring(7);
        }
        return null;
    }

    public static ShopEntity createShop(AddShopRequest request){
        ShopEntity newShop = new ShopEntity();
        newShop.setLatitude(request.getLatitude());
        newShop.setLongitude(request.getLongitude());
        newShop.setName(request.getName());
        return newShop;
    }

    public static StockEntity createStock(AddStockRequest request){
        StockEntity newStock = new StockEntity();
        newStock.setName(request.getName());
        newStock.setPromo(request.getPromo());
        newStock.setOldPrice(request.getOldPrice());
        newStock.setNewPrice(request.getNewPrice());
        return newStock;
    }

    public static boolean shopInAarea(double x, double y, double radius, ShopEntity shop){
        double stockX = shop.getLatitude();
        double stockY = shop.getLongitude();
        double deltaX = 0.00005;
        double deltaY = 0.00005;
//        double h = Math.sqrt((stockX - x) * (stockX - x) + (stockY - y) * (stockY - y));
//        if(h <= radius)
//            return true;
//        else
//            return false;
        return Math.abs(stockX - x) < deltaX * radius && Math.abs(stockY - y) < deltaY * radius;
    }
}
