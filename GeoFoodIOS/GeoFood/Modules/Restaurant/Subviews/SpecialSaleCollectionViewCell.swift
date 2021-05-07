//
//  SpecialSaleCollectionViewCell.swift
//  GeoFood
//
//  Created by Егор on 28.04.2021.
//

import UIKit
import CoreImage.CIFilterBuiltins

/// Ячейка специальной акции
class SpecialSaleCollectionViewCell: UICollectionViewCell {
    /// Контекст для генерации qr-кода
    private let context = CIContext()
    /// Фильтр для генерации qr-кода
    private let filter = CIFilter.qrCodeGenerator()
    
    
    /// Картинка акции
    private let image = UIImageView()
    /// Название акции
    private let title = UILabel()
    /// Промокод акции
    private let codeLabel = UILabel()
    /// Кнопка получения акции
    private let getButton = NextButton()
    /// Вью акции
    private let frontView = UIView()
    /// Вью qr-кода
    private let backView = UIView()
    /// Картинка qr-кода
    private let qrImage = UIImageView()
    /// Кнопка закрытия qr-кода
    private let closeQRButton = UIImageView()
    
    /// Открыта ли вью акции
    private var isFront = true
    
    /// Конструктор
    /// - Parameter frame: Фрейм ячейки
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    /// Конструктор
    /// - Parameter coder: кодер
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    /// Конфигурировать вью
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 17
        let shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 17)
        contentView.layer.shadowPath = shadowPath.cgPath
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 6
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 17
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        frontView.addSubview(image)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor(named: "dark_blue")
        title.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        title.numberOfLines = 3
        title.lineBreakMode = .byWordWrapping
        frontView.addSubview(title)
        
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.textColor = UIColor(named: "dark_blue")
        codeLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        frontView.addSubview(codeLabel)
        
        getButton.translatesAutoresizingMaskIntoConstraints = false
        getButton.setTitle("Получить", for: .normal)
        getButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        getButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        frontView.addSubview(getButton)
        
        qrImage.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(qrImage)
        
        closeQRButton.translatesAutoresizingMaskIntoConstraints = false
        closeQRButton.image = UIImage(systemName: "xmark.circle")
        closeQRButton.tintColor = .lightGray
        backView.addSubview(closeQRButton)
        
        frontView.backgroundColor = .white
        backView.backgroundColor = .white
        frontView.layer.cornerRadius = 17
        backView.layer.cornerRadius = 17
        
        frontView.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        contentView.addSubview(frontView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        backView.addGestureRecognizer(tapGesture)
    }
    
    /// Отрисовать внутренние вью
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: contentView.topAnchor),
            frontView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            frontView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            image.topAnchor.constraint(equalTo: frontView.topAnchor, constant: 12),
            image.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 12),
            image.heightAnchor.constraint(equalToConstant: 136),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),

            title.topAnchor.constraint(equalTo: image.topAnchor),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            title.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -15),

            codeLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            codeLabel.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            codeLabel.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            getButton.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -15),
            getButton.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            getButton.heightAnchor.constraint(equalToConstant: 50),
            getButton.widthAnchor.constraint(equalToConstant: 120),
            
            
            qrImage.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            qrImage.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            qrImage.heightAnchor.constraint(equalToConstant: 100),
            qrImage.widthAnchor.constraint(equalTo: qrImage.heightAnchor),
            
            closeQRButton.heightAnchor.constraint(equalToConstant: 20),
            closeQRButton.widthAnchor.constraint(equalTo: closeQRButton.heightAnchor),
            closeQRButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            closeQRButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10)
            
        ])
    }
    
    /// Событие нажатия на кнопку открытия/закрытия акции
    @objc private func didTapButton() {
        let fromView = isFront ? frontView : backView
        let toView = isFront ? backView : frontView
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.curveEaseInOut, .transitionFlipFromLeft, .showHideTransitionViews])
        isFront.toggle()
    }
    
    /// Сконфигурировать вью по модели представления акции
    /// - Parameter vm: Модель представления акции
    func configure(with vm: SaleViewModel) {
        title.text = vm.name
        codeLabel.text = vm.code
        self.image.image = vm.image
        qrImage.image = generateQRCode(from: vm.code)
    }
    
    /// Генерация картинки qr-кода
    /// - Parameter string: Строка qr-кода
    /// - Returns: Картинка с qr-кодом
    private func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qrFilter.setValue(data, forKey: "inputMessage")
        guard let qrImage = qrFilter.outputImage?.transformed(by: CGAffineTransform(scaleX: 10, y: 10)) else { return nil }
        
        return UIImage(ciImage: qrImage)
    }
    
}
