//
//  ConditionView.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import UIKit

class ConditionView: UIView {

    private var condition: TextFieldCondition!
    var imageView = UIImageView()
    var textLabel = UILabel()
    
    override init(frame: CGRect) {
        fatalError("Init with frame does not supported")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init with frame does not supported")
    }
    
    required init(frame: CGRect, condition: TextFieldCondition) {
        super.init(frame: frame)
        self.condition = condition
        setUp()
    }
    
    required init?(coder: NSCoder, condition: TextFieldCondition) {
        super.init(coder: coder)
        self.condition = condition
        setUp()
    }
    
    func updateView(by text: String) {
        if condition.checker(text) {
            imageView.image = UIImage(systemName: "checkmark.circle")
            imageView.tintColor = .systemGreen
        } else {
            imageView.image = UIImage(systemName: "xmark.circle")
            imageView.tintColor = .red
        }
    }
    
    private func setUp() {
        isUserInteractionEnabled = true
        configureViews()
        addAllSubviews()
        initConstraints()
    }
    
    private func configureViews() {
        configureImageView()
        configureTextLabel()
    }
    
    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "xmark.circle")
        imageView.tintColor = .red
        imageView.autoresizingMask = .flexibleHeight
    }
    
    private func configureTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = condition.description
        textLabel.textColor = .darkGray
    }
    
    private func addAllSubviews() {
        addSubview(imageView)
        addSubview(textLabel)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            
            bottomAnchor.constraint(equalTo: textLabel.bottomAnchor)
        ])
    }
}
