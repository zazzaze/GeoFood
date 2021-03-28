package com.stabbers.geofood.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.Data;
import org.hibernate.validator.constraints.UniqueElements;

import javax.persistence.*;

@Data
@Entity
@Table(name = "stock")
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

    @Column
    private String stockImageFileName;

    @JsonBackReference
    @ManyToOne
    @JoinColumn (name="shop_id")
    private ShopEntity shop;
}
