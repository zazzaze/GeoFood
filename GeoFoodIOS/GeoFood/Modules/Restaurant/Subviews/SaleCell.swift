//
//  SailCell.swift
//  GeoFood
//
//  Created by Егор on 24.04.2021.
//

import UIKit

/// Ячейка таблицы с акцией
class SaleCell: UITableViewCell {
    
    /// Задняя картинка для акции
    let backImage = UIImageView()
    /// Внешняя вью
    let frontView = UIView()
    /// Название акции
    let saleName = UILabel()
    /// Промокод акции
    let saleCode = UILabel()
    /// Цена акции
    let salePrice = UILabel()
    
    
    /// Конструктор
    /// - Parameters:
    ///   - style: Стиль ячейки
    ///   - reuseIdentifier: id ячейки
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    /// Конструктор
    /// - Parameter coder: кодер
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Вью загрузилось из storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSubviews()
        addAllSubviews()
    }
    
    /// Конфигурировать вью
    private func setupUI() {
        configureSubviews()
        addAllSubviews()
    }
    
    /// Конфигурировать внутренние вью
    private func configureSubviews() {
        layer.cornerRadius = 17
        contentView.layer.cornerRadius = 17
        contentView.layer.masksToBounds = true
        let shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 17)
        contentView.layer.shadowPath = shadowPath.cgPath
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 6
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundColor = .clear
        
        backImage.translatesAutoresizingMaskIntoConstraints = true
        backImage.layer.masksToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        frontView.layer.cornerRadius = layer.cornerRadius
        frontView.translatesAutoresizingMaskIntoConstraints = false
        frontView.layer.cornerRadius = 17
        frontView.backgroundColor = .white
        
        saleName.translatesAutoresizingMaskIntoConstraints = false
        saleName.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        saleName.textColor = UIColor(named: "dark_blue")
        saleName.numberOfLines = 2
        saleName.lineBreakMode = .byWordWrapping
        
        saleCode.translatesAutoresizingMaskIntoConstraints = false
        saleCode.font = UIFont.systemFont(ofSize: 13, weight: .light)
        saleCode.textColor = UIColor(named: "dark_blue")
        
        salePrice.translatesAutoresizingMaskIntoConstraints = false
        salePrice.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        salePrice.textColor = UIColor(named: "dark_blue")
    }
    
    /// Добавить все вью
    private func addAllSubviews() {
        contentView.addSubview(backImage)
        contentView.addSubview(frontView)
        frontView.addSubview(saleName)
        frontView.addSubview(saleCode)
        frontView.addSubview(salePrice)
    }
    
    /// Перерисовать вью
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            frontView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            frontView.topAnchor.constraint(equalTo: topAnchor),
            frontView.trailingAnchor.constraint(equalTo: trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            saleName.topAnchor.constraint(equalTo: frontView.topAnchor, constant: 20),
            saleName.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 15),
            saleName.trailingAnchor.constraint(lessThanOrEqualTo: salePrice.leadingAnchor, constant: -5),
            
            saleCode.topAnchor.constraint(equalTo: saleName.bottomAnchor, constant: 2),
            saleCode.leadingAnchor.constraint(equalTo: saleName.leadingAnchor),
            saleCode.trailingAnchor.constraint(equalTo: frontView.trailingAnchor),
            saleCode.bottomAnchor.constraint(lessThanOrEqualTo: frontView.bottomAnchor),
            
            salePrice.topAnchor.constraint(equalTo: frontView.topAnchor, constant: 20),
            salePrice.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -11),
        ])
        backImage.frame = CGRect(x: 0, y: 0, width: 85, height: contentView.frame.height)
    }
    
    /// Сконфигурировать вью по модели представления акции
    /// - Parameter vm: Модель представления
    func configure(with vm: SaleViewModel) {
        self.backImage.image = vm.image
        saleName.text = vm.name
        salePrice.text = vm.price
        saleCode.text = vm.code
    }
}
