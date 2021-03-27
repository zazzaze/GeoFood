//
//  TextFieldWithConditions.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import UIKit

class TextFieldWithConditions: UIView {

    private var conditions: [TextFieldCondition]!
    private var textField = UITextField(frame: .zero)
    private var conditionViews = [ConditionView]()
    
    var text: String? {
        textField.text
    }
    
    var placeholder: String? {
        get {
            textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    var textColor: UIColor? {
        get {
            textField.textColor
        }
        set {
            textField.textColor = newValue
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        get {
            textField.attributedPlaceholder
        }
        set {
            textField.attributedPlaceholder = newValue
        }
    }
    
    var isSecureTextEntry: Bool {
        get {
            textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }
    
    var keyboardType: UIKeyboardType {
        get {
            textField.keyboardType
        }
        set {
            textField.keyboardType = newValue
        }
    }
    
    init(conditions: [TextFieldCondition]) {
        super.init(frame: .zero)
        self.conditions = conditions
        setUp()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        configureSubviews()
        addAllSubviews()
        initConstraints()
        isUserInteractionEnabled = true
        clipsToBounds = true
    }
    
    private func configureSubviews() {
        configureTextField()
        configureConditionViews()
    }
    
    private func configureTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(updateConditions), for: .editingChanged)
    }
    
    private func configureConditionViews() {
        for condition in conditions {
            conditionViews.append(ConditionView(frame: .zero, condition: condition))
        }
        conditionViews.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addAllSubviews() {
        addSubview(textField)
        conditionViews.forEach { addSubview($0) }
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        if conditionViews.count > 0 {
            NSLayoutConstraint.activate([
                conditionViews[0].topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
                conditionViews[0].leadingAnchor.constraint(equalTo: leadingAnchor),
                conditionViews[0].trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
            
            for i in 1..<conditionViews.count {
                conditionViews[i].topAnchor.constraint(equalTo: conditionViews[i - 1].bottomAnchor, constant: 10).isActive = true
                conditionViews[i].leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                conditionViews[i].trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
            }
            
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: conditionViews.last!.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: textField.bottomAnchor)
            ])
        }
    }
    
    @objc func updateConditions() {
        let text = textField.text!
        conditionViews.forEach { $0.updateView(by: text) }
    }
}
