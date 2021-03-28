package com.stabbers.geofood.controller;

import com.stabbers.geofood.config.CustomUserDetails;
import com.stabbers.geofood.config.jwt.JwtProvider;
import com.stabbers.geofood.controller.dto.AuthRequest;
import com.stabbers.geofood.controller.dto.AuthResponse;
import com.stabbers.geofood.controller.dto.GetShopsResponse;
import com.stabbers.geofood.controller.dto.AddShopRequest;
import com.stabbers.geofood.controller.dto.RegistrationRequest;
import com.stabbers.geofood.entity.AdminEntity;
import com.stabbers.geofood.entity.ShopEntity;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.repository.ShopRepository;
import com.stabbers.geofood.service.AdminService;
import com.stabbers.geofood.service.ShopService;
import com.stabbers.geofood.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import java.util.ArrayList;
import java.util.List;

import static org.springframework.util.StringUtils.hasText;

@RestController
public class AuthController {
    @Autowired
    private UserService userService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private JwtProvider jwtProvider;

    @PostMapping("/reg/user")
    @ResponseStatus(value = HttpStatus.OK)
    public void registerUser(@RequestBody @Valid RegistrationRequest registrationRequest) {
        UserEntity user = new UserEntity();
        user.setPassword(registrationRequest.getPassword());
        user.setLogin(registrationRequest.getLogin());

        userService.saveUser(user);
    }

//    @PostMapping("/reg/admin")
//    @ResponseStatus(value = HttpStatus.OK)
//    public void registerAdmin(@RequestBody @Valid RegistrationRequest registrationRequest) {
//        AdminEntity admin = new AdminEntity();
//        admin.setPassword(registrationRequest.getPassword());
//        admin.setLogin(registrationRequest.getLogin());
//
//        adminService.saveAdmin(admin);
//    }

    @PostMapping("/auth")
    public AuthResponse auth(@RequestBody AuthRequest request) {
        UserEntity userEntity = userService.findByLoginAndPassword(request.getLogin(), request.getPassword());
        String token = jwtProvider.generateToken(userEntity.getLogin());

        return new AuthResponse(token);
    }

    @PostMapping("/user/shop/add")
    public HttpStatus addShops (@RequestHeader("Authorization") String bearer, @RequestBody AddShopRequest request) {
        String token = getTokenFromRequest(bearer);

        UserEntity user = null;
        if (token != null &&  jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            user = userService.findByLogin(userLogin);
        }

        if(user != null){
            ShopEntity newShop = new ShopEntity();
            newShop.setLatitude(request.getLatitude());
            newShop.setLongitude(request.getLongitude());
            newShop.setName(request.getName());
            newShop.setUser(user);
            user.addShop(newShop);
            shopService.saveShop(newShop);
            return HttpStatus.OK;
        }

        return HttpStatus.BAD_REQUEST;
    }

    @GetMapping("/user/shop/get")
    public ResponseEntity<Iterable<ShopEntity>> getShops (@RequestHeader("Authorization") String bearer) {
        String token = getTokenFromRequest(bearer);

        UserEntity user = null;
        if (token != null &&  jwtProvider.validateToken(token)) {
            String userLogin = jwtProvider.getLoginFromToken(token);
            user = userService.findByLogin(userLogin);
        }

        if(user != null){
            List<ShopEntity> shops = user.getShops();
            return new ResponseEntity<>(shops, HttpStatus.OK);
        }

        return null;
    }

    private String getTokenFromRequest(String bearer) {
        if (hasText(bearer) && bearer.startsWith("Bearer ")) {
            return bearer.substring(7);
        }
        return null;
    }
}