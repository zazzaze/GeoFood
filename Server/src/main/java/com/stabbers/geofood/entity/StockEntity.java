package com.stabbers.geofood.entity;

import lombok.Data;
import org.hibernate.validator.constraints.UniqueElements;

import javax.persistence.*;

@Data
@Entity
@Table(name = "shop")
public class StockEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", updatable = false, nullable = false)
    private Integer id;

    @Column
    private String name;

    @Column
    private String description;

    @Column
    private double oldPrice;

    @Column
    private double newPrice;

//    @ManyToOne (optional=false, cascade=CascadeType.ALL)
//    @JoinColumn (name="shop_id")
//    private ShopEntity shop;
}
