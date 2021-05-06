package com.stabbers.geofood.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonView;
import com.stabbers.geofood.entity.json.Views;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.UniqueElements;

import javax.persistence.*;

@Data
@Entity
@Table(name = "stock")
public class StockEntity {
    @JsonView({Views.forList.class})
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", updatable = false, nullable = false)
    private Integer id;

    @JsonView({Views.forList.class})
    @Column(columnDefinition = "VARCHAR(128)")
    private String name;

    @JsonView({Views.forList.class})
    @Column(columnDefinition = "VARCHAR(128)")
    private String promo;

    @JsonView({Views.forList.class})
    @Column
    private double oldPrice;

    @JsonView({Views.forList.class})
    @Column
    private double newPrice;

    @JsonView({Views.forList.class})
    @Column
    private boolean special;

    @JsonView({Views.fullMessage.class})
    @Lob
    @Column(columnDefinition = "BLOB")
    private byte[] img;

    @JsonView({Views.forList.class})
    @JsonBackReference
    @ManyToOne
    @JoinColumn (name="shop_id")
    private ShopEntity shop;
}
