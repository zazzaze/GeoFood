package com.stabbers.geofood.entity;

import lombok.Data;
import org.hibernate.validator.constraints.UniqueElements;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "admin")
public class AdminEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", updatable = false, nullable = false)
    private Integer id;

    @Column
    private String login;

    @Column
    private String password;

    @OneToMany
    @JoinColumn(name = "shop_id")
    private List<ShopEntity> shops;
}
