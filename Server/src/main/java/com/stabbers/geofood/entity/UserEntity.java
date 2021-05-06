package com.stabbers.geofood.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.*;
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

    @Column(unique = true, columnDefinition = "VARCHAR(128)")
    private String login;

    @Column(columnDefinition = "VARCHAR(128)")
    private String password;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private RoleEntity role;

    @JsonManagedReference
    @OneToMany(targetEntity = VisitActionEntity.class, mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<VisitActionEntity> visitActions = new ArrayList<>();
    public void addVisit(VisitActionEntity newVisit){
        visitActions.add(newVisit);
    }

    @JsonManagedReference
    @OneToMany(targetEntity = ShopEntity.class, mappedBy = "holder", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ShopEntity> shops = new ArrayList<>();
    public void addShop(ShopEntity newShop){
        shops.add(newShop);
    }
}
