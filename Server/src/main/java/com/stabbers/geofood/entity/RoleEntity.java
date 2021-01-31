package com.stabbers.geofood.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "role_table")
public class RoleEntity {
    @Id
    @GeneratedValue
    private Integer id;

    @Column
    private String name;
}
