//
//  InputTextField.swift
//  GeoFood
//
//  Created by Егор on 21.04.2021.
//

import UIKit

@IBDesignable
class InputTextField: UITextField {
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var gapPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor? = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
        
    private var textPadding: UIEdgeInsets {
        let p: CGFloat = leftPadding + gapPadding + (leftView?.frame.width ?? 0)
        return UIEdgeInsets(top: 15, left: p, bottom: 15, right: 5)
    }


    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    init() {
        super.init(frame: .zero)
        updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

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
