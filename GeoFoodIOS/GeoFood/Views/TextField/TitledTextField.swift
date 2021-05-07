//
//  TitledTextField.swift
//  GeoFood
//
//  Created by Егор on 21.04.2021.
//

import UIKit

@IBDesignable
class TitledTextField: UIView {
    
    /// Заголовок текстового поля
    private let titleLabel = UILabel(frame: .zero)
    /// Поле ввода
    private let inputTextField = InputTextField()
    
    /// Цвет заголовка и поля ввода
    @IBInspectable var color: UIColor? = .gray
    
    /// Текст заголовка
    @IBInspectable var titleText: String? {
        didSet {
            updateView()
        }
    }
    
    /// Введенный текст
    var text: String {
        inputTextField.text ?? ""
    }
    
    /// Является ли текстовое поле защищенным
    @IBInspectable var isSecure: Bool = false {
        didSet {
            inputTextField.isSecureTextEntry = isSecure
        }
    }
    
    /// Картинка поля ввода
    @IBInspectable var textFieldImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    /// Placeholder поля ввода
    @IBInspectable var placeholder: String? {
        didSet {
            updateView()
        }
    }
    
    /// Конструктор
    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(inputTextField)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        updateView()
    }
    
    /// Конструктор
    /// - Parameter coder: кодер
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Инициализация констреинтов
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    /// Фабрика поля ввода для почты
    /// - Returns: TitledTextField для почты
    static func emailTextField() -> TitledTextField {
        let emailTextField = TitledTextField()
        emailTextField.placeholder = "example@example.com"
        emailTextField.textFieldImage = UIImage(named: "mail")
        emailTextField.color = UIColor(named: "dark_blue")
        emailTextField.titleText = "Email"
        emailTextField.inputTextField.keyboardType = .emailAddress
        return emailTextField
    }
    
    /// Фабрика поля ввода для пароля
    /// - Returns: TitledTextField для пароля
    static func passwordTextField() -> TitledTextField {
        let passwordTextField = TitledTextField()
        passwordTextField.titleText = "Пароль"
        passwordTextField.textFieldImage = UIImage(named: "lock")
        passwordTextField.color = UIColor(named: "dark_blue")
        passwordTextField.isSecure = true
        passwordTextField.placeholder = String(repeating: "\u{2022}", count: 8)
        return passwordTextField
    }
    
    /// Конфигуратор вью
    private func updateView() {
        self.isUserInteractionEnabled = true
        inputTextField.color = color
        inputTextField.gapPadding = 15
        inputTextField.leftPadding = 15
        titleLabel.text = titleText
        titleLabel.textColor = color
        inputTextField.placeholder = placeholder
        inputTextField.leftImage = textFieldImage
        inputTextField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
}
