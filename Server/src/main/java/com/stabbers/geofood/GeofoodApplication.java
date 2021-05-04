package com.stabbers.geofood;

import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.service.ShopService;
import com.stabbers.geofood.service.StockService;
import com.stabbers.geofood.service.UserService;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Random;

@SpringBootApplication
public class GeofoodApplication {
	@Autowired
	private UserService userService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private StockService stockService;

	private static final Random rnd = new Random();
	private static final String lorem = "XT1g3";
	private static final Logger LOGGER = LoggerFactory.getLogger(GeofoodApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(GeofoodApplication.class, args);
	}

//	@EventListener(ApplicationReadyEvent.class)
//	private void imgTest() throws IOException
//	{
////		final File initialFile = new File("uploads/mac.png");
////		final InputStream targetStream =
////				new DataInputStream(new FileInputStream(initialFile));
//
//		UserEntity admin = new UserEntity();
//		admin.setLogin("achekAdmin");
//		admin.setPassword("1234567890");
//		userService.saveAdmin(admin);
//
//		ShopEntity shopMac = new ShopEntity();
//		shopMac.setName("Mac");
//		shopMac.setLatitude(55.760735);
//		shopMac.setLongitude(37.631996);
//		shopMac.setHolder(admin);
//		//shopMac.setImg(IOUtils.toByteArray(targetStream));
//
//		admin.addShop(shopMac);
//		shopService.saveShop(shopMac);
//
////		ByteArrayInputStream bImg = new ByteArrayInputStream(shopMac.getImg());
////		BufferedImage testImg = ImageIO.read(bImg);
////		ImageIO.write(testImg, "png", new File("testMac.png") );
////
////		LOGGER.info("Image is done!");
//	}

	//@EventListener(ApplicationReadyEvent.class)
//	private void test(){
//		// USERS.
//		UserEntity user = new UserEntity();
//		user.setLogin("achekUser");
//		user.setPassword("1234567890");
//		userService.saveUser(user);
//
//		UserEntity admin = new UserEntity();
//		admin.setLogin("achekAdmin");
//		admin.setPassword("1234567890");
//		userService.saveAdmin(admin);
//
//		// SHOPS.
//		ShopEntity shopMac = new ShopEntity();
//		shopMac.setName("Mac");
//		shopMac.setLatitude(55.760735);
//		shopMac.setLongitude(37.631996);
//		shopMac.setAdmin(admin);
//		shopMac.setShopLogoFileName("Mac.png");
//		admin.addShop(shopMac);
//		shopService.saveShop(shopMac);
//
//		ShopEntity shopCofix = new ShopEntity();
//		shopCofix.setName("Cofix");
//		shopCofix.setLatitude(55.760396);
//		shopCofix.setLongitude(37.631663);
//		shopCofix.setShopLogoFileName("Mac.png");
//		shopCofix.setAdmin(admin);
//		admin.addShop(shopCofix);
//		shopService.saveShop(shopCofix);
//
//		for(int i = 0; i < 10; ++i){
//			generateShop(admin, i);
//			generateShop2(admin, i);
//		}
//
//		// STOCKS.
//		StockEntity stock1 = new StockEntity();
//		stock1.setName("BigMac");
//		stock1.setOldPrice(80);
//		stock1.setNewPrice(60);
//		stock1.setPromo(lorem);
//		//stock1.setStockImageFileName("BigMac.png");
//		stock1.setShop(shopMac);
//		shopMac.addStock(stock1);
//
//		StockEntity stock2 = new StockEntity();
//		stock2.setName("CaesarRoll");
//		stock2.setOldPrice(160);
//		stock2.setNewPrice(120);
//		stock1.setPromo(lorem);
//		//stock2.setStockImageFileName("Caesar.png");
//		stock2.setShop(shopMac);
//		shopMac.addStock(stock2);
//
//		StockEntity stock3 = new StockEntity();
//		stock3.setName("Cappuccino");
//		stock3.setOldPrice(60);
//		stock3.setNewPrice(40);
//		stock1.setPromo(lorem);
//		//stock3.setStockImageFileName("Cofe.png");
//		stock3.setShop(shopCofix);
//		shopCofix.addStock(stock3);
//
//		StockEntity stock4 = new StockEntity();
//		stock4.setName("Latte");
//		stock4.setOldPrice(80);
//		stock4.setNewPrice(60);
//		stock1.setPromo(lorem);
//		//stock4.setStockImageFileName("Cofe.png");
//		stock4.setShop(shopCofix);
//		shopCofix.addStock(stock4);
//
//		stockService.saveStock(stock1);
//		stockService.saveStock(stock2);
//		stockService.saveStock(stock3);
//		stockService.saveStock(stock4);
//	}

//	private void generateShop(UserEntity admin, int ind){
//		ShopEntity shop = new ShopEntity();
//		shop.setName("Mac " + ind);
//		shop.setShopLogoFileName("Mac.png");
//		shop.setLatitude(55.760 + rnd.nextInt(99) * 0.0001);
//		shop.setLongitude(37.631 + + rnd.nextInt(99) * 0.0001);
//		shop.setHolder(admin);
//		admin.addShop(shop);
//		shopService.saveShop(shop);
//		generateStock(shop, ind);
//	}
//
//	private void generateShop2(UserEntity admin, int ind){
//		ShopEntity shop = new ShopEntity();
//		shop.setName("Cofix " + ind);
//		shop.setShopLogoFileName("Cofix.png");
//		shop.setLatitude(55.760 + rnd.nextInt(99) * 0.0001);
//		shop.setLongitude(37.631 + + rnd.nextInt(99) * 0.0001);
//		shop.setHolder(admin);
//		admin.addShop(shop);
//		shopService.saveShop(shop);
//		generateStock2(shop, ind);
//	}
//
//	private void generateStock(ShopEntity shop, int ind){
//		StockEntity stock = new StockEntity();
//		stock.setName("BigMac " + ind);
//		stock.setPromo(lorem);
//		stock.setOldPrice(150);
//		stock.setNewPrice(110);
//		//stock.setStockImageFileName("BigMac.png");
//		stock.setShop(shop);
//		shop.addStock(stock);
//		stockService.saveStock(stock);
//	}
//
//	private void generateStock2(ShopEntity shop, int ind){
//		StockEntity stock = new StockEntity();
//		stock.setName("Cappucino " + ind);
//		stock.setPromo(lorem);
//		stock.setOldPrice(60);
//		stock.setNewPrice(40);
//		//stock.setStockImageFileName("Cofe.png");
//		stock.setShop(shop);
//		shop.addStock(stock);
//		stockService.saveStock(stock);
//	}
}
