//
//  NextButton.swift
//  GeoFood
//
//  Created by Егор on 21.04.2021.
//

import UIKit

@IBDesignable
/// Кнопка со стрелкой
class NextButton: UIButton {
    
    /// Конструктор класса
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    /// Конструктор класса
    /// - Parameter coder: Кодер
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Пересчитать размеры и положение объектов
    override func layoutSubviews() {
        super.layoutSubviews()
        imageEdgeInsets.left = self.bounds.width - self.imageView!.bounds.width - 10;
        titleEdgeInsets.right = self.imageView!.bounds.width + 15
        titleEdgeInsets.left = 1
    }
    
    /// Конфигурация внутренних вью
    private func setUp() {
        setTitleColor(UIColor(named: "dark_blue"), for: .normal)
        backgroundColor = UIColor(named: "light_green")
        imageView?.tintColor = UIColor(named: "dark_blue")
        self.layer.cornerRadius = 10
        setImage(UIImage(named: "right_arrow"), for: .normal)
    }
}
