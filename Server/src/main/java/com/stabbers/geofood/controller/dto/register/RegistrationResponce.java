package com.stabbers.geofood.controller.dto.register;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.http.HttpStatus;

@Data
@AllArgsConstructor
public class RegistrationResponce {
    HttpStatus status;
}