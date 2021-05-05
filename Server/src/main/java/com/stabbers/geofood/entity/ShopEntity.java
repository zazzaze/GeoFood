package com.stabbers.geofood.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.*;
import com.stabbers.geofood.entity.json.Views;
import org.hibernate.validator.constraints.UniqueElements;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "shop")
public class ShopEntity {
    @JsonView({Views.forList.class})
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", updatable = false, nullable = false)
    private Integer id;

    @JsonView({Views.forList.class})
    @Column
    private String name;

    @JsonView({Views.forList.class})
    @Column
    private double longitude;

    @JsonView({Views.forList.class})
    @Column
    private double latitude;

    @JsonView({Views.forList.class})
    @Column
    private String location;

    @JsonView({Views.forList.class})
    @Column
    private int type;

    @JsonView({Views.forList.class})
    @JsonBackReference
    @ManyToOne
    @JoinColumn (name="user_id")
    private UserEntity holder;

    @JsonView({Views.fullMessage.class})
    @Lob
    @Column(columnDefinition = "BLOB")
    private byte[] img;


    @JsonView({Views.fullMessage.class})
    @JsonIgnore
    @JsonManagedReference
    @OneToMany(targetEntity = StockEntity.class, mappedBy = "shop", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<StockEntity> stocks = new ArrayList<>();

    public void addStock(StockEntity newStock){
        stocks.add(newStock);
    }
}
