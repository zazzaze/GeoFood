package com.stabbers.geofood;

import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.StockEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.entity.VisitActionEntity;
import com.stabbers.geofood.service.ShopService;
import com.stabbers.geofood.service.StockService;
import com.stabbers.geofood.service.UserService;
import com.stabbers.geofood.service.VisitActionService;
import lombok.AllArgsConstructor;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import java.io.*;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@SpringBootApplication
public class GeofoodApplication {
	@Autowired
	private UserService userService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private StockService stockService;
	@Autowired
	private VisitActionService visitActionService;


//	String path = "achek/uploads/";
//
//	private static final Logger LOGGER = LoggerFactory.getLogger(GeofoodApplication.class);
//	private String lorem = "lorem ipsum";
//	private final String srcChar = "qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOPASDFGHJKLZXCVBNM";
//	private  String getPromo(){
//		String ans = "";
//		for(int i = 0; i < 5; ++i){
//			ans +=  srcChar.toCharArray()[(int) (Math.random() * (srcChar.length()))];
//		}
//		return ans;
//	}
//	@AllArgsConstructor
//	private  class Shop {
//		double longitude;
//		double latitude;
//		String name;
//		int type;
//	}
//
//	private final List<Shop> shops = Arrays.asList(new Shop(55.74776520767051, 37.612974838004156, "Cofix", 0),
//			new Shop(55.751741766356055, 37.61115492031277, "Cofix", 0),
//			new Shop(55.755537194261436, 37.61409890481368, "Cofix", 0),
//			new Shop(55.758067274364045, 37.6186486990423, "Cofix", 0),
//			new Shop(55.75945272487036, 37.6241619791078, "Cofix", 0),
//			new Shop(55.757314291488534, 37.62823003041814, "Cofix", 0),
//			new Shop(55.755567315228, 37.63251218969216, "McDonald’s", 1),
//			new Shop(55.75336842353714, 37.63331509455606, "McDonald’s", 1),
//			new Shop(55.74987403927311, 37.63144164987365, "McDonald’s", 1),
//			new Shop(55.74924140176145, 37.624750776007915, "McDonald’s", 1),
//			new Shop(55.74927152758989, 37.616721727369075, "McDonald’s", 1)
//	);


	public static void main(String[] args) {
		SpringApplication.run(GeofoodApplication.class, args);
	}

//	@EventListener(ApplicationReadyEvent.class)
//	private void imgTest() throws IOException
//	{
//		createAdminWithContent();
//	}
//
//	public void createAdminWithContent() throws IOException {
//		UserEntity admin = new UserEntity();
//		admin.setLogin("admin");
//		admin.setPassword("impsstabb");
//		userService.saveAdmin(admin);
//
//		UserEntity user = new UserEntity();
//		user.setLogin("egor");
//		user.setPassword("1234567890");
//		userService.saveUser(user);
//
//		generateShops(admin, user);
//	}
//
//	private void generateShops(UserEntity holder, UserEntity user) throws IOException {
//		int cnt = 0;
//		for(Shop point : shops){
//			ShopEntity newShop = new ShopEntity();
//			newShop.setHolder(holder);
//			newShop.setLocation(lorem);
//			newShop.setLatitude(point.longitude);
//			newShop.setLongitude(point.latitude);
//			newShop.setName(point.name + "_" + cnt);
//			newShop.setType(point.type);
//			if(newShop.getType() == 1){
//				final File initialFile = new File(path + "Mac_Logo.png");
//				final InputStream targetStream = new DataInputStream(new FileInputStream(initialFile));
//				newShop.setImg(IOUtils.toByteArray(targetStream));
//			}
//			else {
//				final File initialFile = new File(path + "Cofix_Logo.png");
//				final InputStream targetStream = new DataInputStream(new FileInputStream(initialFile));
//				newShop.setImg(IOUtils.toByteArray(targetStream));
//			}
//
//			holder.addShop(newShop);
//			shopService.saveShop(newShop);
//
//			// SPECIAL
//			if(cnt == 0){
//				createSpecialStock(newShop);
//				createVisit(user, newShop, 9);
//			}
//			else if(cnt < 6){
//				createSpecialStock(newShop);
//				createVisit(user, newShop, 8);
//			}
//			// SPECIAL
//
//			if(newShop.getType() == 0)
//				generateStocks(newShop, false);
//			else
//				generateStocks(newShop, true);
//			cnt++;
//		}
//	}
//
//	private void generateStocks(ShopEntity holder,  boolean isMac) throws IOException{
//		for(int i = 0; i < 3; ++i){
//			StockEntity newStock = new StockEntity();
//			newStock.setPromo(getPromo());
//			newStock.setShop(holder);
//			newStock.setName(holder.getName() + "_stock_" + i);
//			newStock.setNewPrice(100);
//			newStock.setOldPrice(200);
//
//			if(isMac){
//				final File initialFile = new File(path + "Mac_Stock.png");
//				final InputStream targetStream = new DataInputStream(new FileInputStream(initialFile));
//				newStock.setImg(IOUtils.toByteArray(targetStream));
//			}
//			else {
//				final File initialFile = new File(path + "Cofix_Stock.png");
//				final InputStream targetStream = new DataInputStream(new FileInputStream(initialFile));
//				newStock.setImg(IOUtils.toByteArray(targetStream));
//			}
//
//
//			stockService.saveStock(newStock);
//
//			holder.addStock(newStock);
//		}
//	}
//
//	private void createSpecialStock(ShopEntity holder) throws IOException{
//		StockEntity newStock = new StockEntity();
//		newStock.setPromo(getPromo());
//		newStock.setShop(holder);
//		newStock.setName(holder.getName() + "_SPECIAL");
//		newStock.setNewPrice(50);
//		newStock.setOldPrice(200);
//		newStock.setSpecial(true);
//
//		final File initialFile = new File(path + "Special.png");
//		final InputStream targetStream = new DataInputStream(new FileInputStream(initialFile));
//		newStock.setImg(IOUtils.toByteArray(targetStream));
//
//		stockService.saveStock(newStock);
//
//		holder.addStock(newStock);
//	}
//
//	public void createVisit(UserEntity user, ShopEntity shop, int cnt){
//		VisitActionEntity newVisit = new VisitActionEntity();
//		newVisit.setUser(user);
//		newVisit.setCount(cnt);
//		newVisit.setShop(shop);
//		user.addVisit(newVisit);
//		Date date = new Date(System.currentTimeMillis());
//		newVisit.setLastVisit(new Timestamp(date.getTime()));
//		visitActionService.saveVisitAction(newVisit);
//	}

}
