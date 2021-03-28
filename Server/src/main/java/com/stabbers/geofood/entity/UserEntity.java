package com.stabbers.geofood.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.UniqueElements;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Data
@Entity
@Table(name = "user")
public class UserEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", updatable = false, nullable = false)
    private Integer id;

    @Column(unique = true)
    private String login;

    @Column
    private String password;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private RoleEntity role;

    @JsonManagedReference
    @OneToMany(targetEntity = ShopEntity.class, mappedBy = "admin", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ShopEntity> shops = new ArrayList<>();

    public void addShop(ShopEntity newShop){
        shops.add(newShop);
    }
}
