package com.stabbers.geofood.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.stabbers.geofood.controller.dto.business.GetNearShopsRequest;
import com.stabbers.geofood.config.jwt.JwtProvider;
import com.stabbers.geofood.controller.dto.business.AddShopRequest;
import com.stabbers.geofood.controller.dto.business.AddStockRequest;
import com.stabbers.geofood.controller.dto.business.GetStocksRequest;
import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.entity.json.Views;
import com.stabbers.geofood.service.ShopService;
import com.stabbers.geofood.service.StockService;
import com.stabbers.geofood.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
public class BusinessController {
    @Autowired
    private UserService userService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private StockService stockService;
    @Autowired
    private JwtProvider jwtProvider;

    // ADD SHOP.
    @PostMapping("/admin/shop/add")
    public HttpStatus addShops(@RequestHeader("Authorization") String bearer, @RequestBody AddShopRequest request) {
        String token = Utils.getTokenFromHeader(bearer);

        UserEntity admin = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            admin = userService.findByLogin(userLogin);
        }
        // TODO: Прокнуть SecurityException если токен не подходит

        if (admin == null)
            return HttpStatus.BAD_REQUEST;

        ShopEntity newShop = Utils.createShop(request);

        newShop.setAdmin(admin);
        admin.addShop(newShop);

        shopService.saveShop(newShop);
        return HttpStatus.OK;

    }

    // GET SHOPS.
    @GetMapping("/admin/shop/get")
    public ResponseEntity<Iterable<ShopEntity>> getShops(@RequestHeader("Authorization") String bearer) {
        String token = Utils.getTokenFromHeader(bearer);

        UserEntity user = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            user = userService.findByLogin(userLogin);
        }

        if (user == null)
            return null;

        List<ShopEntity> shops = user.getShops();
        return new ResponseEntity<>(shops, HttpStatus.OK);
    }

    // ADD STOCKS.
    @PostMapping("/admin/stock/add")
    public HttpStatus addStock(@RequestHeader("Authorization") String bearer, @RequestBody AddStockRequest request) {
        String token = Utils.getTokenFromHeader(bearer);

        UserEntity admin = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            admin = userService.findByLogin(userLogin);
        }

        // TODO: Прокнуть SecurityException если токен не подходит

        if (admin == null)
            return HttpStatus.BAD_REQUEST;

        List<ShopEntity> shops = admin.getShops();
        ShopEntity curShop = null;
        for (ShopEntity shop : shops) {
            if (shop.getName().equals(request.getShopName()))
                curShop = shop;
        }

        if (curShop == null)
            return HttpStatus.BAD_REQUEST;

        StockEntity newStock = Utils.createStock(request);
        newStock.setShop(curShop);
        curShop.addStock(newStock);
        stockService.saveStock(newStock);

        return HttpStatus.OK;
    }

    // GET STOCKS.
    @GetMapping("/admin/stock/get")
    public ResponseEntity<Iterable<StockEntity>> getStocks(@RequestHeader("Authorization") String bearer) {
        String token = Utils.getTokenFromHeader(bearer);

        UserEntity admin = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            admin = userService.findByLogin(userLogin);
        }

        if (admin == null)
            return null;

        ArrayList<StockEntity> stocks = new ArrayList<>();
        for (ShopEntity shop : admin.getShops()) {
            stocks.addAll(shop.getStocks());
        }

        return new ResponseEntity<>(stocks, HttpStatus.OK);
    }

    // GET NEAR SHOPS.
    @JsonView(Views.forList.class)
    @GetMapping("/user/shops")
    public List<ShopEntity> getNearShops(@RequestHeader("Authorization") String bearer,
                                                              @RequestBody GetNearShopsRequest request) {
        String token = Utils.getTokenFromHeader(bearer);

        UserEntity user = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            user = userService.findByLogin(userLogin);
        }

        if (user == null)
            return null;

        ArrayList<ShopEntity> shops = (ArrayList<ShopEntity>) shopService.getAllShops();
        ArrayList<ShopEntity> validShops = new ArrayList<>();

        for (ShopEntity shop : shops) {
            if (Utils.stockInArea(request.getLatitude(), request.getLongitude(), request.getRadius(), shop))
                validShops.add(shop);
        }

        return validShops;
    }

    // GET ALL SHOP STOCKS
    @GetMapping("/user/stocks")
    public List<StockEntity> getStocks(@RequestHeader("Authorization") String bearer,
                                          @RequestBody GetStocksRequest request) {
        String token = Utils.getTokenFromHeader(bearer);

        UserEntity user = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            user = userService.findByLogin(userLogin);
        }

        if (user == null)
            return null;

        ShopEntity stockHandler = shopService.findById(request.getId());
        if(stockHandler == null)
            return null;

        return stockHandler.getStocks();
    }
}
