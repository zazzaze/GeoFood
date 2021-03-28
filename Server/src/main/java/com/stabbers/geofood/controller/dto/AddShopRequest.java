package com.stabbers.geofood.controller.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class AddShopRequest {

    @NotEmpty
    private String name;

    @NotEmpty
    private String longitude;

    @NotEmpty
    private String latitude;
}
