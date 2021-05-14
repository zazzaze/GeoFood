package com.stabbers.geofood.controller;

import com.stabbers.geofood.config.jwt.JwtProvider;
import com.stabbers.geofood.entity.UserEntity;
import com.stabbers.geofood.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestSecurityController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtProvider jwtProvider;

    @GetMapping("/admin/get")
    public ResponseEntity<UserEntity> getAdmin(@RequestHeader("Authorization") String bearer) {
        UserEntity admin = userService.findByLogin(jwtProvider.getLoginFromToken(ControllerUtils.getTokenFromHeader(bearer)));
        return new ResponseEntity<>(admin, HttpStatus.OK);
    }

    @GetMapping("/user/get")
    public ResponseEntity<UserEntity> getUser(@RequestHeader("Authorization") String bearer) {
        UserEntity user = userService.findByLogin(jwtProvider.getLoginFromToken(ControllerUtils.getTokenFromHeader(bearer)));
        return new ResponseEntity<>(user, HttpStatus.OK);
    }
}