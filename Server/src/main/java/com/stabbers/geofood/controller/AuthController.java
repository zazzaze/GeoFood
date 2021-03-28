package com.stabbers.geofood.controller;

import com.stabbers.geofood.config.jwt.JwtProvider;
import com.stabbers.geofood.controller.dto.auth.AuthRequest;
import com.stabbers.geofood.controller.dto.auth.AuthResponse;
import com.stabbers.geofood.controller.dto.register.RegistrationRequest;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.service.ShopService;
import com.stabbers.geofood.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

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

        if(registrationRequest.getRole() != null && registrationRequest.getRole().equals("admin"))
            userService.saveAdmin(user);
        else
            userService.saveUser(user);
    }

    @PostMapping("/auth")
    public AuthResponse auth(@RequestBody AuthRequest request) {
        UserEntity userEntity = userService.findByLoginAndPassword(request.getLogin(), request.getPassword());
        String token = jwtProvider.generateToken(userEntity.getLogin());

        return new AuthResponse(token);
    }

}