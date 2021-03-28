package com.stabbers.geofood;

import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.service.ShopService;
import com.stabbers.geofood.service.StockService;
import com.stabbers.geofood.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

@SpringBootApplication
public class GeofoodApplication {
	@Autowired
	private UserService userService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private StockService stockService;

	public static void main(String[] args) {
		SpringApplication.run(GeofoodApplication.class, args);
	}

//	private static UserService userService = new UserService();
//	private static ShopService shopService = new ShopService();
//	private static StockService stockService = new StockService();

	@EventListener(ApplicationReadyEvent.class)
	private void test(){
		// USERS.
		UserEntity user = new UserEntity();
		user.setLogin("achekUser");
		user.setPassword("123");
		userService.saveUser(user);

		UserEntity admin = new UserEntity();
		admin.setLogin("achekAdmin");
		admin.setPassword("12345");
		userService.saveAdmin(admin);

		// SHOPS.
		ShopEntity shopMac = new ShopEntity();
		shopMac.setName("Mac");
		shopMac.setLatitude(10);
		shopMac.setLongitude(10);
		shopMac.setAdmin(admin);
		admin.addShop(shopMac);
		shopService.saveShop(shopMac);

		ShopEntity shopCofix = new ShopEntity();
		shopCofix.setName("Cofix");
		shopCofix.setLatitude(100);
		shopCofix.setLongitude(100);
		shopCofix.setAdmin(admin);
		admin.addShop(shopCofix);
		shopService.saveShop(shopCofix);

		// STOCKS.
		StockEntity stock1 = new StockEntity();
		stock1.setName("BigMac");
		stock1.setOldPrice(130);
		stock1.setNewPrice(99);
		stock1.setShop(shopMac);
		shopMac.addStock(stock1);

		StockEntity stock2 = new StockEntity();
		stock2.setName("CaesarRoll");
		stock2.setOldPrice(160);
		stock2.setNewPrice(120);
		stock2.setShop(shopMac);
		shopMac.addStock(stock2);

		StockEntity stock3 = new StockEntity();
		stock3.setName("Cappuccino");
		stock3.setOldPrice(60);
		stock3.setNewPrice(40);
		stock3.setShop(shopCofix);
		shopCofix.addStock(stock3);

		StockEntity stock4 = new StockEntity();
		stock4.setName("Latte");
		stock4.setOldPrice(80);
		stock4.setNewPrice(60);
		stock4.setShop(shopCofix);
		shopCofix.addStock(stock4);

		stockService.saveStock(stock1);
		stockService.saveStock(stock2);
		stockService.saveStock(stock3);
		stockService.saveStock(stock4);
	}
}
