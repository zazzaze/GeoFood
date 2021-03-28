package com.stabbers.geofood.controller.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.stabbers.geofood.entity.ShopEntity;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.ArrayList;

@Data
@AllArgsConstructor
public class GetShopsResponse {
    String shop;
}
