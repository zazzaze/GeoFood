package com.stabbers.geofood.controller.dto.business;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class AddShopRequest {

    @NotEmpty
    private String name;

    @NotEmpty
    private double longitude;

    @NotEmpty
    private double latitude;
}
