//
//  RestaurantHeaderView.swift
//  GeoFood
//
//  Created by Егор on 23.04.2021.
//

import UIKit

class RestaurantHeaderView: UIView {
    
    private let logoImage = UIImageView()
    private let smallImage = UIImageView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let distanceLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        configureSubviews()
        addAllSubviews()
    }
    
    private func configureSubviews() {
        configureLogoImage()
        configureSmallImage()
        configureNameLabel()
        configureAddressLabel()
        configureDistanceLabel()
    }
    
    private func configureLogoImage() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.layer.cornerRadius = 13
        logoImage.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        logoImage.layer.shadowRadius = 1
        logoImage.layer.shadowOffset = CGSize(width: 0, height: 4)
        logoImage.layer.masksToBounds = true
    }
    
    private func configureSmallImage() {
        smallImage.translatesAutoresizingMaskIntoConstraints = false
        smallImage.tintColor = UIColor(named: "dark_blue")
    }
    
    private func configureNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = UIColor(named: "dark_blue")
    }
    
    private func configureAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        addressLabel.textColor = .lightGray
    }
    
    private func configureDistanceLabel() {
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        distanceLabel.textColor = .lightGray
    }
    
    private func addAllSubviews() {
        addSubview(logoImage)
        addSubview(smallImage)
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(distanceLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImage.heightAnchor.constraint(equalTo: heightAnchor),
            logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor),
            logoImage.topAnchor.constraint(equalTo: topAnchor),
            
            smallImage.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 14),
            smallImage.widthAnchor.constraint(equalToConstant: 20),
            smallImage.heightAnchor.constraint(equalTo: smallImage.widthAnchor),
            smallImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            nameLabel.centerYAnchor.constraint(equalTo: smallImage.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: smallImage.trailingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            addressLabel.leadingAnchor.constraint(equalTo: smallImage.leadingAnchor),
            addressLabel.topAnchor.constraint(equalTo: smallImage.bottomAnchor, constant: 6),
            addressLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            addressLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            distanceLabel.topAnchor.constraint(equalTo: topAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    }
    
    func configure(with vm: RestaurantViewModel) {
        self.logoImage.image = vm.logoImage
        nameLabel.text = vm.name
        addressLabel.text = vm.address
        smallImage.image = vm.typeImage
        distanceLabel.text = vm.distance
    }
}
