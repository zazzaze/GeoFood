package com.stabbers.geofood.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.Data;
import lombok.ToString;
import org.hibernate.validator.constraints.UniqueElements;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "shop")
public class ShopEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", updatable = false, nullable = false)
    private Integer id;

    @Column
    private String name;

    @Column
    private String longitude;

    @Column
    private String latitude;

    @JsonBackReference
    @ManyToOne
    @JoinColumn (name="user_id")
    private UserEntity user;


//    @OneToMany (mappedBy="shop", fetch=FetchType.EAGER)
//    private List<StockEntity> stocks;
}
