//
//  RestaurantHeaderView.swift
//  GeoFood
//
//  Created by Егор on 23.04.2021.
//

import UIKit

/// Вью информации о кафе
class RestaurantHeaderView: UIView {
    
    /// Картинка кафе
    private let logoImage = UIImageView()
    /// Картинка типа кафе
    private let smallImage = UIImageView()
    /// Название кафе
    private let nameLabel = UILabel()
    /// Адрес кафе
    private let addressLabel = UILabel()
    /// Расстояние пользователя до кафе
    private let distanceLabel = UILabel()
    
    /// Конструктор
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    /// Конструктор
    /// - Parameter frame: Фрейм
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    /// Конструктор
    /// - Parameter coder: Кодер
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    /// Конфигурировать представление вью
    private func setupUI() {
        configureSubviews()
        addAllSubviews()
    }
    
    /// Конфигурировать представление внутренних вью
    private func configureSubviews() {
        configureLogoImage()
        configureSmallImage()
        configureNameLabel()
        configureAddressLabel()
        configureDistanceLabel()
    }
    
    /// Конфигурировать логотип компании
    private func configureLogoImage() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.layer.cornerRadius = 13
        logoImage.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        logoImage.layer.shadowRadius = 1
        logoImage.layer.shadowOffset = CGSize(width: 0, height: 4)
        logoImage.layer.masksToBounds = true
    }
    
    /// Конфигурировать картинку типа компании
    private func configureSmallImage() {
        smallImage.translatesAutoresizingMaskIntoConstraints = false
        smallImage.tintColor = UIColor(named: "dark_blue")
    }
    
    /// Конфигурировать текст названия компании
    private func configureNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = UIColor(named: "dark_blue")
    }
    
    /// Конфигурировать текст адреса компании
    private func configureAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        addressLabel.textColor = .lightGray
    }
    
    /// Конфигурировать текст расстояния
    private func configureDistanceLabel() {
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        distanceLabel.textColor = .lightGray
    }
    
    /// Добавить все вью
    private func addAllSubviews() {
        addSubview(logoImage)
        addSubview(smallImage)
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(distanceLabel)
    }
    
    /// Перерисовать вью
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
    
    /// Конфигурировать вью по модели представления кафе
    /// - Parameter vm: Модель представления кафе
    func configure(with vm: RestaurantViewModel) {
        self.logoImage.image = vm.logoImage
        nameLabel.text = vm.name
        addressLabel.text = vm.address
        smallImage.image = vm.typeImage
        distanceLabel.text = vm.distance
    }
}
