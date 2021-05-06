package com.stabbers.geofood.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonView;
import com.stabbers.geofood.entity.json.Views;
import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "visit")
public class VisitActionEntity {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name = "id", updatable = false, nullable = false)
    private Integer id;

    @JsonView({Views.forList.class})
    @JsonBackReference
    @ManyToOne
    @JoinColumn (name="user_id")
    private UserEntity user;

    @JsonView({Views.forList.class})
    @JsonBackReference
    @ManyToOne
    @JoinColumn (name="shop_id")
    private ShopEntity shop;

    @JsonView({Views.forList.class})
    @Column
    private Integer count;

    @JsonView({Views.forList.class})
    @Column
    private java.sql.Timestamp lastVisit;
}
