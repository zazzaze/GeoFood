package com.stabbers.geofood.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.stabbers.geofood.controller.dto.business.*;
import com.stabbers.geofood.config.jwt.JwtProvider;
import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.entity.VisitActionEntity;
import com.stabbers.geofood.entity.json.Views;
import com.stabbers.geofood.service.ShopService;
import com.stabbers.geofood.service.StockService;
import com.stabbers.geofood.service.UserService;
import com.stabbers.geofood.service.VisitActionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class BusinessController {
    @Autowired
    private UserService userService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private StockService stockService;
    @Autowired
    private VisitActionService visitActionService;
    @Autowired
    private JwtProvider jwtProvider;


    private UserEntity getUserByToken(String bearer ){
        String token = ControllerUtils.getTokenFromHeader(bearer);
        UserEntity user = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            user = userService.findByLogin(userLogin);
        }
        return user;
    }

    // ADD SHOP.
    @PostMapping("/admin/shop/add")
    public HttpStatus addShops(@RequestHeader("Authorization") String bearer, @RequestBody AddShopRequest request) {
        String token = ControllerUtils.getTokenFromHeader(bearer);

        UserEntity admin = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            admin = userService.findByLogin(userLogin);
        }
        // TODO: Прокнуть SecurityException если токен не подходит

        if (admin == null)
            return HttpStatus.BAD_REQUEST;

        ShopEntity newShop = ControllerUtils.createShop(request);

        newShop.setHolder(admin);
        admin.addShop(newShop);

        shopService.saveShop(newShop);
        return HttpStatus.OK;

    }

    // GET SHOPS.
    @GetMapping("/admin/shop/get")
    public ResponseEntity<Iterable<ShopEntity>> getShops(@RequestHeader("Authorization") String bearer) {
        String token = ControllerUtils.getTokenFromHeader(bearer);

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

    // ADD STOCK.
    @PostMapping("/admin/stock/add")
    public HttpStatus addStock(@RequestHeader("Authorization") String bearer, @RequestBody AddStockRequest request) {
        String token = ControllerUtils.getTokenFromHeader(bearer);

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

        StockEntity newStock = ControllerUtils.createStock(request);
        newStock.setShop(curShop);
        curShop.addStock(newStock);
        stockService.saveStock(newStock);

        return HttpStatus.OK;
    }

    // GET STOCKS.
    @GetMapping("/admin/stock/get")
    public ResponseEntity<Iterable<StockEntity>> getStocks(@RequestHeader("Authorization") String bearer) {
        String token = ControllerUtils.getTokenFromHeader(bearer);

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

    // USER.
    // GET NEAR SHOPS.
    @JsonView(Views.forList.class)
    @PostMapping("/user/shops")
    public List<ShopEntity> getNearShops(@RequestHeader("Authorization") String bearer,
                                                              @RequestBody GetNearShopsRequest request) {
        UserEntity user = null;
        user = getUserByToken(bearer);

        if (user == null)
            return null;

        ArrayList<ShopEntity> shops = (ArrayList<ShopEntity>) shopService.getAllShops();
        ArrayList<ShopEntity> validShops = new ArrayList<>();

        for (ShopEntity shop : shops) {
            if (ControllerUtils.shopInAarea(request.getLatitude(), request.getLongitude(), request.getRadius(), shop))
                validShops.add(shop);
        }

        return validShops;
    }

    // GET ALL SHOP STOCKS
    @JsonView(Views.forList.class)
    @PostMapping("/user/stocks")
    public List<StockEntity> getStocks(@RequestHeader("Authorization") String bearer,
                                          @RequestBody GetStocksRequest request) {

        String token = ControllerUtils.getTokenFromHeader(bearer);

        UserEntity user = null;
        if (token != null && jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            user = userService.findByLogin(userLogin);
        }

        if (user == null)
            return null;

        ShopEntity shop = shopService.findById(request.getId());
        if(shop == null)
            return null;

        //ArrayList<StockEntity> validStocks = (ArrayList<StockEntity>) shop.getStocks();
        ArrayList<StockEntity> validStocks = new ArrayList<>(shop.getStocks());

        boolean isSpecialVisitor = false;
        Map<Integer, VisitActionEntity> visitActions = new HashMap<>();
        for(VisitActionEntity action: user.getVisitActions()){
            if(action.getUser().getId().equals(user.getId())){
                visitActions.put(action.getShop().getId(), action);
            }
        }

        if(visitActions.get(shop.getId()) != null && visitActions.get(shop.getId()).getCount() >= 10)
            isSpecialVisitor = true;

        if(!isSpecialVisitor)
            validStocks.removeIf(StockEntity::isSpecial);

        return validStocks;
    }

    // MOVEMENT CONTROLLER.
    @JsonView(Views.forList.class)
    @PostMapping("/movement")
    public HttpStatus movement(@RequestHeader("Authorization") String bearer,
                                         @RequestBody MovementRequest request) throws ParseException {
        UserEntity user;
        user = getUserByToken(bearer);

        if (user == null)
            return null;

        ArrayList<ShopEntity> shops = (ArrayList<ShopEntity>) shopService.getAllShops();
        ArrayList<ShopEntity> validShops = new ArrayList<>();

        for (ShopEntity shop : shops) {
            if (ControllerUtils.shopInAarea(request.getLatitude(), request.getLongitude(), 100, shop))
                validShops.add(shop);
        }

        Map<Integer, VisitActionEntity> visitActions = new HashMap<>();
        for(VisitActionEntity action: user.getVisitActions()){
            if(action.getUser().getId().equals(user.getId())){
                visitActions.put(action.getShop().getId(), action);
            }
        }

        for(ShopEntity shop : validShops) {
            Integer shopId = shop.getId();
            VisitActionEntity visit = visitActions.get(shopId);
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date requestDate = formatter.parse(request.getDate());

            if(visit != null){
                Date lastDate = new Date(visit.getLastVisit().getTime());

                if(requestDate.getTime() - lastDate.getTime() >= 1000){
                    visit.setCount(visit.getCount() + 1);
                    visit.setLastVisit(new Timestamp(requestDate.getTime()));
                    visitActionService.saveVisitAction(visit);
                }
            }
            else {
                VisitActionEntity newVisit = new VisitActionEntity();
                newVisit.setLastVisit(new Timestamp(requestDate.getTime()));
                newVisit.setShop(shopService.findById(shopId));
                newVisit.setCount(1);
                newVisit.setUser(user);

                user.addVisit(newVisit);
                visitActionService.saveVisitAction(newVisit);
            }
        }

        return HttpStatus.OK;
    }

    @JsonView(Views.fullMessage.class)
    @PostMapping("/shop/img")
    public byte[] getImg(@RequestBody GetShopImgRequest request) {

        ShopEntity shop = shopService.findById(request.getShopId());
        return shop.getImg();
    }

    @JsonView(Views.fullMessage.class)
    @PostMapping("/stock/img")
    public byte[] getImg(@RequestBody GetStockImgRequest request) {

        StockEntity stock = stockService.findById(request.getStockId());
        return stock.getImg();
    }

}
