//
//  TitledTextField.swift
//  GeoFood
//
//  Created by Егор on 21.04.2021.
//

import UIKit

@IBDesignable
class TitledTextField: UIView {
    
    private let titleLabel = UILabel(frame: .zero)
    private let inputTextField = InputTextField()
    
    @IBInspectable var color: UIColor? = .gray
    
    @IBInspectable var titleText: String? {
        didSet {
            updateView()
        }
    }
    
    var text: String {
        inputTextField.text ?? ""
    }
    
    @IBInspectable var isSecure: Bool = false {
        didSet {
            inputTextField.isSecureTextEntry = isSecure
        }
    }
    
    @IBInspectable var textFieldImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var placeholder: String? {
        didSet {
            updateView()
        }
    }

    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(inputTextField)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    static func emailTextField() -> TitledTextField {
        let emailTextField = TitledTextField()
        emailTextField.placeholder = "example@example.com"
        emailTextField.textFieldImage = UIImage(named: "mail")
        emailTextField.color = UIColor(named: "dark_blue")
        emailTextField.titleText = "Email"
        emailTextField.inputTextField.keyboardType = .emailAddress
        return emailTextField
    }
    
    static func passwordTextField() -> TitledTextField {
        let passwordTextField = TitledTextField()
        passwordTextField.titleText = "Пароль"
        passwordTextField.textFieldImage = UIImage(named: "lock")
        passwordTextField.color = UIColor(named: "dark_blue")
        passwordTextField.isSecure = true
        passwordTextField.placeholder = String(repeating: "\u{2022}", count: 8)
        return passwordTextField
    }
    
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
