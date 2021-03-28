package com.stabbers.geofood.controller.dto.business;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class AddStockRequest {

    @NotEmpty
    private String name;

    @NotEmpty
    private String description;

    @NotEmpty
    private double oldPrice;

    @NotEmpty
    private double newPrice;

    @NotEmpty
    private String shopName;

}
