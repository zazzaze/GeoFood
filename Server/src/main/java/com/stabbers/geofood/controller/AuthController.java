package com.stabbers.geofood.controller;

import com.stabbers.geofood.config.jwt.JwtProvider;
import com.stabbers.geofood.controller.dto.AuthRequest;
import com.stabbers.geofood.controller.dto.AuthResponse;
import com.stabbers.geofood.controller.dto.RegistrationRequest;
import com.stabbers.geofood.controller.dto.RegistrationResponce;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
public class AuthController {
    @Autowired
    private UserService userService;
    @Autowired
    private JwtProvider jwtProvider;

    @PostMapping("/register")
    @ResponseStatus(value = HttpStatus.OK)
    public void registerUser(@RequestBody @Valid RegistrationRequest registrationRequest) {
        UserEntity u = new UserEntity();
        u.setPassword(registrationRequest.getPassword());
        u.setLogin(registrationRequest.getLogin());
        userService.saveUser(u);
        //return new RegistrationResponce(HttpStatus.OK);
    }

    @PostMapping("/auth")
    public AuthResponse auth(@RequestBody AuthRequest request) {
        UserEntity userEntity = userService.findByLoginAndPassword(request.getLogin(), request.getPassword());
        String token = jwtProvider.generateToken(userEntity.getLogin());
        return new AuthResponse(token);
    }
}