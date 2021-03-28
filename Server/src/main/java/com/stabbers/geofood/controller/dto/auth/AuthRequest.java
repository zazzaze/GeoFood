package com.stabbers.geofood.controller.dto.auth;

import lombok.Data;

@Data
public class AuthRequest {
    private String login;
    private String password;
}
