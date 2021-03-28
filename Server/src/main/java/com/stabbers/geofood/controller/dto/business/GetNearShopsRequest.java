package com.stabbers.geofood.controller.dto.business;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class GetNearShopsRequest {

    @NotEmpty
    private double longitude;

    @NotEmpty
    private double latitude;

    @NotEmpty
    private double radius;

}
