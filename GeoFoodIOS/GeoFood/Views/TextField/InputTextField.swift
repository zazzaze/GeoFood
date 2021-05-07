//
//  InputTextField.swift
//  GeoFood
//
//  Created by Егор on 21.04.2021.
//

import UIKit

@IBDesignable
/// Поле ввода с синими полями и радиусами
class InputTextField: UITextField {
    
    /// Левый отступ
    @IBInspectable var leftPadding: CGFloat = 0
    /// Дополнительный отступ от картинки
    @IBInspectable var gapPadding: CGFloat = 0
    
    /// Цвет placeholder
    @IBInspectable var color: UIColor? = .lightGray {
        didSet {
            updateView()
        }
    }
    
    /// Картинка слева
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    /// Расчет расстояния слева для текста
    private var textPadding: UIEdgeInsets {
        let p: CGFloat = leftPadding + gapPadding + (leftView?.frame.width ?? 0)
        return UIEdgeInsets(top: 15, left: p, bottom: 15, right: 5)
    }

    
    /// Область начала для  текста
    /// - Parameter bounds: Область вью
    /// - Returns: Область для текста
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    /// Конструктор класса
    init() {
        super.init(frame: .zero)
        updateView()
    }
    
    /// Конструктор класса
    /// - Parameter coder: coder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Размеры текста
    /// - Parameter bounds: Общая область
    /// - Returns: Область текста
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    /// Размеры placeholder
    /// - Parameter bounds: Общая область
    /// - Returns: Область placeholder
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    /// Размеры  редактируемого текста
    /// - Parameter bounds: Общая область
    /// - Returns: Область редактируемого текста
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    /// Конфигурировать вью по данным
    private func updateView() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor(named: "dark_blue")?.cgColor
        self.layer.borderWidth = 1
        guard let image = leftImage else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
            return;
        }
        leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 40, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.tintColor = color
        leftView = imageView
        
        guard let color = color else {
            return;
        }
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
}
